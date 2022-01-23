const Message = require('../models/message');
const User = require('../models/user')
const clientConnected = async(uuid = '') => {
    const user = await User.findById(uuid)
    user.online = true;
    await user.save();
    return user;
}
const clientDisconnected = async(uuid = '') => {
    const user = await User.findById(uuid)
    user.online = false;
    await user.save();
    return user;
}
const saveMessage = async(payload) => {
    /**
     {
         from : "",
         to: "",
         message: ""
     }
     */
    try {

        const message = Message(payload)
        await message.save()
        return true

    } catch (error) {
        return false
    }
}
module.exports = {
    clientDisconnected,
    clientConnected,
    saveMessage,
}