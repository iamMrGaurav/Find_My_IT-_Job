const express = require("express");
const router = express.Router();
const jwt = require("jsonwebtoken");
const { application, response } = require("express");
const forgotPassController = require("../controllers/forgot_pass.js");

// router.get("/passwordreset",async (req,res)=>{
//     res.json(users);
// });

router.post(
  "/passwordreset/changepassword",
  forgotPassController.changePassword
);
router.post("/passwordreset", forgotPassController.sendMail);
router.post("/passwordreset/verifyotp", forgotPassController.otpVerification);

module.exports = router;
