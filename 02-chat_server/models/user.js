const { Schema, model } = require('mongoose');
const userSchema = Schema({
    name: {
        type: String,
        required: true,
    },
    password: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
        unique: true
    },
    online: {
        type: Boolean,
        default: false
    }
})
userSchema.method('toJSON', function() {
    const { password, _id, __v, online, ...object } = this.toObject()
    object.uuid = _id;
    return object;

})
module.exports = model('User', userSchema)