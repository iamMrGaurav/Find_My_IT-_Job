const express = require("express");
const router = express.Router();
const registerController = require("../controllers/register.js");
const jwt = require("jsonwebtoken");

router.post("/", registerController.registerUser);
router.get("/confirm/:token", registerController.confirmUser);
module.exports = router;
