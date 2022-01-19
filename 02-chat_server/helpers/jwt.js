const jwt = require('jsonwebtoken')

const generateJwt = (uuid) => {
    return new Promise((resolve, reject) => {
        const payload = { uuid }
        jwt.sign(
            payload,
            process.env.JWT_SECRET, {
                expiresIn: '12h'
            }, (err, token) => {
                if (err) {
                    reject(err)
                } else {
                    resolve(token)
                }
            })
    });
}

module.exports = { generateJwt };