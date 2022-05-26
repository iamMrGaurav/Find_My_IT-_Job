import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fmij/components/constants.dart';
import 'package:fmij/controller/login_controller.dart';
import 'package:fmij/main.dart';
import 'package:fmij/model/company_profile.dart';
import 'package:fmij/model/districts.dart';
import 'package:fmij/model/job_position.dart';
import 'package:fmij/model/post_job.dart';
import 'package:fmij/model/seeker.dart';
import 'package:fmij/utilities/global.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:khalti_flutter/khalti_flutter.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyController extends GetxController {
  var jobPostPosition = <JobPosition>[].obs;
  var otherCompanyJob = <PostJob>[].obs;
  var postedJobs = <PostJob>[].obs;
  var companyProfile = <CompanyProfile>[].obs;
  var index = 10.obs;
  TextEditingController searchJob = TextEditingController();
  var searchPostJob = <PostJob>[].obs;
  var filterPostJob = <PostJob>[].obs;
  var seekerDerail = <SeekerProfile>[].obs;
  var searchSeeker = <SeekerProfile>[].obs;
  var applicants = <SeekerProfile>[].obs;

  TextEditingController searchSeekerText = TextEditingController();

  TextEditingController companyName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController website = TextEditingController();
  TextEditingController contactNo = TextEditingController();
  TextEditingController companyDescription = TextEditingController();

  populateData() {
    companyName.text = companyProfile[0].companyName;
    email.text = companyProfile[0].emailAddress;
    website.text = companyProfile[0].website;
    contactNo.text = companyProfile[0].contactNo;
    companyDescription.text = companyProfile[0].companyDescription;
    String imagePath = companyProfile[0].imagePath;
  }

  deleteJob(jobId) async {
    try {
      var url =
          "$api/company/deleteJob/?token=${LoginController.authenticateToken}";
      var response = await http.post(
        Uri.parse(url),
        body: {"job_id": jobId.toString()},
      );
      var result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: result["message"],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        getPostedJob(MainScreen.companyId);
      } else {
        Fluttertoast.showToast(
            msg: result["message"],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (exception) {
      Fluttertoast.showToast(
          msg: exception.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  verifyPayment(data) async {
    PaymentSuccessModel model = data;
    try {
      var url =
          "$api/company/verifyPayment/?token=${LoginController.authenticateToken}";
      var data = await http.post(
        Uri.parse(url),
        body: {
          "idx": model.idx.toString(),
          "user_id": model.productIdentity.toString(),
          "amount": model.amount.toString(),
          "token": model.token.toString()
        },
      );
      var result = jsonDecode(data.body);
      if (data.statusCode == 200) {
        Fluttertoast.showToast(
            msg: result["message"],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(
            msg: result["message"],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (exception) {
      Fluttertoast.showToast(
          msg: " ${exception}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  searchSeekerData() async {
    try {
      var url =
          "$api/company/search_seeker/?token=${LoginController.authenticateToken}";
      var data = await http.post(
        Uri.parse(url),
        body: {"userSearchText": searchSeekerText.text},
      );
      var result = jsonDecode(data.body);

      searchSeeker.value = seekerProfileFromJson(jsonEncode(result["data"]));
      return searchSeeker;
    } catch (e) {
      print(e);
    }
  }

  getSearchPostJob() async {
    try {
      var url =
          "$api/company/search_otherJobs/?token=${LoginController.authenticateToken}";
      var data = await http.post(
        Uri.parse(url),
        body: {
          "job_position": searchJob.text.isEmpty ? "nothing" : searchJob.text,
          "company_id": "2"
        },
      );
      var result = jsonDecode(data.body);
      searchPostJob.value = postJobFromJson(jsonEncode(result["postJob"]));

      return searchPostJob;
    } catch (e) {
      print(e);
    }
  }

  checkLength() {
    if (filterPostJob.isEmpty) {
      if (searchPostJob.isEmpty) {
        return otherCompanyJob.length;
      } else {
        return searchPostJob.length;
      }
    } else {
      return filterPostJob.length;
    }
  }

  getFilterSearchData(searchPostJobValue, district, jobType, date) async {
    try {
      var url =
          "$api/company/search_otherJobs/filter/?token=${LoginController.authenticateToken}";

      var data = await http.post(Uri.parse(url), body: {
        "company_id": MainScreen.companyId,
        "job_type": jobType,
        "job_position": searchPostJobValue,
        "district": district,
        "user_date": date
      });
      var result = jsonDecode(data.body);
      filterPostJob.value = postJobFromJson(jsonEncode(result["postJob"]));
    } catch (e) {
      print(e);
    }
  }

  String? dropdownValue = 'Select job';
  var items = ['Select job'];
  DateTime? expiryDate;
  bool isChecked = false;

  var jobType = [
    'Select jobType',
    'Full Time',
    'Part Time',
    'Internship',
    'Remote'
  ];

  var jobTypeValue = 'Select jobType';
  var dateValue = 'Select Date';
  var dateValues = ['Select Date', 'This Month', 'This Week'];

  TextEditingController jobTitle = TextEditingController();
  TextEditingController minimumEducation = TextEditingController();
  TextEditingController minimumExperience = TextEditingController();
  TextEditingController salary = TextEditingController();
  TextEditingController jobDescription = TextEditingController();
  TextEditingController jobSpecification = TextEditingController();
  TextEditingController languages = TextEditingController();
  String? token;
  late SharedPreferences prefs;

  var listOfDistricts = <District>[].obs;
  var dropdownvalueD = 'Select district';
  var itemsD = [
    'Select district',
  ];

  fetchDistrict() async {
    try {
      var url =
          "https://iamkrishnaa.github.io/nepal_province_to_municipality/districts.json";

      var data = await http.get(Uri.parse(url));
      listOfDistricts.value = districtFromJson(data.body);
      if (itemsD.length < 2) {
        for (District d in listOfDistricts) {
          itemsD.add(d.name);
        }
      }
      listOfDistricts.refresh();
      update();
    } catch (exception) {
      print(exception);
    }
  }

  fetchSeekerDetails() async {
    try {
      var url =
          "$api/company/get_seekerDetails/?token=${LoginController.authenticateToken}";
      var data = await http.get(Uri.parse(url));
      var result = jsonDecode(data.body);
      seekerDerail.value = seekerProfileFromJson(jsonEncode(result["data"]));
      return seekerDerail;
    } catch (e) {
      print(e);
    }
  }

  fetchOtherCompany() async {
    try {
      var url =
          "$api/company/get_otherJob/?token=${LoginController.authenticateToken}";
      var response = await http.post(
        Uri.parse(url),
        body: {"company_id": MainScreen.companyId},
      );
      var result = jsonDecode(response.body);
      otherCompanyJob.value = postJobFromJson(jsonEncode(result["data"]));

      return otherCompanyJob;
    } catch (exception) {
      print(exception);
    }
  }

  fetchCompanyJobPosition() async {
    var url = "$api/admin_home/job_position";
    var data = await http.get(Uri.parse(url));
    var result = jsonDecode(data.body);
    jobPostPosition.value = jobPositionFromJson(jsonEncode(result["data"]));
    if (items.length < 2) {
      for (JobPosition value in jobPostPosition) {
        items.add(value.jobPositionName);
      }
    }
    fetchDistrict();
    return jobPostPosition;
  }

  fetchCompanyProfile() async {
    try {
      var url =
          "$api/company/get_profileData/?token=${LoginController.authenticateToken}";
      print(MainScreen.companyId);
      var response = await http.post(
        Uri.parse(url),
        body: {"company_id": MainScreen.companyId},
      );

      var result = jsonDecode(response.body);
      companyProfile.value = companyProfileFromJson(jsonEncode(result["data"]));
      return companyProfile;
    } catch (e) {
      print(e);
    }
  }

  postJob() async {
    try {
      if (minimumEducation.text.isEmpty ||
          minimumExperience.text.isEmpty ||
          salary.text.isEmpty ||
          jobDescription.text.isEmpty ||
          jobSpecification.text.isEmpty ||
          expiryDate == null) {
        Fluttertoast.showToast(
            msg: "Please fill all the fields",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else if (jobTypeValue == 'Select JobType') {
        Fluttertoast.showToast(
            msg: "Please select job type",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        var url =
            "$api/company/add_job/?token=${LoginController.authenticateToken}";
        var response = await http.post(Uri.parse(url), body: {
          "job_description": jobSpecification.text,
          "posted_date": DateTime.now().toString(),
          "company_id": MainScreen.companyId,
          "job_type": jobTypeValue,
          "salary": salary.text,
          "expired_date": expiryDate.toString().substring(0, 10),
          "experience": minimumExperience.text,
          "minimum_education": minimumEducation.text,
          "is_negotiable": isChecked.toString(),
          "job_title": jobTitle.text,
          "job_specification": jobSpecification.text,
          "languages": languages.text,
          "job_position": dropdownValue.toString()
        });

        var data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: data["message"],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: data["message"],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  String calculatePostedDate(String postedDate) {
    var postedDateInDays = DateTime.parse(postedDate);
    var currentDate = DateTime.now();
    var difference = currentDate.difference(postedDateInDays);
    var days = difference.inDays;
    var months = difference.inDays / 30;

    var daysInt = days.toInt();
    var monthsInt = months.toInt();
    if (daysInt < 30) {
      return "$daysInt days ago";
    } else {
      return "$monthsInt months ago";
    }
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.black;
    }
    return klightpurple;
  }

  getPostedJob(companyId) async {
    try {
      var url =
          "$api/company/get_postedJob/?token=${LoginController.authenticateToken}";
      var response = await http
          .post(Uri.parse(url), body: {"company_id": MainScreen.companyId});
      var result = jsonDecode(response.body);
      postedJobs.value = postJobFromJson(jsonEncode(result["postJob"]));
      return postedJobs;
    } catch (exception) {
      print(exception);
    }
  }

  getApplicants(jobId) async {
    try {
      var url =
          "$api/company/get_applicants/?token=${LoginController.authenticateToken}";
      var response = await http.post(
        Uri.parse(url),
        body: {"job_id": jobId.toString()},
      );
      var result = jsonDecode(response.body);
      applicants.value = seekerProfileFromJson(jsonEncode(result["data"]));

      return applicants;
    } catch (exception) {
      print(exception);
    }
  }
}
