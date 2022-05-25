const connection = require("../config/configuration.js");

async function getTotalRows() {
  let query = `SELECT COUNT(*) as count FROM users;`;
  return new Promise((resolve, reject) => {
    connection.query(query, (err, results) => {
      if (err) {
        reject(err);
      } else {
        resolve(results);
      }
    });
  });
}

function GoogleRegister(
  userName,
  email_address,
  password,
  verification_status,
  type
) {
  var query = `INSERT INTO users(user_name, email_address, password, verification_status, type) 
  VALUES ('${userName}','${email_address}','${password}','${verification_status}',${type})`;
  return new Promise((resolve, reject) => {
    connection.query(query, (err, results) => {
      if (err) {
        reject(err);
      } else {
        resolve(results);
      }
    });
  });
}

exports.updateRole = (role, email) => {
  let query = `UPDATE users SET role = ${role} WHERE email_address ='${email}'`;
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

module.exports.GoogleRegister = GoogleRegister;
module.exports.getTotalRows = getTotalRows;
