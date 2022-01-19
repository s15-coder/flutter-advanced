const mongoose = require('mongoose')

const connectDB = async() => {
    try {
        await mongoose.connect(process.env.DB_PATH, )
        console.log("DATABASE CONNECTED")

    } catch (error) {
        console.log(error)
        throw Error("Error connecting to database")
    }
}
module.exports = { connectDB };