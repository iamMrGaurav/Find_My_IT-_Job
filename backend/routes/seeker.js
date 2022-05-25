const { Router } = require("express");
const express = require("express");
const router = express.Router();
const seekerController = require("../controllers/seeker.js");
const multer = require("multer");
const authenticate = require("../authenticate.js");

var storage = multer.diskStorage({
  destination: function (req, file, cb) {
    console.log(file);
    cb(null, "./cv");
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + file.originalname);
  },
});
const upload = multer({ storage: storage });

router.post(
  "/create_profile",
  upload.any("document"),
  seekerController.createProfile
);

router.post(
  "/fetch_seekerProfileDetail",
  authenticate.authentication,
  seekerController.fetchSeekerProfileDetail
);

router.post(
  "/fetch_jobPost",
  authenticate.authentication,
  seekerController.getOtherCompanyJob
);

router.post(
  "/fetch_searchJobPost",
  authenticate.authentication,
  seekerController.searchOtherCompanyPost
);

router.post(
  "/filter_postJob",
  authenticate.authentication,
  seekerController.filterData
);

router.post(
  "/getBookmarkJob",
  authenticate.authentication,
  seekerController.getBookmarkJob
);
router.post(
  "/getAppliedJobs",
  authenticate.authentication,
  seekerController.getAppliedJob
);
router.post(
  "/getPreferJob",
  authenticate.authentication,
  seekerController.getUserPreferJob
);

router.post(
  "/update_profile",
  upload.any("document"),
  seekerController.updateSeekerProfile
);

router.post(
  "/update_profile/image",
  upload.single("photo"),
  seekerController.updateProfileImage
);

router.post(
  "/update_profile/cv",
  upload.single("cv"),
  seekerController.updateProfileCV
);

router.post(
  "/applyJob",
  authenticate.authentication,
  seekerController.applyJob
);
router.post(
  "/addBookmark",
  authenticate.authentication,
  seekerController.addBookmark
);
router.post(
  "/delete_bookmark",
  authenticate.authentication,
  seekerController.deleteBookmark
);
module.exports = router;
