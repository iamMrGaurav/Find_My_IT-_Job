const connection = require("../config/configuration.js");

async function posJob(
  job_description,
  posted_date,
  comapny_id,
  job_type,
  salary,
  expired_date,
  experience,
  minimum_education,
  is_negotiable,
  job_title,
  job_specification
) {
  var query = `INSERT INTO post_job(job_description, posted_date, company_id, job_type, salary, expired_date, experience, minimum_education, is_negotiable,job_title,job_specification) VALUES ('${job_description}','${posted_date}','${comapny_id}','${job_type}','${salary}','${expired_date}','${experience}','${minimum_education}','${is_negotiable}','${job_title}','${job_specification}')`;
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

async function getCompnayPostJobDetails(index, company_id) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
  post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
  WHERE company.comapny_id = '${company_id}'
  GROUP BY post_job.job_id
  ORDER BY post_job.posted_date ASC 
  LIMIT 0,${index}`;
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

async function getPostJobLanguages(company_id) {
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
  WHERE company.comapny_id = '${company_id}'
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

async function getOtherCompanyJobs(company_id) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
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
    AND company.comapny_id != '${company_id}'
    GROUP BY post_job.job_id ORDER BY post_job.posted_date `;

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

async function getOtherCompanyJobLanguages(company_id) {
  var query = `SELECT post_job.job_id,job_post_skill.language
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
  WHERE company.comapny_id != '${company_id}'
  AND Date(expired_date) > Date(NOW())
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

async function getSpecificCompanyDetail(company_id) {
  var query = `SELECT users.user_id,company.comapny_id,
  users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name
  ,membership.membership_name
  from users
    INNER JOIN user_membership ON
    user_membership.user_id = users.user_id
    INNER JOIN membership ON
    membership.membership_id = user_membership.membership_id 
    INNER JOIN company on 
    users.user_id = company.user_id
    INNER JOIN district on 
    company.district_id = district.district_id
    WHERE company.comapny_id = ${company_id}`;
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

async function updateCompanyProfile(
  company_id,
  company_name,
  email_address,
  contact_no,
  website,
  company_description,
  image_path,
  district_id
) {
  var query = `
  UPDATE company SET company_name = '${company_name}', email_address = '${email_address}', contact_no = '${contact_no}', website = '${website}', company_description = '${company_description}', image_path = '${image_path}', district_id = '${district_id}' WHERE comapny_id = '${company_id}'`;

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

async function getDistrictId(district_name) {
  return new Promise((resolve, reject) => {
    sql = `SELECT * FROM district WHERE district_name = '${district_name}'`;
    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}

function getJobPositionId(job_position) {
  return new Promise((resolve, reject) => {
    sql = `SELECT job_position_id FROM job_position WHERE job_position_name='${job_position}'`;
    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}

function inserIntoJobPostSkill(job_id, language, job_position_id) {
  return new Promise((resolve, reject) => {
    sql = `INSERT INTO job_post_skill(job_id,job_position_id, language) VALUES (${job_id},${job_position_id},'${language}')`;
    console.log(sql);
    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}

async function searchOtherCompanyJobs(company_id, job_position) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
  post_job.job_description,post_job.posted_date,post_job.expired_date,
  post_job.job_type,post_job.salary,post_job.experience,
  post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
  WHERE Date(expired_date) > Date(NOW()) AND company.comapny_id != '${company_id}' AND job_position.job_position_name LIKE '${job_position}%'
  GROUP BY post_job.job_id ORDER BY post_job.posted_date`;

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

async function searchOtherCompanyJobLanguages(company_id, job_position) {
  var query = `SELECT post_job.job_id,job_post_skill.language
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
  WHERE company.comapny_id != '${company_id}' AND Date(expired_date) > Date(NOW())  AND job_position.job_position_name LIKE '${job_position}%'
  ORDER BY post_job.posted_date `;
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

function fetchSeekerDetail() {
  return new Promise((resolve, reject) => {
    sql = ` SELECT seeker.seeker_id,seeker.first_name,seeker.last_name,seeker.email_address,seeker.dob,
    seeker.highest_qualification,seeker.user_id,seeker.image_path,seeker.cv,district.district_name,
    users.user_name,seeker.work_experience,seeker.job_position,
    seeker.bio,seeker.contact_no,job_position.job_position_name
    FROM seeker  
    INNER JOIN users on 
    users.user_id = seeker.user_id
    INNER JOIN district on 
    seeker.district_id = district.district_id
    LEFT JOIN seeker_skill ON
    seeker.seeker_id = seeker_skill.seeker_id
    LEFT JOIN job_position ON
    seeker_skill.job_position_id = job_position.job_position_id
    GROUP BY seeker_id`;

    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}

function fetchSeekerLanguage() {
  return new Promise((resolve, reject) => {
    sql = `SELECT * FROM seeker_skill`;
    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}

function searchSeeker(value) {
  return new Promise((resolve, reject) => {
    sql = `SELECT seeker.seeker_id,seeker.first_name,seeker.last_name,seeker.email_address,seeker.dob,
    seeker.highest_qualification,seeker.user_id,seeker.image_path,seeker.cv,district.district_name,
    users.user_name,seeker.work_experience,seeker.job_position,
    seeker.bio,seeker.contact_no,job_position.job_position_name
    FROM seeker  
    INNER JOIN users on 
    users.user_id = seeker.user_id
    INNER JOIN district on 
    seeker.district_id = district.district_id
    INNER JOIN seeker_skill ON
    seeker.seeker_id = seeker_skill.seeker_id
    INNER JOIN job_position ON
    seeker_skill.job_position_id = job_position.job_position_id
    WHERE seeker.first_name LIKE "${value}%" 
    OR job_position.job_position_name LIKE "${value}%" 
    OR seeker.job_position LIKE "${value}%"
    GROUP BY seeker_id`;

    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}

function searchSeekerLanguage(value) {
  return new Promise((resolve, reject) => {
    sql = `SELECT seeker.seeker_id,seeker_skill.language
    FROM seeker  
    INNER JOIN users on 
    users.user_id = seeker.user_id
    INNER JOIN district on 
    seeker.district_id = district.district_id
    INNER JOIN seeker_skill ON
    seeker.seeker_id = seeker_skill.seeker_id
    INNER JOIN job_position ON
    seeker_skill.job_position_id = job_position.job_position_id
    WHERE seeker.first_name LIKE "${value}%" 
    OR job_position.job_position_name LIKE "${value}%" 
    OR seeker.job_position LIKE "${value}%"`;
    console.log(sql);
    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}

function getApplicants(job_id) {
  return new Promise((resolve, reject) => {
    sql = `SELECT seeker.seeker_id,seeker.first_name,seeker.last_name,seeker.email_address,seeker.dob,
    seeker.highest_qualification,seeker.user_id,seeker.image_path,seeker.cv,district.district_name,
    users.user_name,seeker.work_experience,seeker.job_position,
    seeker.bio,seeker.contact_no
    FROM seeker  
    INNER JOIN users on 
    users.user_id = seeker.user_id
    INNER JOIN district on 
    seeker.district_id = district.district_id
    INNER JOIN seeker_skill ON
    seeker.seeker_id = seeker_skill.seeker_id
    INNER JOIN job_position ON
    seeker_skill.job_position_id = job_position.job_position_id
    INNER JOIN applied_job ON 
    applied_job.seeker_id = seeker.seeker_id
    WHERE applied_job.job_id = ${job_id}
    GROUP BY seeker_id`;

    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}

function getApplicantsLanguage(job_id) {
  return new Promise((resolve, reject) => {
    sql = `SELECT seeker_skill.seeker_id,seeker_skill.language
    FROM seeker  
    INNER JOIN users on 
    users.user_id = seeker.user_id
    INNER JOIN district on 
    seeker.district_id = district.district_id
    INNER JOIN seeker_skill ON
    seeker.seeker_id = seeker_skill.seeker_id
    INNER JOIN job_position ON
    seeker_skill.job_position_id = job_position.job_position_id
    INNER JOIN applied_job ON 
    applied_job.seeker_id = seeker.seeker_id
    WHERE applied_job.job_id = ${job_id}
    `;
    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}

async function getPostedJob(company_id) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
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
    AND company.comapny_id = '${company_id}'
    GROUP BY post_job.job_id ORDER BY post_job.posted_date `;

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

async function getPostedJobLanguage(company_id) {
  var query = `SELECT post_job.job_id,job_post_skill.language
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
  WHERE company.comapny_id = '${company_id}'
  AND Date(expired_date) > Date(NOW())
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

async function getUserMembershipId(user_id) {
  var query = `SELECT * FROM user_membership WHERE user_id=${user_id}`;
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

async function updateUserMembershipId(user_id, membership_id, register_date) {
  var query = `UPDATE user_membership SET membership_id=${membership_id},registered_date='${register_date}' WHERE user_id =${user_id}`;
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

async function insertIntoPayment(user_id, pay_amount, payment_date) {
  let query = `INSERT INTO payment(user_id,pay_amount,payment_date) VALUES ('${user_id}','${pay_amount}','${payment_date}')`;
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

async function insertIntoUserMembershipId(
  user_id,
  membership_id,
  register_date
) {
  var query = `INSERT INTO user_membership(user_id, membership_id, registered_date) VALUES (${user_id},${membership_id},'${register_date}') WHERE user_id =${user_id}}`;
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

async function deleteJob(job_id) {
  var query = `DELETE FROM post_job WHERE job_id =${job_id} `;
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

async function deleteJobPostSkill(job_id) {
  var query = `DELETE FROM job_post_skill WHERE job_id =${job_id} `;
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

async function deleteAppliedJob(job_id) {
  let query = `DELETE FROM applied_job WHERE job_id= ${job_id} `;
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

async function getMessage(company_id, seeker_id) {
  let query = `SELECT 
  * 
  FROM message 
  WHERE message.company_id = ${company_id} AND message.seeker_id = ${seeker_id} 
  ORDER BY message_date ASC`;

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

async function postMessage(
  company_id,
  seeker_id,
  text_message,
  isSender,
  message_date
) {
  let query = `INSERT INTO message(company_id,seeker_id,text_message,sender,message_date) VALUES (${company_id},${seeker_id},'${text_message}',${isSender},'${message_date}')`;

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

async function getChatScreen(company_id) {
  let query = `SELECT message.text_message,
  message.message_date,company.company_name,company.image_path as company_image,seeker.image_path as seeker_image,seeker.first_name,seeker.last_name,message.sender
  FROM message 
    INNER JOIN company ON message.company_id = company.comapny_id
    INNER JOIN seeker ON seeker.seeker_id = message.seeker_id
    WHERE message.company_id = ${company_id}
    GROUP BY seeker.seeker_id
    ORDER BY message_date ASC`;

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

module.exports.getChatScreen = getChatScreen;
module.exports.getMessage = getMessage;
module.exports.postMessage = postMessage;
//get message
/*SELECT company.company_name,company.image_path,seeker.image_path
seeker.first_name,
seeker.last_name,
message.text_message,
message.message_date
FROM `message` 
INNER JOIN company ON company.comapny_id = message.company_id
INNER JOIN seeker ON seeker.seeker_id = message.seeker_id
WHERE message.company_id = 4 AND message.seeker_id = 15 
ORDER BY message_date ASC*/
//post job
/*INSERT INTO message(company_id,seeker_id,text_message,sender,message_date) VALUES (3,16,'can i get a job','1','2022-04-15')*/

module.exports.deleteAppliedJob = deleteAppliedJob;
module.exports.insertIntoPayment = insertIntoPayment;
module.exports.deleteJobPostSkill = deleteJobPostSkill;
module.exports.deleteJob = deleteJob;
module.exports.insertIntoUserMembershipId = insertIntoUserMembershipId;
module.exports.updateUserMembershipId = updateUserMembershipId;
module.exports.getUserMembershipId = getUserMembershipId;
module.exports.getApplicantsLanguage = getApplicantsLanguage;
module.exports.getPostedJobLanguage = getPostedJobLanguage;
module.exports.getPostedJob = getPostedJob;
module.exports.getApplicants = getApplicants;
module.exports.searchSeeker = searchSeeker;
module.exports.searchSeekerLanguage = searchSeekerLanguage;
module.exports.fetchSeekerDetail = fetchSeekerDetail;
module.exports.fetchSeekerLanguage = fetchSeekerLanguage;
module.exports.searchOtherCompanyJobLanguages = searchOtherCompanyJobLanguages;
module.exports.searchOtherCompanyJobs = searchOtherCompanyJobs;
module.exports.inserIntoJobPostSkill = inserIntoJobPostSkill;
module.exports.getJobPositionId = getJobPositionId;
module.exports.getDistrictId = getDistrictId;
module.exports.updateCompanyProfile = updateCompanyProfile;
module.exports.getSpecificCompanyDetail = getSpecificCompanyDetail;
module.exports.getOtherCompanyJobLanguages = getOtherCompanyJobLanguages;
module.exports.getPostJobLanguages = getPostJobLanguages;
module.exports.getOtherCompanyJobs = getOtherCompanyJobs;
module.exports.getCompnayPostJobDetails = getCompnayPostJobDetails;
module.exports.posJob = posJob;

/*SELECT seeker.seeker_id,seeker.first_name,seeker.last_name,seeker.email_address,seeker.dob,
seeker.highest_qualification,seeker.user_id,seeker.image_path,seeker.cv,district.district_name,
users.user_name,seeker.work_experience,seeker.job_position,
seeker.bio,seeker.contact_no
FROM seeker  
INNER JOIN users on 
users.user_id = seeker.user_id
INNER JOIN district on 
seeker.district_id = district.district_id
INNER JOIN seeker_skill ON
seeker.seeker_id = seeker_skill.seeker_id
INNER JOIN job_position ON
seeker_skill.job_position_id = job_position.job_position_id
INNER JOIN applied_job ON 
applied_job.seeker_id = seeker.seeker_id
WHERE applied_job.job_id = 26
GROUP BY seeker_id;
*/
/*
SELECT seeker.seeker_id,seeker_skill.language
    FROM seeker  
    INNER JOIN users on 
    users.user_id = seeker.user_id
    INNER JOIN district on 
    seeker.district_id = district.district_id
    INNER JOIN seeker_skill ON
    seeker.seeker_id = seeker_skill.seeker_id
    INNER JOIN job_position ON
    seeker_skill.job_position_id = job_position.job_position_id
    WHERE seeker.first_name LIKE "%" 
    OR job_position.job_position_name LIKE "%" 
    OR seeker_skill.language LIKE "%"
*/
/*
SELECT seeker.seeker_id,seeker.first_name,seeker.last_name,seeker.email_address,seeker.dob,
    seeker.highest_qualification,seeker.user_id,seeker.image_path,seeker.cv,district.district_name,
    users.user_name,seeker.work_experience,seeker.job_position,
    seeker.bio,seeker.contact_no
    FROM seeker  
    INNER JOIN users on 
    users.user_id = seeker.user_id
    INNER JOIN district on 
    seeker.district_id = district.district_id
    INNER JOIN seeker_skill ON
    seeker.seeker_id = seeker_skill.seeker_id
    INNER JOIN job_position ON
    seeker_skill.job_position_id = job_position.job_position_id
    WHERE seeker.first_name LIKE "b%" 
    OR job_position.job_position_name LIKE "bac%" 
    OR seeker_skill.language LIKE "%"
    GROUP BY seeker_id
*/
