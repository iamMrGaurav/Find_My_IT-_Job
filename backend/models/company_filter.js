const connection = require("../config/configuration.js");

async function filterAllCompanyByMonth(
  company_id,
  job_position,
  job_type,
  district
) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
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
    AND Date(expired_date) > Date(NOW()) AND company.comapny_id != '${company_id}'
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

async function filterAllCompanyByMonthLanguages(
  company_id,
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
    AND Date(expired_date) > Date(NOW()) AND company.comapny_id != '${company_id}'
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
  company_id,
  job_position,
  job_type,
  district
) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
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
      WHERE WEEK(post_job.posted_date) >= WEEK(NOW() - INTERVAL 1 WEEK)
      AND Date(expired_date) > Date(NOW()) AND company.comapny_id != "${company_id}"
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

async function filterAllCompanyLanguagesByWeekly(
  company_id,
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
      AND Date(expired_date) > Date(NOW()) AND company.comapny_id != '${company_id}'
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

async function filterByJobTypeAndDistrict(
  job_position,
  job_type,
  district,
  company_id
) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
    post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
    post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
    AND Date(expired_date) > Date(NOW()) AND company.comapny_id != '${company_id}'
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

async function filterLanguageByJobTypeAndDistrict(
  job_position,
  job_type,
  district,
  company_id
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
      AND Date(expired_date) > Date(NOW()) AND company.comapny_id != '${company_id}'
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

async function filterByJobType(job_position, job_type, company_id) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
      post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
      post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
      AND Date(expired_date) > Date(NOW()) AND company.comapny_id != '${company_id}'
      AND job_position.job_position_name LIKE "${job_position}%"
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

async function filterLanguageByJobType(job_position, job_type, company_id) {
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
        AND Date(expired_date) > Date(NOW()) AND company.comapny_id != '${company_id}'
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

async function filterByDistrict(job_position, district, company_id) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
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
      WHERE job_position.job_position_name LIKE "${job_position}%"
      AND district.district_name = "${district}"
      AND Date(expired_date) > Date(NOW()) AND company.comapny_id != '${company_id}'
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

async function filterLanguageByDistrict(job_position, district, company_id) {
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
        AND Date(expired_date) > Date(NOW()) AND company.comapny_id != '${company_id}'
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

async function filterByWeeklyDate(job_position, company_id) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
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
    AND job_position.job_position_name LIKE "${job_position}%"
    AND Date(expired_date) > Date(NOW()) AND company.comapny_id != '${company_id}'
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

async function filterLanguageByWeeklyDate(job_position, company_id) {
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
      AND Date(expired_date) > Date(NOW()) AND company.comapny_id != '${company_id}'
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

async function filterByMonthly(job_position, company_id) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
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
      AND job_position.job_position_name LIKE "${job_position}%"
      AND Date(expired_date) > Date(NOW()) AND company.comapny_id != '${company_id}'
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

async function filterLanguageByMonthly(job_position, company_id) {
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
        AND Date(expired_date) > Date(NOW()) AND company.comapny_id != '${company_id}'
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
  company_id
) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
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
  AND company.comapny_id != ${company_id}
  GROUP BY post_job.job_id 
  ORDER BY membership.membership_name DESC;`;

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
  job_type,
  company_id
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
      AND company.comapny_id != ${company_id}
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
  company_id
) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
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
  AND company.comapny_id != ${company_id}
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

async function filterLanguageByJobTypeAndUserDateByMonthly(
  job_position,
  job_type,
  company_id
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
        AND company.comapny_id != ${company_id}
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

async function filterByDistrictWeekly(job_position, company_id, district) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
  post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
  post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
  AND company.comapny_id != ${company_id}
  AND district.district_name = "${district}" 
  GROUP BY post_job.job_id 
  ORDER BY membership.membership_name DESC;`;

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

async function filterLanguageDistrictByWeekly(
  job_position,
  company_id,
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
        WHERE YEARWEEK(post_job.posted_date) >= YEARWEEK(NOW() - INTERVAL 1 WEEK)
        AND Date(expired_date) > Date(NOW())
        AND job_position.job_position_name LIKE "${job_position}%"
        AND company.comapny_id != ${company_id}
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

async function filterLanguageDistrictByMonthly(
  job_position,
  company_id,
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
        AND job_position.job_position_name LIKE "${job_position}%"
        AND company.comapny_id != ${company_id}
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

async function filterByDistrictMonthly(job_position, company_id, district) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
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
  AND company.comapny_id != ${company_id}
  AND district.district_name = "${district}" 
  GROUP BY post_job.job_id 
  ORDER BY membership.membership_name DESC;`;

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
module.exports.filterByWeeklyDate = filterByWeeklyDate;
module.exports.filterByMonthly = filterByMonthly;
module.exports.filterByJobTypeAndUserDateByWeekly =
  filterByJobTypeAndUserDateByWeekly;
module.exports.filterByJobTypeAndUserDateByMonthly =
  filterByJobTypeAndUserDateByMonthly;
module.exports.filterLanguageByJobTypeAndDistrict =
  filterLanguageByJobTypeAndDistrict;
module.exports.filterLanguageByJobType = filterLanguageByJobType;
module.exports.filterLanguageByDistrict = filterLanguageByDistrict;
module.exports.filterLanguageByWeeklyDate = filterLanguageByWeeklyDate;
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
