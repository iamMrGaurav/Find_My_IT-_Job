const express = require("express");
const path = require("path");
const { response } = require("express");
const seekerModel = require("../models/seeker.js");
const companyModel = require("../models/comapny_side.js");
const adminController = require("../controllers/admin.js");
const filterModel = require("../models/seeker_side_filter.js");

async function createProfile(req, res) {
  try {
    var image_path = req.files;
    var photo;
    var cv;
    var first_name = req.body.first_name;
    var last_name = req.body.last_name;
    var email_address = req.body.email_address;
    var dob = req.body.dob;
    var highest_qualification = req.body.highest_qualification;
    var user_id = req.body.user_id;
    var work_experience = req.body.work_experience;
    var district_name = req.body.district_name;
    var bio = req.body.bio;
    var contact_no = req.body.contact_no;
    var job_position = req.body.job_position;
    var languages = req.body.languages;
    var ownJobPosition = req.body.ownJobPosition;
    let languageList = languages.split(",");

    if (image_path[0].fieldname == "photo") {
      photo = image_path[0]["path"];
    }

    if (image_path[1].fieldname == "cv") {
      cv = image_path[1]["path"];
    }

    if (
      first_name &&
      last_name &&
      email_address &&
      dob &&
      highest_qualification &&
      user_id &&
      work_experience &&
      district_name &&
      bio
    ) {
      var data = await companyModel.getDistrictId(district_name);
      var result = await seekerModel.createProfile(
        first_name,
        last_name,
        email_address,
        dob,
        highest_qualification,
        user_id,
        photo,
        cv,
        data[0]["district_id"],
        work_experience,
        bio,
        contact_no,
        ownJobPosition
      );
      console.log(result);
      var response = await companyModel.getJobPositionId(job_position);

      let values = "";

      for (i = 0; i < languageList.length; i++) {
        let val = `(${result.insertId},${response[0].job_position_id},'${languageList[i]}')`;
        if (i != languageList.length - 1) {
          values += val + ",";
        } else {
          values += val;
        }
      }

      var serverResponse = await seekerModel.inserIntoSeekerSkill(values);

      if (result.affectedRows > 0) {
        res.status(200);
        res.json({
          status: "success",
          message: "Data updated successfully",
        });
      } else {
        res.status(400);
        res.json({
          status: "error",
          message: "Unable to update data",
        });
      }
    } else {
      res.status(400);
      res.json({
        status: "error",
        message: "No data",
      });
    }
  } catch (exception) {
    res.status(400);
    res.json({
      status: "error",
      message: "Internal server error",
    });
  }
}

async function fetchSeekerProfileDetail(req, res) {
  try {
    var seeker_id = req.body.seeker_id;

    var seekerDetail = await seekerModel.fetchSeekerProfileDetail(seeker_id);

    var seekerLanguageDetail = await seekerModel.fetchSeekerProfileLanguage(
      seeker_id
    );
    let ln = {};

    for (let i = 0; i < seekerDetail.length; i++) {
      ln[seekerDetail[i].seeker_id] = [];
    }

    seekerLanguageDetail.map((language) => {
      ln[language.seeker_id].push(language.language);
    });

    res.status(200);
    res.json({
      status: "success",
      message: "Job Fetched Successfully",
      data: seekerDetail.map((jb) => {
        jb[`languages`] = ln[jb.seeker_id];
        return jb;
      }),
    });
  } catch (exception) {
    res.json({
      status: "error",
      message: "Internal server error",
    });
  }
}

