const { response } = require("express");
const connection = require("../config/configuration.js");

async function getLogin(email_address) {
  let query = `SELECT * FROM users WHERE email_address ='${email_address}'`;
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

async function getAdminLogin(username) {
  let query = `SELECT * FROM admin WHERE username ='${username}'`;
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

async function getCompanyId(user_id) {
  let query = `SELECT comapny_id FROM company WHERE user_id = ${user_id}`;
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

async function getSeekerId(user_id) {
  let query = `SELECT seeker_id FROM seeker WHERE user_id =  ${user_id}`;
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

module.exports.getSeekerId = getSeekerId;
module.exports.getCompanyId = getCompanyId;
module.exports.getLogin = getLogin;
module.exports.getAdminLogin = getAdminLogin;
