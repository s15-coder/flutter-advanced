const { response } = require("express")
const { validationResult, body } = require("express-validator")
const bcrypt = require('bcryptjs')
const User = require('../models/user')
const { generateJwt } = require("../helpers/jwt")
const { json } = require("express/lib/response")
const register = async(req, res = response) => {
    try {
        const { email, password } = req.body;

        //Valitate if the email is unique
        const existUser = await User.findOne({ email })
        if (existUser) {
            return res.status(500).
            json({
                ok: false,
                mes: "Email already exists"
            })
        }

        //Create user instance based on body 
        const user = User(req.body)

        //Encrpyt password
        const salt = bcrypt.genSaltSync()
        user.password = bcrypt.hashSync(password, salt)

        //Save user instance
        await user.save();

        //Generate JWT
        const token = await generateJwt(user.id)

        return res.json({
            ok: true,
            user,
            token
        })
    } catch (error) {
        console.log(error)
        return res.status(500).json({
            ok: false,
            msg: 'Server error'
        });
    }
}
const login = async(req, res = response) => {
    try {
        const { email, password } = req.body;
        const userFound = await User.findOne({ email })
            //If the email matches with any user
        if (userFound) {
            //Validate hashed password against received
            const isTheSamePassword = bcrypt.compareSync(password, userFound.password);
            if (isTheSamePassword) {

                //Generate JWT
                const token = await generateJwt(userFound.id)

                return res.json({
                    ok: true,
                    userFound,
                    token
                })
            } else {
                return res.json({
                    ok: false,
                    msg: "Invalid credentials"
                })
            }
        }

        return res.json({
            ok: false,
            msg: "Invalid credentials"
        })
    } catch (error) {
        console.log(error)
        return res.status(500).json({
            ok: false,
            msg: 'Server error'
        });
    }
}

const renew = async(req, res) => {
    const { uuid } = req.body
    const user = await User.findOne({ uuid })

    //Generate new token
    const token = await generateJwt(user.uuid)
    return res.json({
        ok: true,
        user,
        token
    })
}
module.exports = { register, login, renew }