async function filterData(req, res) {
  var jobPosition = req.body.job_position;

  if (jobPosition == "nothing") {
    jobPosition = "";
  }

  var jobType = req.body.job_type;
  var district = req.body.district;
  var userDate = req.body.user_date;
  var seeker_id = req.body.seeker_id;
  try {
    if (
      jobType != "Select jobType" &&
      district != "Select district" &&
      userDate != "Select Date"
    ) {
      if (userDate == "This Month") {
        var postJobDetails = await filterModel.filterAllCompanyByMonth(
          jobPosition,
          jobType,
          district,
          seeker_id
        );
        var postJobLanguage =
          await filterModel.filterAllCompanyByMonthLanguages(
            jobPosition,
            jobType,
            district
          );

        adminController.SendJson(postJobDetails, postJobLanguage, res);
      } else {
        var postJobDetails = await filterModel.filterAllCompanyByWeekly(
          jobPosition,
          jobType,
          district,
          seeker_id
        );

        var postJobLanguage =
          await filterModel.filterAllCompanyLanguagesByWeekly(
            jobPosition,
            jobType,
            district
          );

        adminController.SendJson(postJobDetails, postJobLanguage, res);
      }
    } else if (jobType != "Select jobType" && district != "Select district") {
      var postJobDetails = await filterModel.filterByJobTypeAndDistrict(
        jobPosition,
        jobType,
        district,
        seeker_id
      );
      var postJobLanguage =
        await filterModel.filterLanguageByJobTypeAndDistrict(
          jobPosition,
          jobType,
          district
        );
      adminController.SendJson(postJobDetails, postJobLanguage, res);
    } else if (
      jobType != "Select jobType" &&
      userDate == "Select Date" &&
      district == "Select district"
    ) {
      var postJobDetails = await filterModel.filterByJobType(
        jobPosition,
        jobType,
        seeker_id
      );

      var postJobLanguage = await filterModel.filterLanguageByJobType(
        jobPosition,
        jobType
      );

      adminController.SendJson(postJobDetails, postJobLanguage, res);
    } else if (
      district != "Select district" &&
      jobType == "Select jobType" &&
      userDate == "Select Date"
    ) {
      var postJobDetails = await filterModel.filterByDistrict(
        jobPosition,
        district,
        seeker_id
      );
      var postJobLanguage = await filterModel.filterLanguageByDistrict(
        jobPosition,
        district
      );

      adminController.SendJson(postJobDetails, postJobLanguage, res);
    } else if (
      userDate == "This Month" &&
      district == "Select district" &&
      jobType == "Select jobType"
    ) {
      var postJobDetails = await filterModel.filterByMonthly(
        jobPosition,
        seeker_id
      );
      var postJobLanguage = await filterModel.filterLanguageByMonthly(
        jobPosition
      );

      adminController.SendJson(postJobDetails, postJobLanguage, res);
    } else if (
      userDate == "This Week" &&
      district == "Select district" &&
      jobType == "Select jobType"
    ) {
      var postJobDetails = await filterModel.filterByWeekly(
        jobPosition,
        seeker_id
      );
      var postJobLanguage = await filterModel.filterLanguageByWeekly(
        jobPosition
      );

      adminController.SendJson(postJobDetails, postJobLanguage, res);
    } else if (
      jobType != "Select jobType" &&
      userDate == "This Month" &&
      district == "Select district"
    ) {
      var postJobDetails =
        await filterModel.filterByJobTypeAndUserDateByMonthly(
          jobPosition,
          jobType,
          seeker_id
        );
      var postJobLanguage =
        await filterModel.filterLanguageByJobTypeAndUserDateByMonthly(
          jobPosition,
          jobType
        );

      adminController.SendJson(postJobDetails, postJobLanguage, res);
    } else if (
      jobType != "Select jobType" &&
      userDate == "This Week" &&
      district == "Select district"
    ) {
      var postJobDetails = await filterModel.filterByJobTypeAndUserDateByWeekly(
        jobPosition,
        jobType,
        seeker_id
      );
      var postJobLanguage =
        await filterModel.filterLanguageByJobTypeAndUserDateByWeekly(
          jobPosition,
          jobType
        );

      adminController.SendJson(postJobDetails, postJobLanguage, res);
    } else if (
      jobType == "Select jobType" &&
      userDate == "This Week" &&
      district != "Select district"
    ) {
      var postJobDetails = await filterModel.filterByDistrictWeekly(
        jobPosition,
        district,
        seeker_id
      );
      var postJobLanguage = await filterModel.filterLanguageDistrictByWeekly(
        jobPosition,

        district
      );

      adminController.SendJson(postJobDetails, postJobLanguage, res);
    } else if (
      jobType == "Select jobType" &&
      userDate == "This Month" &&
      district != "Select district"
    ) {
      var postJobDetails = await filterModel.filterByDistrictMonthly(
        jobPosition,
        district,
        seeker_id
      );
      var postJobLanguage = await filterModel.filterLanguageDistrictByMonthly(
        jobPosition,

        district
      );

      adminController.SendJson(postJobDetails, postJobLanguage, res);
    } else {
      res.json({
        status: "error",
      });
    }
  } catch (exception) {
    res.status(400);
    res.json({
      status: "failed",
      message: "Server Error",
    });
  }
}

