const { clientConnected, clientDisconnected, saveMessage } = require('../controllers/socket_controller');
const { io } = require('../index');
const { validateJwt } = require('../middlewares/validate_jwt');


// Mensajes de Sockets
io.on('connection', client => {

    //Auth sockets with JWT
    const token = client.handshake.headers['authorization'];
    const { authOk, uuid } = validateJwt(token);

    //If jwt is not valid disconnect client
    if (!authOk) {
        return client.disconnect()
    }
    console.log('Cliente conectado');

    //At this point user is already authenticated
    clientConnected(uuid);

    client.join(uuid)
        //Listen new messages
    client.on('personal-message', async(payload) => {
        await saveMessage(payload)
        io.in(payload.to).emit('personal-message', payload)
    })

    client.on('disconnect', async() => {
        clientDisconnected(uuid);
        console.log('Cliente desconectado');

    });

    client.on('mensaje', (payload) => {
        console.log('Mensaje', payload);

        io.emit('mensaje', { admin: 'Nuevo mensaje' });

    });


});