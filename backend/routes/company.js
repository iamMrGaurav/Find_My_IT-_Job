const { Router } = require("express");
const express = require("express");
const router = express.Router();
const companyController = require("../controllers/company_side.js");
const { route } = require("./login.js");
const multer = require("multer");
const authenticate = require("../authenticate.js");

var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, "./images");
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + file.originalname);
  },
});
const upload = multer({ storage: storage });

router.post("/add_job", authenticate.authentication, companyController.postJob);

router.post("/", authenticate.authentication, companyController.fetchJob);

router.post(
  "/get_otherJob",
  authenticate.authentication,
  companyController.getOtherCompanyJob
);

router.post(
  "/get_profileData",
  authenticate.authentication,
  companyController.getSpecificCompanyDetail
);

router.post(
  "/update",
  authenticate.authentication,
  upload.single("file_field"),
  companyController.updateCompanyProfile
);

router.post(
  "/search_otherJobs",
  authenticate.authentication,
  companyController.searchOtherCompanyPost
);
router.post(
  "/search_otherJobs/filter",
  authenticate.authentication,
  companyController.filterData
);
router.get(
  "/get_seekerDetails",
  authenticate.authentication,
  companyController.getSeekerDetail
);
router.post(
  "/search_seeker",
  authenticate.authentication,
  companyController.searchSeeker
);
router.post(
  "/get_postedJob",
  authenticate.authentication,
  companyController.getPostedJob
);
router.post(
  "/get_applicants",
  authenticate.authentication,
  companyController.getApplicants
);
router.post(
  "/verifyPayment",
  authenticate.authentication,
  companyController.verifyPayment
);
router.post(
  "/deleteJob",
  authenticate.authentication,
  companyController.deleteJob
);
router.post(
  "/sendMessage",
  authenticate.authentication,
  companyController.sendMessage
);
router.post(
  "/getMessage",
  authenticate.authentication,
  companyController.getMessage
);
// router.post("/getInbox", companyController.getChatScreen);
module.exports = router;
