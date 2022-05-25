const connection = require("../config/configuration.js");

function registerUser(
  userName,
  email_address,
  password,
  role,
  verification_status,
  type
) {
  var query = `INSERT INTO users(user_name, email_address, password, role, verification_status, type) 
  VALUES ('${userName}','${email_address}','${password}',${role},'${verification_status}',${type})`;
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

function isUserPresent(email_address) {
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

async function getUser() {
  console.log("iam in");
  var query = `SELECT * FROM user`;

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
exports.changeVerificationStatus = (username) => {
  let query = `UPDATE users SET verification_status = 'true' WHERE user_name ='${username}'`;
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

// async function check() {
//   try {
//     let data = await getUser();
//   } catch (error) {
//     return error;
//   }
// }
// check();
// function registerUser() {
//   let data = connection.query("");
// }
module.exports.isUserPresent = isUserPresent;
module.exports.registerUser = registerUser;
