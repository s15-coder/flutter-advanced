/**
 * /api/users
 */
const { Router } = require('express');
const { getUsers } = require('../controllers/users');
const { validateJwt, validateRequestJwt } = require('../middlewares/validate_jwt');
const router = Router()

router.get('/', validateRequestJwt, getUsers)

module.exports = router