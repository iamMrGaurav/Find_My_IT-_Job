const jwt = require("jsonwebtoken");
const loginModel = require("../models/login.js");
const googleModel = require("../models/googlelogin.js");
const registerModel = require("../models/register.js");

async function validateUser(req, res) {
  let user = req.body;
  let email_address = user.email;

  if (email_address && user.displayName && user.UId) {
    try {
      var data = await loginModel.getLogin(email_address);

      if (data.length > 0) {
        var type = data[0].type;
        if (type == 2) {
          res.status(200);
          res.json({
            message: "Email is already register",
            status: "success",
          });
        } else {
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
                message: `You have login successfully`,
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
                role: data[0].role,
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
                message: `You have login successfully`,
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
                role: data[0].role,
              });
            }
          }
        }
      } else {
        let totalId = await googleModel.getTotalRows();
        let newId = totalId[0].count + 1;
        let username = user.displayName + newId;
        let result = await googleModel.GoogleRegister(
          username,
          email_address,
          user.UId,
          "true",
          1
        );
        validateUser(req, res);
      }
    } catch (error) {
      res.status(400);
      res.json({
        message: "Something Went Wrong",
        status: "failed",
      });
    }
  } else {
    res.json({
      message: "Invalid Data",
      status: "failed",
    });
  }
}

function createToken(email) {
  let token = jwt.sign(
    {
      email_address: email,
    },
    "secret",
    { expiresIn: "1h" }
  );
  return token;
}

async function updateRole(req, res) {
  let data = req.body;
  console.log(data.role);

  if (data.role && data.email_address) {
    try {
      var response = await googleModel.updateRole(
        data.role,
        data.email_address
      );
      if ((response.affectedRows = 1)) {
        res.status(200);
        res.json({
          message: "Your Role Updated",
          status: "success",
        });
      } else {
        res.status(400);
        res.json({
          message: "Invalid",
          status: "success",
        });
      }
    } catch (error) {
      res.status(400);
      res.json({
        message: "Something Went Wrong",
        status: "failed",
      });
    }
  } else {
    res.status(400);
    res.json({
      message: "Invalid Fields",
      status: "failed",
    });
  }
}

module.exports.updateRole = updateRole;
module.exports.validateUser = validateUser;
