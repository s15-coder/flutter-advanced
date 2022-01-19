const { response } = require('express');
const jwt = require('jsonwebtoken')

const validateJwt = (req, res = response, next) => {
    try {

        const token = req.header('authorization')
        if (token) {
            const payload =
                jwt.verify(token, process.env.JWT_SECRET)
            req.body.uuid = payload.uuid;
            return next();
        }
        return res.status(401).json({
            ok: false,
            'msg': 'Authorization not provided',
        })
    } catch (error) {
        console.log(error)
        return res.json({
            ok: false,
            'msg': 'Not authorized',

        })

    }
}

module.exports = {
    validateJwt
}