const express = require("express");
const companyModel = require("../models/comapny_side.js");
const path = require("path");
const multer = require("multer");
const { response } = require("express");
const adminController = require("../controllers/admin.js");
const filterModel = require("../models/company_filter.js");
const axios = require("axios");
const dotenv = require("dotenv");
dotenv.config();

async function sendMessage(req, res) {
  try {
    var company_id = req.body.company_id;
    var seeker_id = req.body.seeker_id;
    var text_message = req.body.text_message;
    var isSender = req.body.isSender;
    var message_date = req.body.message_date;

    if (seeker_id && company_id && text_message && isSender && message_date) {
      var response = await companyModel.postMessage(
        company_id,
        seeker_id,
        text_message,
        isSender,
        message_date
      );

      if (response.affectedRows == 1) {
        res.status(200);
        res.json({
          status: "success",
          message: "Message sent successfully",
        });
      } else {
        res.status(400);
        res.json({
          status: "failed",
          message: "Sorry cannot send message",
        });
      }
    }
  } catch (error) {
    res.status(400);
    res.json({
      status: "failed",
      message: "Internal Server Error",
    });
  }
}

async function getMessage(req, res) {
  try {
    var company_id = req.body.company_id;
    var seeker_id = req.body.seeker_id;

    if (seeker_id && company_id) {
      var response = await companyModel.getMessage(company_id, seeker_id);
      if (response) {
        res.status(200);
        res.json({
          status: "success",
          message: "Message fetched",
          data: response,
        });
      } else {
        res.status(200);
        res.json({
          status: "success",
          message: "No message found yet",
          data: response,
        });
      }
    }
  } catch (error) {
    res.status(400);
    res.json({
      status: "failed",
      message: "Internal Server Error",
    });
  }
}

async function getChatScreen(req, res) {
  try {
    if (req.body.company_id) {
      var response = await companyModel.getChatScreen(req.body.company_id);
      console.log(response);
      if (response) {
        res.status(200);
        res.json({
          status: "success",
          data: response,
        });
      } else {
        res.status(400);
        res.json({
          status: "failed",
          message: "No data found",
        });
      }
    }
  } catch (error) {
    res.status(400);
    res.json({
      status: "failed",
      message: "Internal Server Error",
    });
  }
}

async function postJob(req, res) {
  console.log(req.body);
  var job_description = req.body.job_description;
  var posted_date = req.body.posted_date;
  var company_id = req.body.company_id;
  var job_type = req.body.job_type;
  var salary = req.body.salary;
  var expired_date = req.body.expired_date;
  var experience = req.body.experience;
  var minimum_education = req.body.minimum_education;
  var is_negotiable = req.body.is_negotiable;
  var job_title = req.body.job_title;
  var job_specification = req.body.job_specification;
  var languages = req.body.languages;

  try {
    let languageList = languages.split(",");
    console.log(languageList);
    if (
      job_description &&
      posted_date &&
      company_id &&
      job_type &&
      salary &&
      expired_date &&
      experience &&
      minimum_education &&
      is_negotiable &&
      job_specification
    ) {
      var result = await companyModel.posJob(
        job_description,
        posted_date,
        company_id,
        job_type,
        salary,
        expired_date,
        experience,
        minimum_education,
        is_negotiable,
        job_title,
        job_specification
      );

      var response = await companyModel.getJobPositionId(req.body.job_position);
      console.log(response);
      for (i = 0; i < languageList.length; i++) {
        console.log(languageList[i]);
        var serverResponse = await companyModel.inserIntoJobPostSkill(
          result.insertId,
          languageList[i],
          response[0]["job_position_id"]
        );
      }

      res.status(200);
      res.json({
        status: "success",
        message: "Job Posted Successfully",
        data: result,
      });
    } else {
      res.status(400);
      res.json({
        status: "failed",
        message: "Please provide complete details",
      });
    }
  } catch (exception) {
    console.log(exception);
    res.status(400);
    res.json({
      status: "error",
      message: "Internal Server Error",
    });
  }
}

