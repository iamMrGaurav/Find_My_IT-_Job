const express = require("express");
const loginModel = require("../models/login.js");
const bcrypt = require("bcrypt");
var jwt = require("jsonwebtoken");

async function getLoginDetails(req, res) {
  let email_address = req.body.email_address;
  let password = req.body.password;
  if (email_address && password) {
    try {
      var data = await loginModel.getLogin(email_address);
    } catch (error) {
      res.status(400);
      res.json({
        message: "Something Went Wrong!",
        status: "failed",
      });
    }

    if (data.length > 0) {
      var username = data[0].user_name;
      var ispasswordValidated = bcrypt.compareSync(password, data[0].password);
      if (ispasswordValidated) {
        if (data[0].role == 1) {
          var company_id = await loginModel.getCompanyId(data[0].user_id);
          if (company_id.length > 0) {
            let token = jwt.sign(
              {
                user_id: data[0].user_id,
                email: email_address,
                company_id: company_id[0]["comapny_id"],
                role: data[0].role,
              },
              "argo",
              { expiresIn: "5d" }
            );

            res.status(200);
            res.json({
              message: `${username},You have login successfully`,
              username: data[0].user_name,
              token: token,
              company_id: company_id[0]["comapny_id"],
              role: data[0].role,
              status: "success",
            });
          } else {
            res.status(200);
            res.json({
              message: "company",
              user_id: data[0].user_id,
              status: "success",
            });
          }
        } else {
          var seeker_id = await loginModel.getSeekerId(data[0].user_id);

          if (seeker_id.length > 0) {
            let token = jwt.sign(
              {
                user_id: data[0].user_id,
                email: email_address,
                seeker_id: seeker_id[0]["seeker_id"],
                role: data[0].role,
              },
              "argo",
              { expiresIn: "5d" }
            );

            res.status(200);
            res.json({
              message: `${username},You have login successfully`,
              username: data[0].user_name,
              token: token,
              seeker_id: seeker_id[0]["seeker_id"],
              role: data[0].role,
              user_id: data[0].user_id,
              status: "success",
            });
          } else {
            res.status(200);
            res.json({
              message: "seeker",
              user_id: data[0].user_id,
              status: "success",
            });
          }
        }
      } else {
        res.status(400);
        res.json({
          message: "Password does not Match.",
          status: "failed",
        });
      }
    } else {
      res.status(400);
      res.json({
        message: "Invalid Email address.",
        status: "failed",
      });
    }
  } else {
    res.status(400);
    res.json({
      message: "Please fill your login details.",
      status: "failed",
    });
  }
}

async function getAdminLoginDetails(req, res) {
  let loginData = req.body;

  let username = req.body.username;
  let password = req.body.password;
  console.log(username);

  if (username && password) {
    try {
      var data = await loginModel.getAdminLogin(username);
      console.log(data);
    } catch (error) {
      res.status(400);
      res.json({
        message: "Something Went Wrong!",
        status: "failed",
      });
    }
    if (data.length > 0) {
      var admin_username = data[0].username;
      var admin_password = data[0].password;

      if (username == admin_username) {
        if (admin_password == password) {
          res.status(200);
          res.json({
            message: `You have login successfully`,
            username: data[0].username,
            status: "success",
          });
        } else {
          res.status(400);
          res.json({
            message: "password does not match.",
            status: "failed",
          });
        }
      } else {
        res.status(400);
        res.json({
          message: "username does not match.",
          status: "failed",
        });
      }
    } else {
      res.status(400);
      res.json({
        message: "Invalid Details",
        status: "failed",
      });
    }
  } else {
    res.status(400);
    res.json({
      message: "Please fill your login details.",
      status: "failed",
    });
  }
}

module.exports.getLoginDetails = getLoginDetails;
module.exports.getAdminLoginDetails = getAdminLoginDetails;