async function getOtherCompanyJob(req, res) {
  try {
    var seeker_id = req.body.seeker_id;
    var postJobDetails = await seekerModel.getOtherCompanyJobs(seeker_id);
    var postJobLanguage = await seekerModel.getOtherCompanyJobLanguages();

    if (postJobDetails && postJobLanguage) {
      let ln = {};

      for (let i = 0; i < postJobDetails.length; i++) {
        ln[postJobDetails[i].job_id] = [];
      }

      postJobLanguage.map((language) => {
        ln[language.job_id].push(language.language);
      });

      res.status(200);
      res.json({
        status: "success",
        message: "Job Fetched Successfully",
        data: postJobDetails.map((jb) => {
          jb[`languages`] = ln[jb.job_id];
          return jb;
        }),
      });
    } else {
      res.status(400);
      res.json({
        status: "failed",
        message: "Please provide complete details",
      });
    }
  } catch (exception) {
    res.status(400);
    res.json({
      status: "error",
      message: "Internal Server Error",
    });
  }
}

async function searchOtherCompanyPost(req, res) {
  try {
    var job_position = req.body.job_position;
    var seeker_id = req.body.seeker_id;

    if (job_position == "nothing") {
      job_position = "";
    }

    var postJobDetails = await seekerModel.searchOtherCompanyJobs(
      job_position,
      seeker_id
    );

    var postJobLanguage = await seekerModel.searchOtherCompanyJobLanguages(
      job_position
    );

    let ln = {};

    for (let i = 0; i < postJobDetails.length; i++) {
      ln[postJobDetails[i].job_id] = [];
    }

    postJobLanguage.map((language) => {
      ln[language.job_id].push(language.language);
    });

    if (postJobDetails) {
      if (postJobLanguage) {
        let a = postJobDetails.map((jb) => {
          jb[`languages`] = ln[jb.job_id];
          return jb;
        });

        res.status(200);
        res.json({
          status: "success",
          message: "Data fetched successfully",
          postJob: a,
        });
      } else {
        res.status(400);
        res.json({
          status: "failed",
          message: "Data Not Available",
        });
      }
    } else {
      res.status(400);
      res.json({
        status: "failed",
        message: "Data Not Available",
      });
    }
  } catch (exception) {
    res.status(400);
    res.json({
      status: "failed",
      message: "Server Error",
    });
  }
}

async function updateProfileImage(req, res) {
  try {
    var image_path = req.file.path;
    var seeker_id = req.body.seeker_id;

    console.log(seeker_id);

    if (image_path) {
      var result = await seekerModel.updateProfileImage(seeker_id, image_path);

      if (result.affectedRows > 0) {
        res.status(200);
        res.json({
          status: "success",
          message: "Data updated successfully",
        });
      } else {
        res.status(400);
        res.json({
          status: "error",
          message: "Unable to update data",
        });
      }
    } else {
      res.status(400);
      res.json({
        status: "error",
        message: "No data",
      });
    }
  } catch (exception) {
    console.log(exception);
    res.status(400);
    res.json({
      status: "failed",
      message: "Server Error",
    });
  }
}

async function updateProfileCV(req, res) {
  try {
    var cv = req.file.path;
    var seeker_id = req.body.seeker_id;

    var result = await seekerModel.updateProfileCV(seeker_id, cv);
    if (result.affectedRows > 0) {
      res.status(200);
      res.json({
        status: "success",
        message: "Data updated successfully",
      });
    } else {
      res.status(400);
      res.json({
        status: "error",
        message: "Unable to update data",
      });
    }
  } catch (exception) {
    res.status(400);
    res.json({
      status: "failed",
      message: "Server Error",
    });
  }
}

