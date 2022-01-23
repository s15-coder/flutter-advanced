const { Schema, model } = require('mongoose');
const UserSchema = Schema({
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
UserSchema.method('toJSON', function() {
    const { password, _id, __v, ...object } = this.toObject()
    object.uuid = _id;
    return object;

})
module.exports = model('User', UserSchema)