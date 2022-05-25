var jwt = require("jsonwebtoken");

function authentication(req, res, next) {
  let token = req.query.token;
  console.log(token);
  try {
    jwt.verify(token, "argo");
    next();
  } catch (error) {
    console.log(error);
    res.status(400);
    res.json({
      status: "Failed",
      message: "User not authenticated",
    });
  }
}

module.exports.authentication = authentication;