async function updateSeekerProfile(req, res) {
  try {
    // var image_path = req.files;
    // var photo;
    // var cv;
    var first_name = req.body.first_name;
    var last_name = req.body.last_name;
    var email_address = req.body.email_address;
    var highest_qualification = req.body.highest_qualification;
    var seeker_id = req.body.seeker_id;
    var work_experience = req.body.work_experience;
    var district_name = req.body.district_name;
    var bio = req.body.bio;
    var contact_no = req.body.contact_no;
    var job_position = req.body.job_position;
    var languages = req.body.languages;
    var ownJobPosition = req.body.ownJobPosition;
    let languageList = languages.split(",");

    // if (image_path[0].fieldname == "photo") {
    //   photo = image_path[0]["path"];
    // }

    // if (image_path[1].fieldname == "cv") {
    //   cv = image_path[1]["path"];
    // }

    if (
      first_name &&
      last_name &&
      email_address &&
      highest_qualification &&
      seeker_id &&
      work_experience &&
      district_name &&
      bio
    ) {
      var data = await companyModel.getDistrictId(district_name);
      var result = await seekerModel.updateSeekerProfile(
        first_name,
        last_name,
        email_address,
        highest_qualification,
        // photo,
        // cv,
        data[0]["district_id"],
        work_experience,
        bio,
        contact_no,
        ownJobPosition,
        seeker_id
      );

      var deleteLanguages = await seekerModel.deleteSeekerSkill(seeker_id);

      var response = await companyModel.getJobPositionId(job_position);

      let values = "";

      for (i = 0; i < languageList.length; i++) {
        let val = `(${seeker_id},${response[0]["job_position_id"]},'${languageList[i]}')`;

        if (i != languageList.length - 1) {
          values += val + ",";
        } else {
          values += val;
        }
      }
      var serverResponse = await seekerModel.inserIntoSeekerSkill(values);

      if (result.affectedRows > 0) {
        res.status(200);
        res.json({
          status: "success",
          message: "Data updated successfully",
        });
      } else {
        res.status(400);
        res.json({
          status: "error",
          message: "Unable to update data",
        });
      }
    } else {
      res.status(400);
      res.json({
        status: "error",
        message: "No data",
      });
    }
  } catch (exception) {
    res.status(400);
    res.json({
      status: "failed",
      message: "Server Error",
    });
  }
}

async function applyJob(req, res) {
  try {
    var job_id = req.body.job_id;
    var seeker_id = req.body.seeker_id;

    if (job_id && seeker_id) {
      var data = await seekerModel.checkApplicationExistence(seeker_id, job_id);
      if (data.length > 0) {
        res.status(200);
        res.json({
          status: "success",
          message: "User has already applied",
        });
      } else {
        let date = new Date();
        let currentDate =
          date.getFullYear() +
          "-" +
          (date.getMonth() + 1) +
          "-" +
          date.getDate();

        var response = await seekerModel.applyJob(
          seeker_id,
          job_id,
          currentDate
        );
        if ((response.affectedRows = 1)) {
          res.status(200);
          res.json({
            status: "success",
            message: "Applied successfully",
          });
        } else {
          res.status(400);
          res.json({
            status: "failed",
            message: "Something went wrong!",
          });
        }
      }
    }
  } catch (exception) {
    res.status(400);
    res.json({
      status: "failed",
      message: "Server Error",
    });
  }
}

async function addBookmark(req, res) {
  try {
    var job_id = req.body.job_id;
    var seeker_id = req.body.seeker_id;

    if (job_id && seeker_id) {
      var data = await seekerModel.checkBookmarkExistence(seeker_id, job_id);

      if (data.length > 0) {
        res.status(200);
        res.json({
          status: "success",
          message: "Already Bookmark applied",
        });
      } else {
        var response = await seekerModel.addBookmark(seeker_id, job_id);
        if ((response.affectedRows = 1)) {
          res.status(200);
          res.json({
            status: "success",
            message: "Bookmarked successfully",
          });
        } else {
          res.status(400);
          res.json({
            status: "failed",
            message: "Something went wrong!",
          });
        }
      }
    }
  } catch (exception) {
    //.log(exception);
    res.status(400);
    res.json({
      status: "failed",
      message: "Server Error",
    });
  }
}

