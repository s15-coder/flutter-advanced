const { response } = require('express')
const Message = require('../models/message')
const getMessages = async(req, res = response) => {
    const receiverId = req.params.receiverId
    const myId = req.body.uuid
    const last30Messages = await Message.find({
        $or: [{
            from: receiverId,
            to: myId,
        }, {
            from: myId,
            to: receiverId,
        }, ]

    }).sort({ createdAt: "desc" }).limit(30)
    return res.json({
        ok: true,
        messages: last30Messages
    })
}
module.exports = { getMessages }