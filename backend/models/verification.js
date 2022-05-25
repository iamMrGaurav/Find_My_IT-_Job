const connection = require("../config/configuration.js");

async function getStatus(email_address) {
    let  query =
      `SELECT * FROM users WHERE email_address ='${email_address}'`;
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

module.exports.getStatus = getStatus;