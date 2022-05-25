const { Router } = require("express");
const express = require("express");
const router = express.Router();
const setupController = require("../controllers/setup_profile.js");

router.post("/insert", setupController.setupProfile);
module.exports = router;
