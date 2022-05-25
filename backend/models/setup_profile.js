const connection = require("../config/configuration.js");

function setupUser(
  company_name,
  email_address,
  contact_no,
  website,
  district_id,
  company_description,
  image,
  user_id
) {
  var query = `INSERT INTO company(company_name, email_address, contact_no, website, district_id, company_description, image_path, user_id) VALUES ('${company_name}','${email_address}','${contact_no}','${website}',${district_id},'${company_description}','${image}',${user_id})`;
  console.log(query);
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

function isCompanyPresent(email_address) {
  var query = `SELECT * FROM company WHERE email_address='${email_address}'`;
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

function isCompanyUserPresent(user_id) {
  var query = `SELECT * FROM company WHERE user_id='${user_id}'`;
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

function insertIntoUserMembership(user_id) {
  var query = `INSERT INTO user_membership(user_id, membership_id) VALUES ('${user_id}',1)`;
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

module.exports.insertIntoUserMembership = insertIntoUserMembership;
module.exports.isCompanyUserPresent = isCompanyUserPresent;
module.exports.isCompanyPresent = isCompanyPresent;
module.exports.setupUser = setupUser;
