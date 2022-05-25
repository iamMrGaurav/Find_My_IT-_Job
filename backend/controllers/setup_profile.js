const setupProfileModel = require("../models/setup_profile.js");
const companyModel = require("../models/comapny_side.js");

async function setupProfile(req, res) {
  let imagePath = req.file.path;

  console.log(req.body.company_name);

  const userStatus = await setupProfileModel.isCompanyUserPresent(
    req.body.user_id
  );
  if (userStatus.length > 0) {
    res.status(400);
    res.json({
      message: "User Already Exist",
      status: "failed",
    });
  } else {
    var user_membership = await setupProfileModel.insertIntoUserMembership(
      req.body.user_id
    );
    var data = await companyModel.getDistrictId(req.body.district);
    let response = await setupProfileModel.setupUser(
      req.body.company_name,
      req.body.email,
      req.body.contact_no,
      req.body.website,
      data[0]["district_id"],
      req.body.company_desc,
      imagePath,
      req.body.user_id
    );
    if (response.affectedRows > 0) {
      console.log(response);
      res.status(200);
      res.json({
        message: "User Updated",
        status: "success",
      });
    } else {
      res.status(400);
      res.json({
        message: "Profile cannot be setup",
        status: "failed",
      });
    }
  }
}

module.exports.setupProfile = setupProfile;
