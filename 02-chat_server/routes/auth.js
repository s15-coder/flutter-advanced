/**
 *  /api/login
 */
const { Router } = require('express');
const { check } = require('express-validator');
const { register, login, renew } = require('../controllers/auth');
const { validateFields } = require('../middlewares/validate_fields');
const { validateJwt } = require('../middlewares/validate_jwt');

const router = Router()

router.post('/new', [
        check('name').not().isEmpty(),
        check('email', "Email is required").not().isEmpty().isEmail(),
        check('password').not().isEmpty().isLength({ min: 6 }),
        validateFields,
    ],
    register
);

router.post('/', [
        check('email').not().isEmpty().isEmail(),
        check('password').not().isEmpty(),
        validateFields,
    ],
    login
);
router.post('/renew', [
        validateJwt,
        validateFields,
    ],
    renew
);


module.exports = router;