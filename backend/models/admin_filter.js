const connection = require("../config/configuration.js");

async function filterAllByWeekly(job_position, job_type, district, filter) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
  post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
  post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
    WHERE YEARWEEK(post_job.posted_date) >= YEARWEEK(NOW() - INTERVAL 1 WEEK)
    ${filter}
    AND post_job.job_type = "${job_type}"
    AND job_position.job_position_name = "${job_position}"
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

async function filterLanguageAllByWeekly(
  job_position,
  job_type,
  district,
  filter
) {
  console.log(job_position);
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
      INNER JOIN job_post_skill on
      post_job.job_id = job_post_skill.job_id
      INNER JOIN job_position on
      job_post_skill.job_position_id = job_position.job_position_id
      WHERE YEARWEEK(post_job.posted_date) >= YEARWEEK(NOW() - INTERVAL 1 WEEK)
      ${filter}
      AND post_job.job_type = "${job_type}"
      AND job_position.job_position_name = "${job_position}"
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

async function filterAllByMonthly(job_position, job_type, district, filter) {
  console.log(job_position);
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
    post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
    post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
    WHERE MONTH(post_job.posted_date) >= MONTH(NOW() - INTERVAL 1 MONTH)
    ${filter}
    AND post_job.job_type = "${job_type}"
    AND job_position.job_position_name LIKE "${job_position}%"
    AND district.district_name = "${district}"
    GROUP BY post_job.job_id 
    ORDER BY membership.membership_name DESC`;
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

async function filterLanguageAllByMonthly(
  job_position,
  job_type,
  district,
  filter
) {
  console.log(job_position);
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
      INNER JOIN job_post_skill on
      post_job.job_id = job_post_skill.job_id
      INNER JOIN job_position on
      job_post_skill.job_position_id = job_position.job_position_id
      WHERE MONTH(post_job.posted_date) >= MONTH(NOW() - INTERVAL 1 MONTH)
      ${filter}
      AND post_job.job_type = "${job_type}"
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

async function filterByJobTypeAndDistrict(
  job_position,
  job_type,
  district,
  filter
) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
  post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
  post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
  WHERE 
  post_job.job_type = "${job_type}"
  AND job_position.job_position_name LIKE "${job_position}%"
  AND district.district_name = "${district}"
  ${filter}
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
  filter
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
    INNER JOIN job_post_skill on
    post_job.job_id = job_post_skill.job_id
    INNER JOIN job_position on
    job_post_skill.job_position_id = job_position.job_position_id
    WHERE post_job.job_type = "${job_type}"
    AND job_position.job_position_name LIKE "${job_position}%"
    AND district.district_name = "${district}" 
    ${filter}
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

async function filterByJobType(job_position, job_type, filter) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
    post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
    post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
    WHERE post_job.job_type = "${job_type}"
    AND job_position.job_position_name LIKE "${job_position}%"
    ${filter}
    GROUP BY post_job.job_id 
    ORDER BY membership.membership_name DESC`;
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

async function filterLanguageByJobType(job_position, job_type, filter) {
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
      INNER JOIN job_post_skill on
      post_job.job_id = job_post_skill.job_id
      INNER JOIN job_position on
      job_post_skill.job_position_id = job_position.job_position_id
      WHERE post_job.job_type = "${job_type}"
      AND job_position.job_position_name LIKE "${job_position}%"
      ${filter}
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

async function filterByDistrict(job_position, district, filter) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
    post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
    post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
    WHERE job_position.job_position_name LIKE "${job_position}%"
    AND district.district_name = "${district}"
    ${filter}
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

async function filterLanguageByDistrict(job_position, district, filter) {
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
      INNER JOIN job_post_skill on
      post_job.job_id = job_post_skill.job_id
      INNER JOIN job_position on
      job_post_skill.job_position_id = job_position.job_position_id
      WHERE job_position.job_position_name LIKE "${job_position}%"
      AND district.district_name = "${district}" 
      ${filter}
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

async function filterByWeeklyDate(job_position, filter) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
  post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
  post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
  WHERE YEARWEEK(post_job.posted_date) >= YEARWEEK(NOW() - INTERVAL 1 WEEK)
  ${filter}
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

async function filterLanguageByWeeklyDate(job_position, filter) {
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
    INNER JOIN job_post_skill on
    post_job.job_id = job_post_skill.job_id
    INNER JOIN job_position on
    job_post_skill.job_position_id = job_position.job_position_id
    WHERE YEARWEEK(post_job.posted_date) >= YEARWEEK(NOW() - INTERVAL 1 WEEK)
    ${filter}
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
async function filterByMonthly(job_position, filter) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
    post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
    post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
    WHERE MONTH(post_job.posted_date) >= MONTH(NOW() - INTERVAL 1 MONTH)
    ${filter}
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

async function filterLanguageByMonthly(job_position, filter) {
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
      INNER JOIN job_post_skill on
      post_job.job_id = job_post_skill.job_id
      INNER JOIN job_position on
      job_post_skill.job_position_id = job_position.job_position_id
      WHERE MONTH(post_job.posted_date) > MONTH(NOW() - INTERVAL 1 MONTH)
      ${filter}
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

async function filterByJobTypeAndUserDateByWeekly(
  job_position,
  job_type,
  filter
) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
  post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
  post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
  WHERE YEARWEEK(post_job.posted_date) >= YEARWEEK(NOW() - INTERVAL 1 WEEK)
  ${filter}
  AND job_position.job_position_name LIKE "${job_position}%"
  AND post_job.job_type = "${job_type}"
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

async function filterLanguageByJobTypeAndUserDateByWeekly(
  job_position,
  job_type,
  filter
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
    INNER JOIN job_post_skill on
    post_job.job_id = job_post_skill.job_id
    INNER JOIN job_position on
    job_post_skill.job_position_id = job_position.job_position_id
    WHERE YEARWEEK(post_job.posted_date) >= YEARWEEK(NOW() - INTERVAL 1 WEEK)
    ${filter}
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

async function filterByJobTypeAndUserDateByMonthly(
  job_position,
  job_type,
  filter
) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
    post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
    post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
    WHERE MONTH(post_job.posted_date) >= MONTH(NOW() - INTERVAL 1 MONTH)
    ${filter}
    AND job_position.job_position_name LIKE "${job_position}%"
    AND post_job.job_type = "${job_type}"
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
  filter
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
      INNER JOIN job_post_skill on
      post_job.job_id = job_post_skill.job_id
      INNER JOIN job_position on
      job_post_skill.job_position_id = job_position.job_position_id
      WHERE MONTH(post_job.posted_date) >= MONTH(NOW() - INTERVAL 1 MONTH)
      ${filter}
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

async function filterByWeekly(job_position, filter) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
    post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
    post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
    LEFT JOIN job_post_skill on
    post_job.job_id = job_post_skill.job_id
    LEFT JOIN job_position on
    job_post_skill.job_position_id = job_position.job_position_id
    WHERE YEARWEEK(post_job.posted_date) >= YEARWEEK(NOW() - INTERVAL 1 WEEK)
    ${filter}
    AND job_position.job_position_name LIKE "${job_position}%"
    AND Date(expired_date) > Date(NOW())
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
async function filterLanguageByWeekly(job_position, filter) {
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
      ${filter}
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

async function filterByDistrictWeekly(job_position, district, filter) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
  post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
  post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
  LEFT JOIN job_post_skill on
  post_job.job_id = job_post_skill.job_id
  LEFT JOIN job_position on
  job_post_skill.job_position_id = job_position.job_position_id
  WHERE YEARWEEK(post_job.posted_date) >= YEARWEEK(NOW() - INTERVAL 1 WEEK)
  ${filter}
  AND Date(expired_date) > Date(NOW())
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

async function filterLanguageDistrictByWeekly(job_position, district, filter) {
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
        ${filter}
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

async function filterByDistrictMonthly(job_position, district, filter) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
  post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
  post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
  LEFT JOIN job_post_skill on
  post_job.job_id = job_post_skill.job_id
  LEFT JOIN job_position on
  job_post_skill.job_position_id = job_position.job_position_id
  WHERE MONTH(post_job.posted_date) >= MONTH(NOW() - INTERVAL 1 MONTH)
  ${filter}
  AND job_position.job_position_name LIKE "${job_position}%"
  AND district.district_name = "${district}" 
  GROUP BY post_job.job_id 
  ORDER BY membership.membership_name DESC`;
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

async function filterLanguageDistrictByMonthly(job_position, district, filter) {
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
        ${filter}
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

async function filterByChoosenJobStatus(job_position, filter) {
  var query = `SELECT post_job.job_id, users.user_name,company.company_name,company.email_address,company.contact_no,company.website,company.contact_no,company.company_description,company.image_path,district.district_name,
    post_job.job_description,post_job.posted_date,post_job.expired_date,post_job.job_type,post_job.salary,
    post_job.experience,post_job.is_negotiable,post_job.minimum_education,job_position.job_position_name,post_job.job_title,post_job.job_specification
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
    WHERE job_position.job_position_name LIKE "${job_position}%"
    ${filter}
    GROUP BY post_job.job_id 
    ORDER BY membership.membership_name DESC`;
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

async function filterLanguageByChoosenJobStatus(job_position, filter) {
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
        ${filter}
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
module.exports.filterLanguageByChoosenJobStatus =
  filterLanguageByChoosenJobStatus;
module.exports.filterByChoosenJobStatus = filterByChoosenJobStatus;
module.exports.filterLanguageDistrictByMonthly =
  filterLanguageDistrictByMonthly;
module.exports.filterByDistrictMonthly = filterByDistrictMonthly;
module.exports.filterLanguageDistrictByWeekly = filterLanguageDistrictByWeekly;
module.exports.filterByDistrictWeekly = filterByDistrictWeekly;
module.exports.filterLanguageByWeekly = filterLanguageByWeekly;
module.exports.filterByWeekly = filterByWeekly;
module.exports.filterAllByWeekly = filterAllByWeekly;
module.exports.filterAllByMonthly = filterAllByMonthly;
module.exports.filterByJobTypeAndDistrict = filterByJobTypeAndDistrict;
module.exports.filterByJobType = filterByJobType;
module.exports.filterByDistrict = filterByDistrict;
module.exports.filterByWeeklyDate = filterByWeeklyDate;
module.exports.filterByMonthly = filterByMonthly;
module.exports.filterByJobTypeAndUserDateByWeekly =
  filterByJobTypeAndUserDateByWeekly;
module.exports.filterByJobTypeAndUserDateByMonthly =
  filterByJobTypeAndUserDateByMonthly;

module.exports.filterLanguageAllByWeekly = filterLanguageAllByWeekly;
module.exports.filterLanguageAllByMonthly = filterLanguageAllByMonthly;
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
