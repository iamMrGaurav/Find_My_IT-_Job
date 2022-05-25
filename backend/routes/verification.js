const { Router } = require("express");
const express = require("express");
const router = express.Router();
const verificationController = require("../controllers/verification.js");


router.post("/", verificationController.verify);


module.exports = router;
