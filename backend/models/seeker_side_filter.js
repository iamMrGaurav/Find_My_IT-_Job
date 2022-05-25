const connection = require("../config/configuration.js");

async function filterAllCompanyByMonth(
  job_position,
  job_type,
  district,
  seeker_id
) {
  var query = `SELECT job.*,applied_job.job_id as "isApplied",bookmark.job_id as "isBookmark"
  FROM (SELECT company.comapny_id,post_job.job_id, users.user_name,company.company_name,company.email_address,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
    post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
    post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification,membership.membership_name
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
    WHERE MONTH(post_job.posted_date) >= MONTH(NOW() - INTERVAL 1 MONTH)
    AND Date(expired_date) > Date(NOW())
    AND post_job.job_type = "${job_type}"
    AND job_position.job_position_name LIKE "${job_position}%"
    AND district.district_name = "${district}"
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

async function filterAllCompanyByMonthLanguages(
  job_position,
  job_type,
  district
) {
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
    WHERE MONTH(post_job.posted_date) >= MONTH(NOW() - INTERVAL 1 MONTH)
    AND Date(expired_date) > Date(NOW()) 
    AND post_job.job_type = "${job_type}"
    AND job_position.job_position_name LIKE "${job_position}%"
    AND district.district_name = "${district}"
    GROUP BY post_job.job_id 
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

async function filterAllCompanyByWeekly(
  job_position,
  job_type,
  district,
  seeker_id
) {
  var query = `SELECT job.*,applied_job.job_id as "isApplied",bookmark.job_id as "isBookmark"
  FROM (SELECT company.comapny_id,post_job.job_id, users.user_name,company.company_name,company.email_address,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
      post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
      post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification,membership.membership_name
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
      WHERE WEEK(post_job.posted_date) >= WEEK(NOW() - INTERVAL 1 WEEK)
      AND Date(expired_date) > Date(NOW()) 
      AND post_job.job_type = "${job_type}"
      AND job_position.job_position_name LIKE "${job_position}%"
      AND district.district_name = "${district}"
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
async function filterAllCompanyLanguagesByWeekly(
  job_position,
  job_type,
  district
) {
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
      WHERE WEEK(post_job.posted_date) >= WEEK(NOW() - INTERVAL 1 WEEK)
      AND Date(expired_date) > Date(NOW())
      AND post_job.job_type = "${job_type}"
      AND job_position.job_position_name LIKE "${job_position}%"
      AND district.district_name = "${district}"
      GROUP BY post_job.job_id 
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

/*-------------------------*/

async function filterByJobTypeAndDistrict(
  job_position,
  job_type,
  district,
  seeker_id
) {
  var query = `SELECT job.*,applied_job.job_id as "isApplied",bookmark.job_id as "isBookmark"
  FROM (SELECT company.comapny_id,post_job.job_id, users.user_name,company.company_name,company.email_address,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
    post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
    post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification,membership.membership_name
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
    WHERE post_job.job_type = "${job_type}"
    AND Date(expired_date) > Date(NOW())
    AND job_position.job_position_name LIKE "${job_position}%"
    AND district.district_name = "${district}"
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

async function filterLanguageByJobTypeAndDistrict(
  job_position,
  job_type,
  district
) {
  var query = `SELECT  post_job.job_id,job_post_skill.language
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
      WHERE post_job.job_type = "${job_type}"
      AND job_position.job_position_name LIKE "${job_position}%"
      AND district.district_name = "${district}"
      AND Date(expired_date) > Date(NOW())
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

async function filterByJobType(job_position, job_type, seeker_id) {
  var query = `SELECT job.*,applied_job.job_id as "isApplied",bookmark.job_id as "isBookmark"
  FROM (SELECT company.comapny_id,post_job.job_id, users.user_name,company.company_name,company.email_address,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
      post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
      post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification,membership.membership_name
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
      WHERE post_job.job_type = "${job_type}"
      AND Date(expired_date) > Date(NOW())
      AND job_position.job_position_name LIKE "${job_position}%"
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

async function filterLanguageByJobType(job_position, job_type) {
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
        WHERE post_job.job_type = "${job_type}"
        AND Date(expired_date) > Date(NOW())
        AND job_position.job_position_name LIKE "${job_position}%"
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

async function filterByDistrict(job_position, district, seeker_id) {
  var query = `SELECT job.*,applied_job.job_id as "isApplied",bookmark.job_id as "isBookmark"
  FROM (SELECT company.comapny_id,post_job.job_id, users.user_name,company.company_name,company.email_address,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
      post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
      post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification,membership.membership_name
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
      WHERE job_position.job_position_name LIKE "${job_position}%"
      AND district.district_name = "${district}"
      AND Date(expired_date) > Date(NOW())
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

async function filterLanguageByDistrict(job_position, district) {
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
        WHERE job_position.job_position_name LIKE "${job_position}%"
        AND district.district_name = "${district}" 
        AND Date(expired_date) > Date(NOW())
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

async function filterByWeekly(job_position, seeker_id) {
  var query = `SELECT job.*,applied_job.job_id as "isApplied",bookmark.job_id as "isBookmark"
  FROM (SELECT company.comapny_id,post_job.job_id, users.user_name,company.company_name,company.email_address,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
    post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
    post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification,membership.membership_name
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
    WHERE YEARWEEK(post_job.posted_date) >= YEARWEEK(NOW() - INTERVAL 1 WEEK)
    AND job_position.job_position_name LIKE "${job_position}%"
    AND Date(expired_date) > Date(NOW())
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

async function filterLanguageByWeekly(job_position) {
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
      WHERE YEARWEEK(post_job.posted_date) >= YEARWEEK(NOW() - INTERVAL 1 WEEK)
      AND job_position.job_position_name LIKE "${job_position}%"
      AND Date(expired_date) > Date(NOW())
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

async function filterByMonthly(job_position, seeker_id) {
  var query = `SELECT job.*,applied_job.job_id as "isApplied",bookmark.job_id as "isBookmark"
  FROM (SELECT company.comapny_id,post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
      post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
      post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification,membership.membership_name
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
      WHERE MONTH(post_job.posted_date) >= MONTH(NOW() - INTERVAL 1 MONTH)
      AND job_position.job_position_name LIKE "${job_position}%"
      AND Date(expired_date) > Date(NOW())
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

async function filterLanguageByMonthly(job_position) {
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
        WHERE MONTH(post_job.posted_date) > MONTH(NOW() - INTERVAL 1 MONTH)
        AND job_position.job_position_name LIKE "${job_position}%"
        AND Date(expired_date) > Date(NOW())
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

async function filterByJobTypeAndUserDateByWeekly(
  job_position,
  job_type,
  seeker_id
) {
  var query = `SELECT job.*,applied_job.job_id as "isApplied",bookmark.job_id as "isBookmark"
  FROM (SELECT company.comapny_id,post_job.job_id, users.user_name,company.company_name,company.email_address,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
  post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
  post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
  INNER JOIN post_job on 
  company.comapny_id = post_job.company_id
  LEFT JOIN job_post_skill on
  post_job.job_id = job_post_skill.job_id
  LEFT JOIN job_position on
  job_post_skill.job_position_id = job_position.job_position_id
  WHERE YEARWEEK(post_job.posted_date) >= YEARWEEK(NOW() - INTERVAL 1 WEEK)
  AND Date(expired_date) > Date(NOW())
  AND post_job.job_type = "${job_type}"
  AND job_position.job_position_name LIKE "${job_position}%"
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

async function filterLanguageByJobTypeAndUserDateByWeekly(
  job_position,
  job_type
) {
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
      WHERE YEARWEEK(post_job.posted_date) >= YEARWEEK(NOW() - INTERVAL 1 WEEK)
      AND Date(expired_date) > Date(NOW())
      AND post_job.job_type = "${job_type}"
      AND job_position.job_position_name LIKE "${job_position}%"
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

async function filterByJobTypeAndUserDateByMonthly(
  job_position,
  job_type,
  seeker_id
) {
  var query = `SELECT job.*,applied_job.job_id as "isApplied",bookmark.job_id as "isBookmark"
  FROM (SELECT company.comapny_id,post_job.job_id, users.user_name,company.company_name,company.email_address,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
  post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
  post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
  INNER JOIN post_job on 
  company.comapny_id = post_job.company_id
  LEFT JOIN job_post_skill on
  post_job.job_id = job_post_skill.job_id
  LEFT JOIN job_position on
  job_post_skill.job_position_id = job_position.job_position_id
  WHERE MONTH(post_job.posted_date) >= MONTH(NOW() - INTERVAL 1 MONTH)
  AND Date(expired_date) > Date(NOW())
  AND job_position.job_position_name LIKE "${job_position}%"
  AND post_job.job_type = "${job_type}"
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

async function filterLanguageByJobTypeAndUserDateByMonthly(
  job_position,
  job_type
) {
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
        WHERE MONTH(post_job.posted_date) >= MONTH(NOW() - INTERVAL 1 MONTH)
        AND Date(expired_date) > Date(NOW())
        AND job_position.job_position_name LIKE "${job_position}%"
        AND post_job.job_type = "${job_type}"
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

async function filterByDistrictWeekly(job_position, district, seeker_id) {
  var query = `SELECT job.*,applied_job.job_id as "isApplied",bookmark.job_id as "isBookmark"
  FROM (SELECT company.comapny_id,post_job.job_id, users.user_name,company.company_name,company.email_address,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
  post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
  post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
  INNER JOIN post_job on 
  company.comapny_id = post_job.company_id
  LEFT JOIN job_post_skill on
  post_job.job_id = job_post_skill.job_id
  LEFT JOIN job_position on
  job_post_skill.job_position_id = job_position.job_position_id
  WHERE YEARWEEK(post_job.posted_date) >= YEARWEEK(NOW() - INTERVAL 1 WEEK)
  AND Date(expired_date) > Date(NOW())
  AND job_position.job_position_name LIKE "${job_position}%"
  AND district.district_name = "${district}"
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

async function filterLanguageDistrictByWeekly(job_position, district) {
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
        WHERE YEARWEEK(post_job.posted_date) >= YEARWEEK(NOW() - INTERVAL 1 WEEK)
        AND Date(expired_date) > Date(NOW())
        AND job_position.job_position_name LIKE "${job_position}%"
        AND district.district_name = "${district}" 
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
async function filterLanguageDistrictByMonthly(job_position, district) {
  var query = `SELECT post_job.job_id,job_post_skill.language,membership.membership_name
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
        WHERE MONTH(post_job.posted_date) >= MONTH(NOW() - INTERVAL 1 MONTH)
        AND Date(expired_date) > Date(NOW())
        AND job_position.job_position_name LIKE "${job_position}%"
        AND district.district_name = "${district}" 
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

async function filterByDistrictMonthly(job_position, district, seeker_id) {
  var query = `SELECT job.*,applied_job.job_id as "isApplied",bookmark.job_id as "isBookmark"
  FROM (SELECT company.comapny_id,post_job.job_id, users.user_name,company.company_name,company.email_address,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
  post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
  post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
  INNER JOIN post_job on 
  company.comapny_id = post_job.company_id
  LEFT JOIN job_post_skill on
  post_job.job_id = job_post_skill.job_id
  LEFT JOIN job_position on
  job_post_skill.job_position_id = job_position.job_position_id
  WHERE MONTH(post_job.posted_date) >= MONTH(NOW() - INTERVAL 1 MONTH)
  AND Date(expired_date) > Date(NOW())
  AND job_position.job_position_name LIKE "${job_position}%"
  AND district.district_name = "${district}" 
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
/*-------------------------*/
module.exports.filterLanguageDistrictByWeekly = filterLanguageDistrictByWeekly;
module.exports.filterByDistrictMonthly = filterByDistrictMonthly;
module.exports.filterLanguageDistrictByMonthly =
  filterLanguageDistrictByMonthly;
module.exports.filterByDistrictWeekly = filterByDistrictWeekly;
module.exports.filterAllCompanyByMonth = filterAllCompanyByMonth;
module.exports.filterAllCompanyByMonthLanguages =
  filterAllCompanyByMonthLanguages;
module.exports.filterAllCompanyByWeekly = filterAllCompanyByWeekly;
module.exports.filterAllCompanyLanguagesByWeekly =
  filterAllCompanyLanguagesByWeekly;
module.exports.filterByJobTypeAndDistrict = filterByJobTypeAndDistrict;
module.exports.filterByJobType = filterByJobType;
module.exports.filterByDistrict = filterByDistrict;
module.exports.filterByWeekly = filterByWeekly;
module.exports.filterByMonthly = filterByMonthly;
module.exports.filterByJobTypeAndUserDateByWeekly =
  filterByJobTypeAndUserDateByWeekly;
module.exports.filterByJobTypeAndUserDateByMonthly =
  filterByJobTypeAndUserDateByMonthly;
module.exports.filterLanguageByJobTypeAndDistrict =
  filterLanguageByJobTypeAndDistrict;
module.exports.filterLanguageByJobType = filterLanguageByJobType;
module.exports.filterLanguageByDistrict = filterLanguageByDistrict;
module.exports.filterLanguageByWeekly = filterLanguageByWeekly;
module.exports.filterLanguageByMonthly = filterLanguageByMonthly;
module.exports.filterLanguageByJobTypeAndUserDateByWeekly =
  filterLanguageByJobTypeAndUserDateByWeekly;
module.exports.filterLanguageByJobTypeAndUserDateByMonthly =
  filterLanguageByJobTypeAndUserDateByMonthly;

/*
SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
WHERE MONTH(post_job.posted_date) >= MONTH(NOW() - INTERVAL 1 MONTH)
AND Date(expired_date) > Date(NOW()) AND company.comapny_id != '5' 
AND post_job.job_type = "${job_type}"
AND job_position.job_position_name LIKE "${job_position}%"
AND district.district_name = "${district}"
GROUP BY post_job.job_id 
ORDER BY post_job.posted_date ASC
*/
