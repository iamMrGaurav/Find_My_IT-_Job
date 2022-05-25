const { Router } = require("express");
const express = require("express");
const router = express.Router();
const googleController = require("../controllers/googlelogin.js");

router.post("/validate", googleController.validateUser);
router.post("/chooserole", googleController.updateRole);

module.exports = router;