async function fetchJob(req, res) {
  var index = req.body.index;
  var company_id = req.body.company_id;
  try {
    if (index && company_id) {
      var postJobDetails = await companyModel.getCompnayPostJobDetails(
        index,
        company_id
      );
      var postJobLanguage = await companyModel.getPostJobLanguages(company_id);

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
    console.log(exception);
    res.status(400);
    res.json({
      status: "error",
      message: "Internal Server Error",
    });
  }
}

async function getOtherCompanyJob(req, res) {
  var company_id = req.body.company_id;
  try {
    if (company_id) {
      var postJobDetails = await companyModel.getOtherCompanyJobs(company_id);
      var postJobLanguage = await companyModel.getOtherCompanyJobLanguages(
        company_id
      );
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
    console.log(exception);
    res.status(400);
    res.json({
      status: "error",
      message: "Internal Server Error",
    });
  }
}

async function getSeekerDetail(req, res) {
  try {
    var seekerDetail = await companyModel.fetchSeekerDetail();
    if (seekerDetail.length > 0) {
      var seekerLanguageDetail = await companyModel.fetchSeekerLanguage();

      let ln = {};

      for (let i = 0; i < seekerDetail.length; i++) {
        ln[seekerDetail[i].seeker_id] = [];
      }

      seekerLanguageDetail.map((language) => {
        ln[language.seeker_id].push(language.language);
      });

      res.status(200);
      res.send({
        status: "success",
        message: "Seeker data fetch Successfully",
        data: seekerDetail.map((jb) => {
          jb[`languages`] = ln[jb.seeker_id];
          return jb;
        }),
      });
    } else {
      res.status(400);
      res.json({
        status: "failed",
        message: "Data Not Available",
      });
    }
  } catch (error) {
    res.send({
      result: result,
      message: "Server Error",
      status: "failed",
    });
  }
}

async function getSpecificCompanyDetail(req, res) {
  try {
    console.log(req.body);
    var company_id = req.body.company_id;
    if (company_id) {
      var companyDetails = await companyModel.getSpecificCompanyDetail(
        company_id
      );
      console.log(companyDetails);
      if (companyDetails.length > 0) {
        res.status(200);
        res.json({
          status: "success",
          message: "Company Details Fetched Successfully",
          data: companyDetails,
        });
      } else {
        res.status(400);
        res.json({
          status: "failed",
          message: "Company Details Not Found",
        });
      }
    } else {
      res.status(400);
      res.json({
        status: "failed",
        message: "No company id details",
      });
    }
  } catch (e) {
    console.log(e);
    res.status(400);
    res.json({
      status: "error",
      message: "Internal Server Error",
    });
  }
}

async function updateCompanyProfile(req, res) {
  try {
    console.log(req.body);
    var image_path = req.file.path;
    var company_id = req.body.company_id;
    var contact_no = req.body.contact_no;
    var company_name = req.body.company_name;
    var email_address = req.body.email;
    var company_description = req.body.company_desc;
    var district = req.body.district;
    var website = req.body.website;

    var data = await companyModel.getDistrictId(district);
    var response = await companyModel.updateCompanyProfile(
      company_id,
      company_name,
      email_address,
      contact_no,
      website,
      company_description,
      image_path,
      data[0]["district_id"]
    );
    if (response.affectedRows > 0) {
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
  } catch (e) {
    console.log(e);
    res.status(400);
    res.json({
      status: "error",
      message: "Internal Server Error",
    });
  }
}

async function deleteJob(req, res) {
  try {
    var job_id = req.body.job_id;

    if (job_id) {
      var appliedJobResponse = await companyModel.deleteAppliedJob(job_id);
      var data = await companyModel.deleteJobPostSkill(job_id);
      var response = await companyModel.deleteJob(job_id);
      if (data.affectedRows > 0 && response.affectedRows > 0) {
        res.status(200);
        res.json({
          status: "success",
          message: "Job post deleted",
        });
      } else {
        res.status(400);
        res.json({
          status: "failed",
          message: "Something went wrong.",
        });
      }
    }
  } catch (exception) {
    console.log(exception);
    res.status(400);
    res.json({
      status: "error",
      message: "Internal Server Error",
    });
  }
}

async function searchOtherCompanyPost(req, res) {
  var company_id = req.body.company_id;
  var job_position = req.body.job_position;

  try {
    var postJobDetails = await companyModel.searchOtherCompanyJobs(
      company_id,
      job_position
    );
    var postJobLanguage = await companyModel.searchOtherCompanyJobLanguages(
      company_id,
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
    console.log(exception);
    res.status(400);
    res.json({
      status: "failed",
      message: "Server Error",
    });
  }
}

async function filterData(req, res) {
  var jobPosition = req.body.job_position;
  var jobType = req.body.job_type;
  var district = req.body.district;
  var userDate = req.body.user_date;
  var company_id = req.body.company_id;

  if (jobPosition == "nothing") {
    jobPosition = "";
  }

  try {
    if (company_id) {
      if (
        jobType != "Select jobType" &&
        district != "Select district" &&
        userDate != "Select Date"
      ) {
        if (userDate == "This Month") {
          var postJobDetails = await filterModel.filterAllCompanyByMonth(
            company_id,
            jobPosition,
            jobType,
            district
          );
          var postJobLanguage =
            await filterModel.filterAllCompanyByMonthLanguages(
              company_id,
              jobPosition,
              jobType,
              district
            );

          adminController.SendJson(postJobDetails, postJobLanguage, res);
        } else {
          var postJobDetails = await filterModel.filterAllCompanyByWeekly(
            company_id,
            jobPosition,
            jobType,
            district
          );

          var postJobLanguage =
            await filterModel.filterAllCompanyLanguagesByWeekly(
              company_id,
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
          company_id
        );
        var postJobLanguage =
          await filterModel.filterLanguageByJobTypeAndDistrict(
            jobPosition,
            jobType,
            district,
            company_id
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
          company_id
        );
        var postJobLanguage = await filterModel.filterLanguageByJobType(
          jobPosition,
          jobType,
          company_id
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
          company_id
        );
        var postJobLanguage = await filterModel.filterLanguageByDistrict(
          jobPosition,
          district,
          company_id
        );

        adminController.SendJson(postJobDetails, postJobLanguage, res);
      } else if (
        userDate == "This Month" &&
        district == "Select district" &&
        jobType == "Select jobType"
      ) {
        var postJobDetails = await filterModel.filterByMonthly(
          jobPosition,
          company_id
        );
        var postJobLanguage = await filterModel.filterLanguageByMonthly(
          jobPosition,
          company_id
        );

        adminController.SendJson(postJobDetails, postJobLanguage, res);
      } else if (
        userDate == "This Week" &&
        district == "Select district" &&
        jobType == "Select jobType"
      ) {
        var postJobDetails = await filterModel.filterByWeekly(
          jobPosition,
          company_id
        );
        var postJobLanguage = await filterModel.filterLanguageByWeekly(
          jobPosition,
          company_id
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
            company_id
          );
        var postJobLanguage =
          await filterModel.filterLanguageByJobTypeAndUserDateByMonthly(
            jobPosition,
            jobType,
            company_id
          );

        adminController.SendJson(postJobDetails, postJobLanguage, res);
      } else if (
        jobType != "Select jobType" &&
        userDate == "This Week" &&
        district == "Select district"
      ) {
        var postJobDetails =
          await filterModel.filterByJobTypeAndUserDateByWeekly(
            jobPosition,
            jobType,
            company_id
          );
        var postJobLanguage =
          await filterModel.filterLanguageByJobTypeAndUserDateByWeekly(
            jobPosition,
            jobType,
            company_id
          );

        adminController.SendJson(postJobDetails, postJobLanguage, res);
      } else if (
        jobType == "Select jobType" &&
        userDate == "This Week" &&
        district != "Select district"
      ) {
        var postJobDetails = await filterModel.filterByDistrictWeekly(
          jobPosition,
          company_id,
          district
        );
        var postJobLanguage = await filterModel.filterLanguageDistrictByWeekly(
          jobPosition,
          company_id,
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
          company_id,
          district
        );
        var postJobLanguage = await filterModel.filterLanguageDistrictByMonthly(
          jobPosition,
          company_id,
          district
        );

        adminController.SendJson(postJobDetails, postJobLanguage, res);
      } else {
        res.json({
          status: "error",
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

async function searchSeeker(req, res) {
  try {
    console.log("hello");
    var userSearchText = req.body.userSearchText;
    if (userSearchText) {
      console.log(userSearchText);
      var seekerDetail = await companyModel.searchSeeker(userSearchText);
      if (seekerDetail.length > 0) {
        var seekerLanguageDetail = await companyModel.searchSeekerLanguage(
          userSearchText
        );
        console.log(seekerDetail);
        console.log(seekerLanguageDetail);

        let ln = {};

        for (let i = 0; i < seekerDetail.length; i++) {
          ln[seekerDetail[i].seeker_id] = [];
        }

        seekerLanguageDetail.map((language) => {
          ln[language.seeker_id].push(language.language);
        });

        res.status(200);
        res.send({
          status: "success",
          message: "Seeker data fetch Successfully",
          data: seekerDetail.map((jb) => {
            jb[`languages`] = ln[jb.seeker_id];
            return jb;
          }),
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
        message: "Please Provide seeker name or job title",
      });
    }
  } catch (error) {
    res.status(400);
    res.json({
      status: "failed",
      message: "Server Error",
    });
  }
}

async function getPostedJob(req, res) {
  var company_id = req.body.company_id;
  try {
    if (company_id) {
      var postJobDetails = await companyModel.getPostedJob(company_id);
      var postJobLanguage = await companyModel.getPostedJobLanguage(company_id);

      adminController.SendJson(postJobDetails, postJobLanguage, res);
    } else {
      res.status(400);
      res.json({
        status: "failed",
        message: "Please provide complete details",
      });
    }
  } catch (exception) {
    console.log(exception);
    res.status(400);
    res.json({
      status: "error",
      message: "Internal Server Error",
    });
  }
}

async function getApplicants(req, res) {
  try {
    var job_id = req.body.job_id;
    if (job_id) {
      var seekerDetail = await companyModel.getApplicants(job_id);
      var seekerLanguageDetail = await companyModel.getApplicantsLanguage(
        job_id
      );

      let ln = {};

      for (let i = 0; i < seekerDetail.length; i++) {
        ln[seekerDetail[i].seeker_id] = [];
      }

      seekerLanguageDetail.map((language) => {
        ln[language.seeker_id].push(language.language);
      });

      res.status(200);
      res.send({
        status: "success",
        message: "Seeker data fetch Successfully",
        data: seekerDetail.map((jb) => {
          jb[`languages`] = ln[jb.seeker_id];
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
  } catch (error) {
    res.status(400);
    res.json({
      status: "failed",
      message: "Internal server error",
    });
  }
}

async function verifyPayment(req, res) {
  try {
    let token = req.body.token;
    let amount = parseInt(req.body.amount);

    let data = {
      token: token,
      amount: amount,
    };
    let config = {
      headers: {
        Authorization: "Key test_secret_key_e638a756987b44ecbde0a0702cec44f9",
      },
    };
    await axios
      .post("https://khalti.com/api/v2/payment/verify/", data, config)
      .then((response) => {
        console.log(response.data);
        var state = response.data["state"];
        var isComplete = response.data["state"].template;
        var user_id = response.data["product_identity"];
        // var user_name = response.data[]

        var date = new Date();
        var current_date =
          date.getFullYear() +
          "-" +
          (date.getMonth() + 1) +
          "-" +
          date.getDate();

        var current_time =
          date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds();
        var current_datetime = current_date + " " + current_time;

        if (isComplete == "is complete") {
          var response = companyModel.updateUserMembershipId(
            user_id,
            2,
            current_datetime
          );
          response.then((result) => {
            res.status(200);
            console.log(result);
            if (result.changedRows == 1 && result.affectedRows == 1) {
              var data = companyModel.insertIntoPayment(
                user_id,
                amount,
                current_datetime
              );
              data.then((content) => {
                if (content.affectedRows == 1) {
                  res.status(200);
                  res.json({
                    status: "success",
                    message: "Payment Successful",
                  });
                }
              });
            } else {
              res.status(400);
              res.json({
                status: "failed",
                message: "Payment Not Successfull",
              });
            }
          });
        } else {
          res.status(400);
          res.json({
            status: "failed",
            message: "Payment Not successful",
          });
        }
      })
      .catch((error) => {
        console.log(error);
      });
  } catch (exception) {
    res.status(400);
    res.json({
      status: "failed",
      message: "Internal Server Error",
    });
  }
}

module.exports.getChatScreen = getChatScreen;
module.exports.getMessage = getMessage;
module.exports.sendMessage = sendMessage;
module.exports.verifyPayment = verifyPayment;
module.exports.getApplicants = getApplicants;
module.exports.getPostedJob = getPostedJob;
module.exports.searchSeeker = searchSeeker;
module.exports.getSeekerDetail = getSeekerDetail;
module.exports.searchOtherCompanyPost = searchOtherCompanyPost;
module.exports.updateCompanyProfile = updateCompanyProfile;
module.exports.getSpecificCompanyDetail = getSpecificCompanyDetail;
module.exports.getOtherCompanyJob = getOtherCompanyJob;
module.exports.fetchJob = fetchJob;
module.exports.postJob = postJob;
module.exports.filterData = filterData;
module.exports.deleteJob = deleteJob;
