/**
 * /api/messages
 */
const { Router } = require('express');
const { getMessages } = require('../controllers/messages');
const { validateRequestJwt } = require('../middlewares/validate_jwt');
const router = Router()

router.get('/:receiverId', validateRequestJwt, getMessages)

module.exports = router