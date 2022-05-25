const connection = require("../config/configuration.js");

async function getUserDetails(email_address) {
  var query = `SELECT * FROM users WHERE email_address='${email_address}'`;
  return new Promise((resolve, reject) => {
    connection.query(query, (err, result) => {
      if (err) {
        reject(err);
      } else {
        resolve(result);
      }
    });
  });
}

exports.updatePassword = (email_address, password) => {
  let query = `UPDATE users SET password='${password}' WHERE email_address='${email_address}'`;
  return new Promise((resolve, reject) => {
    connection.query(query, (err, result) => {
      if (err) {
        reject(err);
      } else {
        resolve(result);
      }
    });
  });
};

module.exports.getUserDetails = getUserDetails;
