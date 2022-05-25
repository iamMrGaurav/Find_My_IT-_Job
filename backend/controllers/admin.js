const express = require("express");
const res = require("express/lib/response");
const adminModel = require("../models/admin.js");
const adminModelFilter = require("../models/admin_filter.js");

async function getTotalCompanies(req, res) {
  try {
    var totalCompanies = await adminModel.getTotalCompanies();
    var totalJobs = await adminModel.getTotalJobs();
    var totalJobSeeker = await adminModel.getTotalJobSeeker();
    var fullTimeJobs = await adminModel.getTotalFullTimeJobs();
    var partTimeJobs = await adminModel.getTotalPartTimeJobs();
    var internJobs = await adminModel.getTotalInternJobs();
    var remoteJobs = await adminModel.getTotalRemoteJobs();

    res.status(200);
    res.json({
      status: "success",
      data: totalCompanies[0].total_companies,
      jobs: totalJobs[0].total_jobs,
      fullTime: fullTimeJobs[0].total_full_time,
      partTime: partTimeJobs[0].total_part_time,
      internJobs: internJobs[0].total_internship,
      remoteJobs: remoteJobs[0].total_remote,
      jobSeeker: totalJobSeeker[0].total_seekers,
    });
  } catch (exception) {
    console.log(exception);
    res.status(400);
    res.json({
      message: "Something Went Wrong!",
      status: "failed",
    });
  }
}

async function getCompaniesDetails(req, res) {
  try {
    var companiesData = await adminModel.getCompaniesDetails();
    if (companiesData) {
      res.status(200);
      res.json({
        status: "sucess",
        data: companiesData,
        message: "Data Fetched",
      });
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
      message: "Something Went Wrong!",
      status: "failed",
    });
  }
}

async function searchCompaniesDetail(req, res) {
  try {
    var searchCompany = await adminModel.searchCompanies(req.body.search);
    if (searchCompany) {
      res.status(200);
      res.json({
        status: "success",
        message: "Data Fetched",
        data: searchCompany,
      });
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
      message: "Server Error",
    });
  }
}

async function getJobPosition(req, res) {
  try {
    var jobPosition = await adminModel.getJobPosition();
    if (jobPosition) {
      res.status(200);
      res.json({
        status: "sucess",
        data: jobPosition,
        message: "Data Fetched",
      });
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
      message: "Server Error",
    });
  }
}

async function addJobPosition(req, res) {
  let jobPosition = req.body.jobPosition;

  if (jobPosition) {
    try {
      var response = await adminModel.addJobPosition(jobPosition);
      console.log(response);
      if ((response.affectedRows = 1)) {
        res.status(200);
        res.send({
          message: `${jobPosition} is added successfully.`,
          status: "success",
        });
      } else {
        res.status(400);
        res.json({
          message: "Data cannot be inserted.",
          status: "failed",
        });
      }
    } catch (exception) {
      res.status(400);
      res.send({
        message: "Data Entry Failed.",
        status: "failed",
      });
    }
  } else {
    res.status(400);
    res.send({
      message: "Please provide job position.",
      status: "failed",
    });
  }
}

async function limitJobPosition(req, res) {
  let index = req.body.index;
  var response = await adminModel.limitJobPosition(index);
  res.json({
    status: "success",
    message: "Limited data fethced",
    data: response,
  });
}

async function getPostJob(req, res) {
  try {
    var postJobDetails = await adminModel.getPostJobDetails();
    var postJobLanguage = await adminModel.getPostJobLanguages();

    let ln = {};

    for (let i = 0; i < postJobDetails.length; i++) {
      ln[postJobDetails[i].job_id] = [];
    }

    postJobLanguage.map((language) => {
      ln[language.job_id].push(language.language);
    });

    // postJobDetails.map((jb) => {
    //   jb[jb.job_id] = ln[jb.job_id];
    //   console.log(ln[jb.job_id]);
    // });
    if (postJobDetails) {
      if (postJobLanguage) {
        res.status(200);
        res.send({
          status: "success",
          message: "Data fetched successfully",
          postJob: postJobDetails.map((jb) => {
            jb[`languages`] = ln[jb.job_id];
            return jb;
          }),
        });
      } else {
        res.status(400);
        res.send({
          status: "failed",
          message: "Data Not Available",
        });
      }
    } else {
      res.status(400);
      res.send({
        status: "failed",
        message: "Data Not Available",
      });
    }
  } catch (exception) {
    res.status(400);
    res.send({
      status: "failed",
      message: "Server Error",
    });
  }
}

