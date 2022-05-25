const { Router } = require("express");
const express = require("express");
const router = express.Router();
const loginController = require("../controllers/login.js");
const authenticate = require("../authenticate.js");
const jwt = require("jsonwebtoken");

router.post("/", loginController.getLoginDetails);
router.post("/admin", loginController.getAdminLoginDetails);

router.get("/authenticate", authenticate.authentication, (req, res) => {
  let token = req.query.token;
  console.log(token);
  var decoded = jwt.verify(token, "argo");
  res.json({
    success: "true",
    data: decoded,
  });
});

module.exports = router;
