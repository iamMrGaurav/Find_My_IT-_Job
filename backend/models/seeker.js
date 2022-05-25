const connection = require("../config/configuration.js");

async function createProfile(
  first_name,
  last_name,
  email_address,
  dob,
  highest_qualification,
  user_id,
  image_path,
  cv,
  district_id,
  work_experience,
  bio,
  contact_no,
  job_position
) {
  var query = `INSERT INTO seeker(first_name, last_name, email_address, dob, highest_qualification, user_id, image_path, cv, district_id, work_experience,bio,contact_no,	job_position) VALUES ('${first_name}','${last_name}','${email_address}','${dob}','${highest_qualification}',${user_id},'${image_path}','${cv}','${district_id}','${work_experience}','${bio}','${contact_no}','${job_position}')`;

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

function inserIntoSeekerSkill(values) {
  return new Promise((resolve, reject) => {
    sql = `INSERT INTO seeker_skill(seeker_id, job_position_id, language) VALUES ${values}`;
    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}

function fetchSeekerProfileDetail(seeker_id) {
  return new Promise((resolve, reject) => {
    sql = ` SELECT seeker.seeker_id,seeker.first_name,seeker.last_name,seeker.email_address,seeker.dob,
    seeker.highest_qualification,seeker.user_id,seeker.image_path,seeker.cv,district.district_name,
    users.user_name,seeker.work_experience,seeker.job_position,
    seeker.bio,seeker.contact_no
    FROM seeker  
    INNER JOIN users on 
    users.user_id = seeker.user_id
    LEFT  JOIN district on 
    seeker.district_id = district.district_id
    LEFT  JOIN seeker_skill ON
    seeker.seeker_id = seeker_skill.seeker_id
    LEFT  JOIN job_position ON
    seeker_skill.job_position_id = job_position.job_position_id
    WHERE seeker.seeker_id = ${seeker_id}
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

function fetchSeekerProfileLanguage(seeker_id) {
  return new Promise((resolve, reject) => {
    sql = `SELECT * FROM seeker_skill WHERE seeker_id=${seeker_id}`;
    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}

async function getOtherCompanyJobs(seeker_id) {
  var query = `SELECT job.*,applied_job.job_id as "isApplied",bookmark.job_id as "isBookmark"
  FROM (SELECT company.comapny_id,post_job.job_id, users.user_name,company.company_name,company.email_address,
  company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
  post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,
  post_job.salary,post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification,membership.membership_name
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
      LEFT JOIN job_post_skill on
      post_job.job_id = job_post_skill.job_id
      LEFT JOIN job_position on 
      job_post_skill.job_position_id = job_position.job_position_id 
      WHERE Date(expired_date) > Date(NOW()) 
      GROUP BY post_job.job_id 
      ORDER BY membership.membership_name DESC) AS job 
      LEFT JOIN applied_job ON 
      job.job_id = applied_job.job_id AND applied_job.seeker_id = ${seeker_id}
      LEFT JOIN bookmark ON 
      job.job_id = bookmark.job_id AND bookmark.seeker_id = ${seeker_id}`;
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

async function getOtherCompanyJobLanguages() {
  var query = `SELECT post_job.job_id,job_post_skill.language
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
  LEFT JOIN job_post_skill on
  post_job.job_id = job_post_skill.job_id
  LEFT JOIN job_position on
  job_post_skill.job_position_id = job_position.job_position_id 
  WHERE  Date(expired_date) > Date(NOW())
  ORDER BY membership.membership_name DESC`;
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

async function searchOtherCompanyJobs(job_position, seeker_id) {
  var query = `SELECT job.*,applied_job.job_id as "isApplied",bookmark.job_id as "isBookmark"
  FROM (SELECT company.comapny_id,post_job.job_id, users.user_name,company.company_name,company.email_address,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
  post_job.job_description,post_job.posted_date,post_job.expired_date,
  post_job.job_type,post_job.salary,post_job.experience,
  post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification,membership.membership_name
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
  LEFT JOIN job_post_skill on
  post_job.job_id = job_post_skill.job_id
  LEFT JOIN job_position on 
  job_post_skill.job_position_id = job_position.job_position_id 
  WHERE Date(expired_date) > Date(NOW())  
  AND job_position.job_position_name LIKE '${job_position}%'
  GROUP BY post_job.job_id ORDER BY membership.membership_name DESC) AS job 
  LEFT JOIN applied_job ON 
      job.job_id = applied_job.job_id AND applied_job.seeker_id = ${seeker_id}
      LEFT JOIN bookmark ON 
      job.job_id = bookmark.job_id AND bookmark.seeker_id = ${seeker_id}`;
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

async function searchOtherCompanyJobLanguages(job_position) {
  var query = `SELECT post_job.job_id,job_post_skill.language
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
  LEFT JOIN job_post_skill on
  post_job.job_id = job_post_skill.job_id
  LEFT JOIN job_position on
  job_post_skill.job_position_id = job_position.job_position_id 
  WHERE Date(expired_date) > Date(NOW())  AND job_position.job_position_name LIKE '${job_position}%'
  ORDER BY membership.membership_name DESC`;
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

function applyJob(seeker_id, job_id, date) {
  return new Promise((resolve, reject) => {
    sql = `
    INSERT INTO applied_job (seeker_id, job_id, applied_date)
    VALUES (${seeker_id}, ${job_id}, '${date}')`;

    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}

function checkApplicationExistence(seeker_id, job_id) {
  return new Promise((resolve, reject) => {
    sql = `SELECT * FROM applied_job WHERE job_id=${job_id} and seeker_id=${seeker_id}`;

    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}

function checkBookmarkExistence(seeker_id, job_id) {
  return new Promise((resolve, reject) => {
    sql = `SELECT * FROM bookmark WHERE job_id=${job_id} and seeker_id=${seeker_id}`;

    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}

function fetchUserPreferJobs(job_position, seeker_id) {
  return new Promise((resolve, reject) => {
    let sql = `SELECT job.*,applied_job.job_id as "isApplied",bookmark.job_id as "isBookmark"
    FROM (SELECT company.comapny_id,post_job.job_id, users.user_name,company.company_name,company.email_address,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
      post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification,membership.membership_name
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
        LEFT JOIN job_post_skill on
        post_job.job_id = job_post_skill.job_id
        LEFT JOIN job_position on 
        job_post_skill.job_position_id = job_position.job_position_id 
        WHERE Date(expired_date) > Date(NOW())
        AND (job_position.job_position_name LIKE "${job_position}%" 
        OR post_job.job_title LIKE "${job_position}%")
        GROUP BY post_job.job_id 
        ORDER BY membership.membership_name DESC) AS job 
        LEFT JOIN applied_job ON 
        job.job_id = applied_job.job_id AND applied_job.seeker_id = ${seeker_id}
        LEFT JOIN bookmark ON 
        job.job_id = bookmark.job_id AND bookmark.seeker_id = ${seeker_id}`;
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
function userPreferJobLanguage(job_position) {
  return new Promise((resolve, reject) => {
    sql = ` SELECT post_job.job_id,job_post_skill.language
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
      LEFT JOIN job_post_skill on
      post_job.job_id = job_post_skill.job_id
      LEFT JOIN job_position on
      job_post_skill.job_position_id = job_position.job_position_id
      WHERE  Date(expired_date) > Date(NOW())
      AND (job_position.job_position_name LIKE "${job_position}%" 
          OR post_job.job_title LIKE "${job_position}%")
      ORDER BY membership.membership_name DESC`;

    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}

function getBookmarkJobs(seeker_id) {
  return new Promise((resolve, reject) => {
    let sql = `SELECT job.*,applied_job.job_id as "isApplied",bookmark.job_id as "isBookmark"
    FROM (SELECT company.comapny_id,post_job.job_id, users.user_name,company.company_name,company.email_address,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
      post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification,membership.membership_name
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
          LEFT JOIN job_post_skill on
          post_job.job_id = job_post_skill.job_id
          LEFT JOIN job_position on 
          job_post_skill.job_position_id = job_position.job_position_id 
          INNER JOIN bookmark ON
          bookmark.job_id = post_job.job_id
          WHERE bookmark.seeker_id =${seeker_id}
          GROUP BY post_job.job_id ORDER BY membership.membership_name DESC) AS job 
          LEFT JOIN applied_job ON 
          job.job_id = applied_job.job_id AND applied_job.seeker_id = ${seeker_id}
          LEFT JOIN bookmark ON 
          job.job_id = bookmark.job_id AND bookmark.seeker_id = ${seeker_id}`;

    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}

function getBookmarkJobLanguage(seeker_id) {
  return new Promise((resolve, reject) => {
    let sql = `SELECT post_job.job_id,job_post_skill.language
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
    LEFT JOIN job_post_skill on
    post_job.job_id = job_post_skill.job_id
    LEFT JOIN job_position on
    job_post_skill.job_position_id = job_position.job_position_id
    INNER JOIN bookmark ON
    bookmark.job_id = post_job.job_id
    WHERE bookmark.seeker_id =${seeker_id}
    ORDER BY membership.membership_name DESC`;

    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}
function addBookmark(seeker_id, job_id) {
  return new Promise((resolve, reject) => {
    sql = `INSERT INTO bookmark (seeker_id, job_id) VALUES ('${seeker_id}','${job_id}')`;

    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}

function deleteBookmark(seeker_id, job_id) {
  return new Promise((resolve, reject) => {
    sql = `DELETE FROM bookmark WHERE seeker_id=${seeker_id} AND job_id=${job_id}`;

    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}

async function updateSeekerProfile(
  first_name,
  last_name,
  email_address,
  highest_qualification,
  // image_path,
  // cv,
  district_id,
  work_experience,
  bio,
  contact_no,
  job_position,
  seeker_id
) {
  var query = `UPDATE seeker SET seeker_id=${seeker_id},first_name ='${first_name}',last_name='${last_name}',email_address ='${email_address}',highest_qualification='${highest_qualification}', district_id =${district_id},work_experience='
  ${work_experience}',bio='${bio}',contact_no ='${contact_no}',job_position='${job_position}' WHERE seeker_id=${seeker_id}`;

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

async function updateProfileImage(seeker_id, image_path) {
  var query = `UPDATE seeker SET image_path ='${image_path}' WHERE seeker_id = '${seeker_id}'`;
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

async function updateProfileCV(seeker_id, cv) {
  var query = `UPDATE seeker SET cv='${cv}' WHERE seeker_id = '${seeker_id}'`;

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

async function deleteSeekerSkill(seeker_id) {
  var query = `DELETE FROM seeker_skill WHERE seeker_id=${seeker_id}`;
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

function getAppliedJob(seeker_id) {
  return new Promise((resolve, reject) => {
    sql = `SELECT job.*,applied_job.job_id as "isApplied",bookmark.job_id as "isBookmark"
    FROM (SELECT company.comapny_id,post_job.job_id, users.user_name,company.company_name,company.email_address,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
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
          INNER JOIN applied_job ON
          applied_job.job_id = post_job.job_id
          WHERE Date(expired_date) > Date(NOW()) 
          AND applied_job.seeker_id =${seeker_id}
          GROUP BY post_job.job_id ORDER BY post_job.posted_date DESC) AS job 
          LEFT JOIN applied_job ON 
          job.job_id = applied_job.job_id AND applied_job.seeker_id = ${seeker_id}
          LEFT JOIN bookmark ON 
          job.job_id = bookmark.job_id AND bookmark.seeker_id = ${seeker_id}`;

    connection.query(sql, (error, results) => {
      if (error) {
        return reject({ error: error.code });
      } else {
        return resolve(results);
      }
    });
  });
}

function getAppliedJobLanguage(seeker_id) {
  return new Promise((resolve, reject) => {
    sql = `
    SELECT post_job.job_id,job_post_skill.language
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
    INNER JOIN applied_job ON
    applied_job.job_id = post_job.job_id
    WHERE  Date(expired_date) > Date(NOW())
    AND applied_job.seeker_id =${seeker_id}
    ORDER BY post_job.posted_date DESC
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

module.exports.updateProfileCV = updateProfileCV;
module.exports.updateProfileImage = updateProfileImage;
module.exports.deleteBookmark = deleteBookmark;
module.exports.checkBookmarkExistence = checkBookmarkExistence;
module.exports.addBookmark = addBookmark;
module.exports.userPreferJobLanguage = userPreferJobLanguage;
module.exports.getAppliedJobLanguage = getAppliedJobLanguage;
module.exports.getAppliedJob = getAppliedJob;
module.exports.getBookmarkJobLanguage = getBookmarkJobLanguage;
module.exports.deleteSeekerSkill = deleteSeekerSkill;
module.exports.updateSeekerProfile = updateSeekerProfile;
module.exports.getBookmarkJobs = getBookmarkJobs;
module.exports.applyJob = applyJob;
module.exports.fetchUserPreferJobs = fetchUserPreferJobs;
module.exports.checkApplicationExistence = checkApplicationExistence;
module.exports.searchOtherCompanyJobs = searchOtherCompanyJobs;
module.exports.searchOtherCompanyJobLanguages = searchOtherCompanyJobLanguages;
module.exports.getOtherCompanyJobs = getOtherCompanyJobs;
module.exports.getOtherCompanyJobLanguages = getOtherCompanyJobLanguages;
module.exports.fetchSeekerProfileLanguage = fetchSeekerProfileLanguage;
module.exports.fetchSeekerProfileDetail = fetchSeekerProfileDetail;
module.exports.inserIntoSeekerSkill = inserIntoSeekerSkill;
module.exports.createProfile = createProfile;

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
    INNER JOIN applied_job ON
    applied_job.job_id = post_job.job_id
    WHERE Date(expired_date) > Date(NOW()) AND applied_job.seeker_id !=15
    GROUP BY post_job.job_id ORDER BY post_job.posted_date DESC

*/

/*
SELECT * FROM `applied_job` WHERE job_id= and seeker_id=
*/

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
    INNER JOIN applied_job ON
    applied_job.job_id = post_job.job_id
    WHERE Date(expired_date) > Date(NOW())
    AND applied_job.seeker_id !=15
    AND job_position.job_position_name LIKE "ba%" OR post_job.job_title LIKE "aa%"
    GROUP BY post_job.job_id ORDER BY post_job.posted_date DESC

*/

/*
-----<bookmark>

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
    INNER JOIN applied_job ON
    applied_job.job_id = post_job.job_id
    INNER JOIN bookmark ON
    bookmark.job_id = post_job.job_id
    WHERE Date(expired_date) > Date(NOW()) 
    AND applied_job.seeker_id !=6
    GROUP BY post_job.job_id ORDER BY post_job.posted_date DESC


*/

/*
SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,
company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,
post_job.salary,post_job.experience,post_job.is_negotiable,post_job.minimum_education,
job_position.job_position_name,post_job.job_title,post_job.job_specification
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
GROUP BY post_job.job_id ORDER BY post_job.posted_date DESC

*/

/*SELECT job.*,applied_job.job_id,bookmark.job_id as "isApplied"
FROM (SELECT * from post_job) AS job 
LEFT JOIN applied_job ON 
job.job_id = applied_job.job_id
LEFT JOIN bookmark ON
job.job_id = bookmark.job_id
AND applied_job.seeker_id = 15;*/

/*
SELECT job.*,applied_job.job_id,bookmark.job_id as "isApplied"
FROM (SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,
      post_job.salary,post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
GROUP BY post_job.job_id ORDER BY post_job.posted_date DESC) AS job 
LEFT JOIN applied_job ON 
job.job_id = applied_job.job_id
LEFT JOIN bookmark ON
job.job_id = bookmark.job_id
AND applied_job.seeker_id = 15
*/
