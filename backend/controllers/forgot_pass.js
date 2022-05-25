const forgotPassModel = require("../models/forgot_pass.js");
const jwt = require("jsonwebtoken");
const { json } = require("express");
const nodemailer = require("nodemailer");
const bcrypt = require("bcrypt");
const registerModel = require("../models/register.js");
const saltRounds = 10;

async function mailTransport(code, email_address) {
  let transporter = nodemailer.createTransport({
    host: "mail.gaurav-poudel.com.np",
    port: 465,
    secure: true, // true for 465, false for other ports
    auth: {
      user: "fmij@gaurav-poudel.com.np", // generated ethereal user
      pass: "[;(}wrfhHq2B", // generated ethereal password
    },
  });

  // send mail with defined transport object
  await transporter.sendMail({
    from: '" Teispace" <fmij@gaurav-poudel.com.np>', // sender address
    to: `${email_address}`, // list of receivers
    subject: "[Teispace] Password reset code.", // Subject line
    // text: "", // plain text body
    html: `<p>
      Please find password reset code below:<br><br>
      <h4>Your Reset Code is: <h3>${code}</h3>. It expires in one hour.</h4>
       </p>`, // html body
  });
}

function generateToken(username, otp) {
  let token = jwt.sign(
    {
      username: username,
      otp: otp,
    },
    "secret",
    { expiresIn: "1h" }
  );
  return token;
}

async function sendMail(req, res) {
  let email_address = req.body.email_address;
  try {
    if (email_address) {
      let isUserPresent = await registerModel.isUserPresent(email_address);
      if (isUserPresent.length > 0) {
        let otp = createOTP();
        var token = await generateToken(email_address, otp);
        console.log(token);
        await mailTransport(otp, email_address);
        res.status(200);
        res.json({
          message: "Reset code has been sent to your email",
          token: token,
          status: "success",
        });
      } else {
        res.status(400);
        res.json({
          message: "User does not exist",
          status: "failed",
        });
      }
    } else {
      res.status(400);
      res.json({
        message: "Please provide email",
        status: "failed",
      });
    }
  } catch (error) {
    res.status(400);
    res.json({
      message: "SOmething went wrong.",
      status: "failed",
    });
  }
}

function createOTP() {
  var otp = "";
  for (let i = 0; i < 5; i++) {
    let randomNumber = Math.floor(Math.random() * 10);
    otp += randomNumber;
  }
  return otp;
}

function validateOTP(token, otp, res) {
  try {
    let data = jwt.verify(token, "secret");
    console.log(data);
    console.log(otp);
    if (data.otp == otp) {
      res.status(200);
      res.json({
        status: "success",
        verified: true,
        message: "You can now change password",
      });
    } else {
      res.status(400);
      res.json({
        code: 400,
        status: "failed",
        verified: false,
        message: "OTP does not match.",
      });
    }
  } catch (error) {
    res.status(400);
    res.json({
      status: "failed",
      verified: false,
      message: "Something went wrong",
    });
  }
}

async function otpVerification(req, res) {
  let response = req.body;
  let token = response.token;
  let OTP = response.otp;

  if (token && OTP) {
    let data = validateOTP(token, OTP, res);
  } else {
    res.status(400);
    res.json({
      message: "Insufficient Information",
      status: "failed",
    });
  }
}

async function changePassword(req, res) {
  let newpassword = req.body.newpassword;
  let email_address = req.body.email_address;

  if (email_address && newpassword) {
    const bycryptPassword = await bcrypt.hash(newpassword, saltRounds); //password Encryption
    console.log(bycryptPassword);
    try {
      var data = await forgotPassModel.updatePassword(
        email_address,
        bycryptPassword
      );
      res.status(200);
      res.json({
        message: "Password has been changed Successfully.",
        status: "success",
      });
    } catch (error) {
      console.log(error);
      res.status(400);
      res.json({
        message: "Something Went Wrong!",
        status: "Failed",
      });
    }
  }
}

module.exports.changePassword = changePassword;
module.exports.otpVerification = otpVerification;
module.exports.sendMail = sendMail;