async function getBookmarkJob(req, res) {
  try {
    var seeker_id = req.body.seeker_id;

    if (seeker_id) {
      var postJobDetails = await seekerModel.getBookmarkJobs(seeker_id);
      var postJobLanguage = await seekerModel.getBookmarkJobLanguage(seeker_id);

      adminController.SendJson(postJobDetails, postJobLanguage, res);
    } else {
      res.status(400);
      res.json({
        status: "failed",
        message: "Please provide seeker_id",
      });
    }
  } catch (exception) {
    //.log(exception);
    res.status(400);
    res.json({
      status: "failed",
      message: "Internal server error",
      data: response,
    });
  }
}

async function getAppliedJob(req, res) {
  try {
    var seeker_id = req.body.seeker_id;

    if (seeker_id) {
      var postJobDetails = await seekerModel.getAppliedJob(seeker_id);
      var postJobLanguage = await seekerModel.getAppliedJobLanguage(seeker_id);

      adminController.SendJson(postJobDetails, postJobLanguage, res);
    } else {
      res.status(400);
      res.json({
        status: "failed",
        message: "Please provide seeker_id",
      });
    }
  } catch (exception) {
    //.log(exception);
    res.status(400);
    res.json({
      status: "failed",
      message: "Internal server error",
      data: response,
    });
  }
}

async function getUserPreferJob(req, res) {
  try {
    var job_position = req.body.job_position;
    var seeker_id = req.body.seeker_id;
    if (job_position && seeker_id) {
      var postJobDetails = await seekerModel.fetchUserPreferJobs(
        job_position,
        seeker_id
      );
      var postJobLanguage = await seekerModel.userPreferJobLanguage(
        job_position
      );
      adminController.SendJson(postJobDetails, postJobLanguage, res);
    } else {
      res.status(400);
      res.json({
        status: "failed",
        message: "Please provide job_position",
      });
    }
  } catch (exception) {
    //.log(exception);
    res.status(400);
    res.json({
      status: "failed",
      message: "Internal server error",
      data: response,
    });
  }
}

async function deleteBookmark(req, res) {
  try {
    if (req.body.seeker_id && req.body.job_id) {
      var response = await seekerModel.deleteBookmark(
        req.body.seeker_id,
        req.body.job_id
      );
      if (response.affectedRows == 0) {
        res.status(400);
        res.json({
          status: "failed",
          message: "Sorry we cannot removed bookmark. Please try again",
        });
      } else {
        res.status(200);
        res.json({
          status: "success",
          message: "Bookmark removed.",
        });
      }
    }
  } catch (exception) {
    res.status(400);

    res.json({
      status: "failed",
      message: "Server Error",
    });
  }
}

async function addBookmark(req, res) {
  try {
    if (req.body.seeker_id && req.body.job_id) {
      var response = await seekerModel.addBookmark(
        req.body.seeker_id,
        req.body.job_id
      );
      if (response.affectedRows == 0) {
        res.status(400);
        res.json({
          status: "failed",
          message: "Sorry we cannot added bookmark. Please try again",
        });
      } else {
        res.status(200);
        res.json({
          status: "success",
          message: "Bookmark added.",
        });
      }
    }
  } catch (exception) {
    res.status(400);
    res.json({
      status: "failed",
      message: "Server Error",
    });
  }
}

module.exports.updateProfileImage = updateProfileImage;
module.exports.updateProfileCV = updateProfileCV;
module.exports.addBookmark = addBookmark;
module.exports.deleteBookmark = deleteBookmark;
module.exports.fetchSeekerProfileDetail = fetchSeekerProfileDetail;
module.exports.addBookmark = addBookmark;
module.exports.getUserPreferJob = getUserPreferJob;
module.exports.getAppliedJob = getAppliedJob;
module.exports.updateSeekerProfile = updateSeekerProfile;
module.exports.getBookmarkJob = getBookmarkJob;
module.exports.applyJob = applyJob;
module.exports.searchOtherCompanyPost = searchOtherCompanyPost;
module.exports.getOtherCompanyJob = getOtherCompanyJob;
module.exports.filterData = filterData;
module.exports.fetchSeekerProfileDetail = fetchSeekerProfileDetail;
module.exports.createProfile = createProfile;