async function getSearchJob(req, res) {
  let index = req.body.index;
  let job_position = req.body.job_position;
  try {
    var postJobDetails = await adminModel.getSearchJob(job_position, index);
    var postJobLanguage = await adminModel.getSearchJobLanguages(job_position);

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
  // var jobPosition = req.body.job_position;
  // var jobType = req.body.job_type;
  // var district = req.body.district;
  // var userDate;

  // if ((userDate = "This Month")) {
  //   userDate = "past month";
  // } else {
  //   userDate = "past week";
  // }

  // if (
  //   jobPosition &&
  //   jobType != "Select Job Type" &&
  //   district != "Select district" &&
  //   userDate
  // ) {
  //   try {
  //     if ((userDate = "past week")) {
  //       var postJobDetails = await adminModelFilter.filterAllByWeekly(
  //         jobPosition,
  //         jobType,
  //         district
  //       );
  //       var postJobLanguage = await adminModelFilter.filterLanguageAllByWeekly(
  //         jobPosition,
  //         jobType,
  //         district
  //       );

  //       SendJson(postJobDetails, postJobLanguage, res);
  //     } else {
  //       var postJobDetails = await adminModelFilter.filterAllByMonthly(
  //         jobPosition,
  //         jobType,
  //         district
  //       );
  //       var postJobLanguage = await adminModelFilter.filterLanguageAllByMonthly(
  //         jobPosition,
  //         jobType,
  //         district
  //       );

  //       SendJson(postJobDetails, postJobLanguage, res);
  //     }
  //   } catch (exception) {
  //     res.status(400);
  //     res.json({
  //       status: "failed",
  //       message: "Server Error",
  //     });
  //   }
  // } else if (
  //   jobPosition &&
  //   jobType != "Select Job Type" &&
  //   district != "Select district"
  // ) {
  //   try {
  //     var postJobDetails = await adminModelFilter.filterByJobTypeAndDistrict(
  //       jobPosition,
  //       jobType,
  //       district
  //     );
  //     var postJobLanguage =
  //       await adminModelFilter.filterLanguageByJobTypeAndDistrict(
  //         jobPosition,
  //         jobType,
  //         district
  //       );

  //     SendJson(postJobDetails, postJobLanguage, res);
  //   } catch (exception) {
  //     console.log(exception);
  //     res.status(400);
  //     res.json({
  //       status: "failed",
  //       message: "Server Error",
  //     });
  //   }
  // } else if (jobPosition && jobType != "Select Job Type") {
  //   try {
  //     var postJobDetails = await adminModelFilter.filterByJobType(
  //       jobPosition,
  //       jobType
  //     );
  //     var postJobLanguage = await adminModelFilter.filterLanguageByJobType(
  //       jobPosition,
  //       jobType
  //     );

  //     SendJson(postJobDetails, postJobLanguage, res);
  //   } catch (exception) {
  //     console.log(exception);
  //     res.status(400);
  //     res.json({
  //       status: "failed",
  //       message: "Server Error",
  //     });
  //   }
  // } else if (jobPosition && district != "Select district") {
  //   try {
  //     var postJobDetails = await adminModelFilter.filterByDistrict(
  //       jobPosition,
  //       district
  //     );
  //     var postJobLanguage = await adminModelFilter.filterLanguageByDistrict(
  //       jobPosition,
  //       district
  //     );

  //     SendJson(postJobDetails, postJobLanguage, res);
  //   } catch (exception) {
  //     console.log(exception);
  //     res.status(400);
  //     res.json({
  //       status: "failed",
  //       message: "Server Error",
  //     });
  //   }
  // } else if (jobPosition && userDate) {
  //   try {
  //     if ((userDate = "past week")) {
  //       var postJobDetails = await adminModelFilter.filterByWeeklyDate(
  //         jobPosition
  //       );
  //       var postJobLanguage = await adminModelFilter.filterLanguageByWeeklyDate(
  //         jobPosition
  //       );

  //       SendJson(postJobDetails, postJobLanguage, res);
  //     } else {
  //       var postJobDetails = await adminModelFilter.filterByMonthly(
  //         jobPosition
  //       );
  //       var postJobLanguage = await adminModelFilter.filterLanguageByMonthly(
  //         jobPosition
  //       );

  //       SendJson(postJobDetails, postJobLanguage, res);
  //     }
  //   } catch (exception) {
  //     console.log(exception);
  //     res.status(400);
  //     res.json({
  //       status: "failed",
  //       message: "Server Error",
  //     });
  //   }
  // } else if (jobPosition && jobType != "Select Job Type" && userDate) {
  //   try {
  //     if ((userDate = "past week")) {
  //       var postJobDetails =
  //         await adminModelFilter.filterByJobTypeAndUserDateByWeekly(
  //           jobPosition,
  //           jobType
  //         );
  //       var postJobLanguage =
  //         await adminModelFilter.filterLanguageByJobTypeAndUserDateByWeekly(
  //           jobPosition,
  //           jobType
  //         );

  //       SendJson(postJobDetails, postJobLanguage, res);
  //     } else {
  //       var postJobDetails =
  //         await adminModelFilter.filterByJobTypeAndUserDateByMonthly(
  //           jobPosition,
  //           jobType
  //         );
  //       var postJobLanguage =
  //         await adminModelFilter.filterLanguageByJobTypeAndUserDateByMonthly(
  //           jobPosition,
  //           jobType,
  //           userDate
  //         );

  //       SendJson(postJobDetails, postJobLanguage, res);
  //     }
  //   } catch (exception) {
  //     console.log(exception);
  //     res.status(400);
  //     res.json({
  //       status: "failed",
  //       message: "Server Error",
  //     });
  //   }
  // }

  var jobPosition = req.body.job_position;

  if (jobPosition == "nothing") {
    jobPosition = "";
  }

  var jobType = req.body.job_type;
  var district = req.body.district;
  var userDate = req.body.user_date;
  var expiredStatus = req.body.is_expired;
  console.log(expiredStatus);
  if (expiredStatus == "Choose expired") {
    expiredStatus = "";
  } else if (expiredStatus == "expired") {
    expiredStatus = "AND Date(expired_date) < Date(NOW())";
  } else {
    expiredStatus = "AND Date(expired_date) > Date(NOW())";
  }
  console.log(expiredStatus);
  try {
    if (
      jobType != "Select jobType" &&
      district != "Select district" &&
      userDate != "Select Date"
    ) {
      if (userDate == "This Month") {
        var postJobDetails = await adminModelFilter.filterAllByMonthly(
          jobPosition,
          jobType,
          district,
          expiredStatus
        );
        var postJobLanguage = await adminModelFilter.filterLanguageAllByMonthly(
          jobPosition,
          jobType,
          district,
          expiredStatus
        );

        SendJson(postJobDetails, postJobLanguage, res);
      } else {
        var postJobDetails = await adminModelFilter.filterAllByWeekly(
          jobPosition,
          jobType,
          district,
          expiredStatus
        );

        var postJobLanguage = await adminModelFilter.filterLanguageAllByWeekly(
          jobPosition,
          jobType,
          district,
          expiredStatus
        );

        SendJson(postJobDetails, postJobLanguage, res);
      }
    } else if (jobType != "Select jobType" && district != "Select district") {
      var postJobDetails = await adminModelFilter.filterByJobTypeAndDistrict(
        jobPosition,
        jobType,
        district,
        expiredStatus
      );
      var postJobLanguage =
        await adminModelFilter.filterLanguageByJobTypeAndDistrict(
          jobPosition,
          jobType,
          district,
          expiredStatus
        );
      SendJson(postJobDetails, postJobLanguage, res);
    } else if (
      jobType != "Select jobType" &&
      userDate == "Select Date" &&
      district == "Select district"
    ) {
      var postJobDetails = await adminModelFilter.filterByJobType(
        jobPosition,
        jobType,
        expiredStatus
      );
      var postJobLanguage = await adminModelFilter.filterLanguageByJobType(
        jobPosition,
        jobType,
        expiredStatus
      );

      SendJson(postJobDetails, postJobLanguage, res);
    } else if (
      district != "Select district" &&
      jobType == "Select jobType" &&
      userDate == "Select Date"
    ) {
      var postJobDetails = await adminModelFilter.filterByDistrict(
        jobPosition,
        district,
        expiredStatus
      );
      var postJobLanguage = await adminModelFilter.filterLanguageByDistrict(
        jobPosition,
        district,
        expiredStatus
      );

      SendJson(postJobDetails, postJobLanguage, res);
    } else if (
      userDate == "This Month" &&
      district == "Select district" &&
      jobType == "Select jobType"
    ) {
      var postJobDetails = await adminModelFilter.filterByMonthly(
        jobPosition,
        expiredStatus
      );
      var postJobLanguage = await adminModelFilter.filterLanguageByMonthly(
        jobPosition,
        expiredStatus
      );

      SendJson(postJobDetails, postJobLanguage, res);
    } else if (
      userDate == "This Week" &&
      district == "Select district" &&
      jobType == "Select jobType"
    ) {
      console.log("This Week");

      var postJobDetails = await adminModelFilter.filterByWeekly(
        jobPosition,
        expiredStatus
      );
      var postJobLanguage = await adminModelFilter.filterLanguageByWeekly(
        jobPosition,
        expiredStatus
      );

      SendJson(postJobDetails, postJobLanguage, res);
    } else if (
      jobType != "Select jobType" &&
      userDate == "This Month" &&
      district == "Select district"
    ) {
      var postJobDetails =
        await adminModelFilter.filterByJobTypeAndUserDateByMonthly(
          jobPosition,
          jobType,
          expiredStatus
        );
      var postJobLanguage =
        await adminModelFilter.filterLanguageByJobTypeAndUserDateByMonthly(
          jobPosition,
          jobType,
          expiredStatus
        );

      SendJson(postJobDetails, postJobLanguage, res);
    } else if (
      jobType != "Select jobType" &&
      userDate == "This Week" &&
      district == "Select district"
    ) {
      var postJobDetails =
        await adminModelFilter.filterByJobTypeAndUserDateByWeekly(
          jobPosition,
          jobType,
          expiredStatus
        );
      var postJobLanguage =
        await adminModelFilter.filterLanguageByJobTypeAndUserDateByWeekly(
          jobPosition,
          jobType,
          expiredStatus
        );

      SendJson(postJobDetails, postJobLanguage, res);
    } else if (
      jobType == "Select jobType" &&
      userDate == "This Week" &&
      district != "Select district"
    ) {
      var postJobDetails = await adminModelFilter.filterByDistrictWeekly(
        jobPosition,
        district,
        expiredStatus
      );
      var postJobLanguage =
        await adminModelFilter.filterLanguageDistrictByWeekly(
          jobPosition,
          district,
          expiredStatus
        );

      SendJson(postJobDetails, postJobLanguage, res);
    } else if (
      jobType == "Select jobType" &&
      userDate == "This Month" &&
      district != "Select district"
    ) {
      var postJobDetails = await adminModelFilter.filterByDistrictMonthly(
        jobPosition,
        district,
        expiredStatus
      );
      var postJobLanguage =
        await adminModelFilter.filterLanguageDistrictByMonthly(
          jobPosition,
          district,
          expiredStatus
        );

      SendJson(postJobDetails, postJobLanguage, res);
    } else if (
      jobType == "Select jobType" &&
      district == "Select district" &&
      userDate == "Select Date" &&
      expiredStatus != "Choose expired"
    ) {
      var postJobDetails = await adminModelFilter.filterByChoosenJobStatus(
        jobPosition,
        expiredStatus
      );
      var postJobLanguage =
        await adminModelFilter.filterLanguageByChoosenJobStatus(
          jobPosition,
          expiredStatus
        );

      SendJson(postJobDetails, postJobLanguage, res);
    } else {
      res.json({
        status: "error",
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

function SendJson(postJobDetails, postJobLanguage, res) {
  let ln = {};

  for (let i = 0; i < postJobDetails.length; i++) {
    ln[postJobDetails[i].job_id] = [];
  }

  postJobLanguage.map((language) => {
    ln[language.job_id].push(language.language);
  });

  if (postJobDetails) {
    if (postJobLanguage) {
      res.status(200);
      res.json({
        status: "success",
        message: "Data fetched successfully",
        postJob: postJobDetails.map((jb) => {
          jb[`languages`] = ln[jb.job_id];
          return jb;
        }),
      });
      console.log(
        postJobDetails.map((jb) => {
          jb[`languages`] = ln[jb.job_id];
          return jb;
        })
      );
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
}

async function updateJobPosition(req, res) {
  try {
    console.log(req.body);
    var job_position_id = req.body.job_position_id;
    var job_position_name = req.body.job_position_name;

    if (job_position_id && job_position_name) {
      var response = await adminModel.updateJobPosition(
        job_position_id,
        job_position_name
      );
      console.log(response);
      if (response.affectedRows > 0) {
        res.status(200);
        res.json({
          status: "success",
          message: "Job Position Updated Successfully",
        });
      }
    } else {
      res.status(400);
      res.json({
        status: "failed",
        message: "Please fill all the fields",
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

async function deleteJobPosition(req, res) {
  try {
    console.log("hello");
    var job_position_id = req.body.job_position_id;
    console.log(job_position_id);
    if (job_position_id) {
      var response = await adminModel.deleteJobPosition(job_position_id);
      if (response.affectedRows > 0) {
        res.status(200);
        res.json({
          status: "success",
          message: "Job Position Deleted Successfully",
        });
      }
    } else {
      res.status(400);
      res.json({
        status: "failed",
        message: "Please fill all the fields",
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

async function getTransactionDetail(req, res) {
  try {
    var response = await adminModel.getTransactionDetail();
    console.log(response);
    if (response) {
      res.status(200);
      res.send({
        status: "success",
        message: "Transaction detail fetch Successfully",
        data: response,
      });
    }
  } catch (error) {
    res.status(400);
    res.send({
      status: "failed",
      message: "Internal server error",
    });
  }
}

async function searchTransactionDetail(req, res) {
  try {
    let companyName = req.body.company_name;
    console.log(companyName);

    if (companyName) {
      var response = await adminModel.searchTransactionDetail(companyName);
      console.log(response);
      if (response.length > 0) {
        res.status(200);
        res.json({
          status: "success",
          message: "data fecthed successfully",
          data: response,
        });
      } else {
        res.status(400);
        res.json({
          status: "failed",
          message: "Data Not Found",
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

module.exports.searchTransactionDetail = searchTransactionDetail;
module.exports.getTransactionDetail = getTransactionDetail;
module.exports.updateJobPosition = updateJobPosition;
module.exports.deleteJobPosition = deleteJobPosition;
module.exports.SendJson = SendJson;
module.exports.filterData = filterData;
module.exports.getSearchJob = getSearchJob;
module.exports.limitJobPosition = limitJobPosition;
module.exports.addJobPosition = addJobPosition;
module.exports.getJobPosition = getJobPosition;
module.exports.getCompaniesDetails = getCompaniesDetails;
module.exports.getTotalCompanies = getTotalCompanies;
module.exports.getPostJob = getPostJob;
module.exports.searchCompaniesDetail = searchCompaniesDetail;
