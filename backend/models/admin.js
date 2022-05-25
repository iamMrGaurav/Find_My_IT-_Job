const connection = require("../config/configuration.js");

async function getTotalCompanies() {
  var query = `SELECT (SELECT COUNT(*) FROM company)  as 'total_companies'`;
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

async function getTotalJobs() {
  var query = `SELECT (SELECT COUNT(*) FROM post_job)  as 'total_jobs'`;
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

async function getTotalJobSeeker() {
  var query = `SELECT (SELECT COUNT(*) FROM seeker)  as 'total_seekers'`;
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

async function getTotalFullTimeJobs() {
  var query = `SELECT (SELECT COUNT(*) FROM post_job WHERE job_type = "Full time")  as 'total_full_time'`;
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

async function getTotalPartTimeJobs() {
  var query = `SELECT (SELECT COUNT(*) FROM post_job WHERE job_type = "part time")  as 'total_part_time'`;
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

async function getTotalInternJobs() {
  var query = `SELECT (SELECT COUNT(*) FROM post_job WHERE job_type = "Internship")  as 'total_internship'`;
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
async function getTotalRemoteJobs() {
  var query = `SELECT (SELECT COUNT(*) FROM post_job WHERE job_type = "remote")  as 'total_remote'`;
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

async function getCompaniesDetails() {
  var query = `SELECT users.user_name,users.verification_status, company.company_name,company.email_address,company.contact_no,company.website, company.image_path, company.company_description, district.district_name from users 
  INNER JOIN company on 
  users.user_id = company.user_id
  INNER JOIN district on 
  company.district_id = district.district_id`;
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

async function searchCompanies(userText) {
  var query = ` SELECT users.user_name,users.verification_status, company.company_name,company.email_address,company.contact_no,company.website, company.image_path, company.company_description, district.district_name from users 
  INNER JOIN company on 
  users.user_id = company.user_id
  INNER JOIN district on 
  company.district_id = district.district_id
  WHERE district.district_name LIKE '${userText}%'
  OR company.company_name LIKE '${userText}%'`;
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

async function getTotalCompanies() {
  var query = `SELECT (SELECT COUNT(*) FROM company)  as 'total_companies'`;
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

async function getJobPosition() {
  var query = `SELECT * FROM job_position`;
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

async function addJobPosition(jobPositionName) {
  var query = `INSERT INTO job_position(job_position_name) VALUES ('${jobPositionName}')`;
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

async function limitJobPosition(index) {
  var query = `SELECT * FROM job_position LIMIT 0,${index};`;
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

async function getPostJobDetails() {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
  post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
  ,membership.membership_name,user_membership.registered_date
      from users
      INNER JOIN user_membership ON
      user_membership.user_id = users.user_id
      INNER JOIN membership ON
      membership.membership_id = user_membership.membership_id 
  INNER JOIN company on 
  users.user_id = company.user_id
  INNER JOIN district on 
  company.district_id = district.district_id
  INNER JOIN post_job on 
  company.comapny_id = post_job.company_id
  INNER JOIN job_post_skill on
  post_job.job_id = job_post_skill.job_id
  INNER JOIN job_position on 
  job_post_skill.job_position_id = job_position.job_position_id 
  GROUP BY post_job.job_id ORDER BY post_job.posted_date ASC`;
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

async function getPostJobLanguages() {
  var query = `SELECT post_job.job_id,job_post_skill.language
  from users 
  INNER JOIN company on 
  users.user_id = company.user_id
  INNER JOIN district on 
  company.district_id = district.district_id
  INNER JOIN post_job on 
  company.comapny_id = post_job.company_id
  INNER JOIN job_post_skill on
  post_job.job_id = job_post_skill.job_id
  INNER JOIN job_position on
  job_post_skill.job_position_id = job_position.job_position_id ORDER BY post_job.posted_date ASC`;
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

async function getSearchJob(job_position) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
  post_job.job_description,post_job.posted_date,post_job.is_negotiable,post_job.expired_date,post_job.job_type,post_job.salary,post_job.experience,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
  ,membership.membership_name,user_membership.registered_date
      from users
      INNER JOIN user_membership ON
      user_membership.user_id = users.user_id
      INNER JOIN membership ON
      membership.membership_id = user_membership.membership_id 
  INNER JOIN company on 
  users.user_id = company.user_id
  INNER JOIN district on 
  company.district_id = district.district_id
  INNER JOIN post_job on 
  company.comapny_id = post_job.company_id
  INNER JOIN job_post_skill on
  post_job.job_id = job_post_skill.job_id
  INNER JOIN job_position on
  job_post_skill.job_position_id = job_position.job_position_id 
  WHERE job_position.job_position_name LIKE ('${job_position}%') 
  GROUP BY post_job.job_id 
  ORDER BY post_job.posted_date ASC`;
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

async function getSearchJobLanguages(job_position) {
  var query = `SELECT post_job.job_id,job_post_skill.language
  from users
  INNER JOIN company on
  users.user_id = company.user_id
  INNER JOIN district on
  company.district_id = district.district_id
  INNER JOIN post_job on
  company.comapny_id = post_job.company_id
  INNER JOIN job_post_skill on
  post_job.job_id = job_post_skill.job_id
  INNER JOIN job_position on
  job_post_skill.job_position_id = job_position.job_position_id
  WHere job_position.job_position_name LIKE ('${job_position}%') 
  ORDER BY post_job.posted_date ASC`;
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

async function updateJobPosition(job_position_id, job_position_name) {
  /*UPDATE job_position SET job_position_name='' WHERE job_position_id = */
  let query = `UPDATE job_position SET job_position_name='${job_position_name}' WHERE job_position_id =${job_position_id}`;
  console.log(query);
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

async function deleteJobPosition(job_position_id) {
  let query = `DELETE FROM job_position WHERE job_position_id =${job_position_id} `;
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

async function getTransactionDetail() {
  var query = `SELECT users.user_id,company.email_address,users.verification_status,
  payment.pay_amount,payment.payment_date,company.company_name,company.website,district.district_name,company.company_description,
  company.image_path,users.verification_status,company.contact_no
  FROM users
  INNER JOIN user_membership ON user_membership.user_id = users.user_id 
  INNER JOIN membership ON membership.membership_id = user_membership.membership_id
  INNER JOIN payment ON payment.user_id = users.user_id
  INNER JOIN company ON
  company.user_id = users.user_id
  INNER JOIN district ON
  company.district_id = district.district_id
  WHERE membership.membership_name = "premium"`;
  console.log(query);
  return new Promise((resolve, reject) => {
    connection.query(query, (err, result) => {
      if (err) {
        reject(err);
      } else {
        console.log(result);
        resolve(result);
      }
    });
  });
}

async function searchTransactionDetail(companyName) {
  var query = `SELECT users.user_id,company.email_address,users.verification_status,
  payment.pay_amount,payment.payment_date,company.company_name,company.website,district.district_name,company.company_description,
  company.image_path,users.verification_status,company.contact_no
  FROM users
  INNER JOIN user_membership ON user_membership.user_id = users.user_id 
  INNER JOIN membership ON membership.membership_id = user_membership.membership_id
  INNER JOIN payment ON payment.user_id = users.user_id
  INNER JOIN company ON
  company.user_id = users.user_id
  INNER JOIN district ON
  company.district_id = district.district_id
  WHERE membership.membership_name = "premium" 
  AND company.company_name LIKE "${companyName}%"`;
  console.log(query);
  return new Promise((resolve, reject) => {
    connection.query(query, (err, result) => {
      if (err) {
        reject(err);
      } else {
        console.log(result);
        resolve(result);
      }
    });
  });
}

module.exports.searchTransactionDetail = searchTransactionDetail;
module.exports.getTransactionDetail = getTransactionDetail;
module.exports.getTotalRemoteJobs = getTotalRemoteJobs;
module.exports.getTotalInternJobs = getTotalInternJobs;
module.exports.getTotalPartTimeJobs = getTotalPartTimeJobs;
module.exports.getTotalFullTimeJobs = getTotalFullTimeJobs;
module.exports.getTotalJobSeeker = getTotalJobSeeker;
module.exports.updateJobPosition = updateJobPosition;
module.exports.deleteJobPosition = deleteJobPosition;
module.exports.getSearchJobLanguages = getSearchJobLanguages;
module.exports.getSearchJob = getSearchJob;
module.exports.limitJobPosition = limitJobPosition;
module.exports.addJobPosition = addJobPosition;
module.exports.getJobPosition = getJobPosition;
module.exports.getCompaniesDetails = getCompaniesDetails;
module.exports.getTotalJobs = getTotalJobs;
module.exports.getTotalCompanies = getTotalCompanies;
module.exports.getPostJobDetails = getPostJobDetails;
module.exports.getPostJobLanguages = getPostJobLanguages;
module.exports.searchCompanies = searchCompanies;

//SELECT * FROM `post_job` WHERE Date(expired_date) < Date(NOW());

/*

SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
  post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
  from users 
  INNER JOIN company on 
  users.user_id = company.user_id
  INNER JOIN district on 
  company.district_id = district.district_id
  INNER JOIN post_job on 
  company.comapny_id = post_job.company_id
  LEFT JOIN job_post_skill on
  post_job.job_id = job_post_skill.job_id
  LEFT JOIN job_position on 
  job_post_skill.job_position_id = job_position.job_position_id 
  WHERE Date(expired_date) > Date(NOW())
  GROUP BY post_job.job_id ORDER BY post_job.posted_date
*/
