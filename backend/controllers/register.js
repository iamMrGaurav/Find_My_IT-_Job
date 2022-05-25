const express = require("express");
const registerModel = require("../models/register.js");
const bcrypt = require("bcrypt");
const saltRounds = 10;
const jwt = require("jsonwebtoken");
const { json, urlencoded, application } = require("express");
const nodemailer = require("nodemailer");
const { changeVerificationStatus } = require("../models/register.js");

async function confirmUser(req, res) {
  let token = req.params.token;
  try {
    var decoded = jwt.verify(token, "secret");
    let username = decoded.username;
    let result = await changeVerificationStatus(username);
    if (result.changedRows == 1 && result.affectedRows == 1) {
      res.send(`<h1>User ${username} is verified successfully.</h1>`);
    } else if (result.changedRows == 0 && result.affectedRows == 1) {
      res.send({
        result: result,
        message: "Already verified",
        status: "success",
      });
    }
  } catch (err) {
    res.send({
      message: "Error",
      status: "failed",
    });
  }
}

async function registerUser(req, res) {
  let user = req.body;
  console.log(user.role);
  const userStatus = await registerModel.isUserPresent(req.body.email_address);
  if (userStatus.length > 0) {
    if (userStatus[0].verification_status == "false") {
      res.status(400);
      res.json({
        message: "User Already Exist",
        status: "failed",
      });
    } else {
      res.status(400);
      res.json({
        message: "User Already Exist with Verified status",
        status: "failed",
      });
    }
  } else {
    try {
      const password = await bcrypt.hash(user.password, saltRounds); //password Encryption
      let response = await registerModel.registerUser(
        user.user_name,
        user.email_address,
        password,
        user.role,
        "false",
        2
      );
      if ((response.affectedRows = 1)) {
        let token = createToken(user.user_name);
        let mail = await sendMail(user.email_address, token);
        res.json({
          result: response,
          message: "Please Verify your Email.",
          mail: mail,
          status: "success",
        });
      } else {
        res.json({
          message: "Registration Failed, Please try againn.",
          status: "failed",
        });
      }
    } catch (error) {
      console.log(error);
      res.status(400);
      res.send({
        message: "Registration Failed",
        status: "failed",
      });
    }
  }
}

async function sendMail(email_address, token) {
  let transporter = nodemailer.createTransport({
    host: "mail.gaurav-poudel.com.np",
    port: 465,
    secure: true, // true for 465, false for other ports
    auth: {
      user: "fmij@gaurav-poudel.com.np", // generated ethereal user
      pass: "[;(}wrfhHq2B", // generated ethereal password
    },
  });

  await transporter.sendMail({
    from: '"FMIJ" <fmij@gaurav-poudel.com.np>',
    to: `${email_address}`,
    subject: "[FMIJ] Verify your Mail.",
    html: `<p>Hello,<br>
      Please verify your email:<br><br>
      https://fypapi.gaurav-poudel.com.np/register/confirm/${token}
       </p>`,
  });
}

function createToken(username) {
  let token = jwt.sign(
    {
      username: username,
    },
    "secret",
    { expiresIn: "2h" }
  );
  return token;
}

module.exports.registerUser = registerUser;
module.exports.confirmUser = confirmUser;
