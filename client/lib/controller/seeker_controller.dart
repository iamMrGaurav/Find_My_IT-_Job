import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fmij/controller/login_controller.dart';
import 'package:fmij/main.dart';
import 'package:fmij/model/districts.dart';
import 'package:fmij/model/post_job.dart';
import 'package:fmij/utilities/global.dart';
import 'package:fmij/views/login_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import '../model/job_position.dart';
import '../model/seeker.dart';

class SeekerController extends GetxController {
  TextEditingController bio = TextEditingController();
  TextEditingController contactNo = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController workExperience = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController jobPosition = TextEditingController();
  TextEditingController preferLanguages = TextEditingController();
  TextEditingController highestQualification = TextEditingController();
  DateTime? dob;

  TextEditingController searchTextField = TextEditingController();

  populateData() {
    bio.text = seekerProfileDetail[0].bio;
    contactNo.text = seekerProfileDetail[0].contactNo;
    email.text = seekerProfileDetail[0].emailAddress;
    workExperience.text = seekerProfileDetail[0].workExperience.toString();
    firstName.text = seekerProfileDetail[0].firstName;
    lastName.text = seekerProfileDetail[0].lastName;
    jobPosition.text = seekerProfileDetail[0].jobPosition;
    highestQualification.text = seekerProfileDetail[0].highestQualification;
    dob = seekerProfileDetail[0].dob;
    preferLanguages.text = seekerProfileDetail[0]
        .languages
        .toString()
        .replaceAll("[", "")
        .replaceAll("]", "");
  }

  var seekerProfileDetail = <SeekerProfile>[].obs;

  final picker = ImagePicker();
  File? image;
  File? cv;

  String? dropdownvalue = 'Select district';

  var items = [
    'Select district',
  ];
  var listOfDistricts = <District>[];

  fetchDistrict() async {
    var url =
        "https://iamkrishnaa.github.io/nepal_province_to_municipality/districts.json";

    var data = await http.get(Uri.parse(url));
    listOfDistricts = districtFromJson(data.body);
    if (items.length < 2) {
      for (District d in listOfDistricts) {
        items.add(d.name);
      }
    }
    var b = await fetchCompanyJobPosition();
    try {
      populateData();
    } catch (exception) {}
    return listOfDistricts;
  }

  String? dropdownValueJob = 'Select job';
  var itemsJob = ['Select job'].obs;
  var jobPostPosition = <JobPosition>[].obs;

  fetchCompanyJobPosition() async {
    var url = "$api/admin_home/job_position";
    var data = await http.get(Uri.parse(url));
    var result = jsonDecode(data.body);
    jobPostPosition.value = jobPositionFromJson(jsonEncode(result["data"]));

    if (itemsJob.length < 2) {
      for (JobPosition value in jobPostPosition) {
        itemsJob.add(value.jobPositionName);
      }
    }

    return jobPostPosition;
  }

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    } else {
      Fluttertoast.showToast(
        msg: "No File Selected",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> getCv() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      cv = File(result.files.single.path ?? "");
    } else {
      Fluttertoast.showToast(
        msg: "Error",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  upload(File imageFile, File cv, district, isUpdate) async {
    var uri;
    if (isUpdate == "yes") {
      uri = Uri.parse(
          "$api/seeker/${"update_profile/?token=${LoginController.authenticateToken}"}");
    } else {
      uri = Uri.parse("$api/seeker/create_profile");
    }

    var request = http.MultipartRequest("POST", uri);
    request.files
        .add(await http.MultipartFile.fromPath("photo", imageFile.path));

    request.files.add(await http.MultipartFile.fromPath("cv", cv.path));

    request.fields['first_name'] = firstName.text;
    request.fields['last_name'] = lastName.text;
    request.fields['email_address'] = email.text;
    request.fields['dob'] = "${dob!.year}-${dob!.month}-${dob!.day}";
    request.fields['highest_qualification'] = highestQualification.text;

    if (isUpdate == "yes") {
      request.fields['seeker_id'] = MainScreen.seekerId;
    } else {
      request.fields['user_id'] = LoginController.userID;
    }

    request.fields['work_experience'] = workExperience.text;
    request.fields['district_name'] = district;
    request.fields['bio'] = bio.text;
    request.fields['contact_no'] = contactNo.text;
    request.fields['job_position'] = dropdownValueJob.toString();
    request.fields['languages'] = preferLanguages.text;
    request.fields['ownJobPosition'] = jobPosition.text;
    var response = await request.send();
    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Profile Setup Completely",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      if (isUpdate == "yes") {
        Get.back();
      } else {
        Get.to(LoginScreen());
      }
    } else {
      Fluttertoast.showToast(
          msg: "Something Went Wrong",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    response.stream.transform(utf8.decoder).listen((value) {});
  }

  updateProfileImage(File imageFile) async {
    var uri = Uri.parse(
        "$api/seeker/${"update_profile/image/?token=${LoginController.authenticateToken}"}");
    var request = http.MultipartRequest("POST", uri);
    request.files
        .add(await http.MultipartFile.fromPath("photo", imageFile.path));
    request.fields['seeker_id'] = MainScreen.seekerId;
    var response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Image Uploaded Successfully",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Something Went Wrong",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  updateProfileCV(File cv) async {
    var uri = Uri.parse(
        "$api/seeker/${"update_profile/cv/?token=${LoginController.authenticateToken}"}");
    var request = http.MultipartRequest("POST", uri);

    request.files.add(await http.MultipartFile.fromPath("cv", cv.path));
    request.fields['seeker_id'] = MainScreen.seekerId;
    var response = await request.send();

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "CV uploaded",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Something Went Wrong",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  updateProfileFields(district) async {
    try {
      var url =
          "$api/seeker/${"update_profile/?token=${LoginController.authenticateToken}"}";
      var data = await http.post(
        Uri.parse(url),
        body: {
          "seeker_id": MainScreen.seekerId,
          "first_name": firstName.text,
          "last_name": lastName.text,
          "email_address": email.text,
          "dob": "${dob!.year}-${dob!.month}-${dob!.day}",
          "highest_qualification": highestQualification.text,
          "work_experience": workExperience.text,
          "district_name": district,
          "bio": bio.text,
          "contact_no": contactNo.text,
          "job_position": dropdownValueJob.toString(),
          "languages": preferLanguages.text,
          "ownJobPosition": jobPosition.text
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
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (exception) {
      Fluttertoast.showToast(
          msg: exception.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  fetchSeekerProfile() async {
    try {
      var url =
          "$api/seeker/fetch_seekerProfileDetail/?token=${LoginController.authenticateToken}";
      var data = await http.post(
        Uri.parse(url),
        body: {
          "seeker_id": MainScreen.seekerId,
        },
      );

      var result = jsonDecode(data.body);
      seekerProfileDetail.value =
          seekerProfileFromJson(jsonEncode(result["data"]));

      return seekerProfileDetail;
    } catch (e) {
      print(e);
    }
  }

  var searchPostJob = <PostJob>[].obs;
  var filterPostJob = <PostJob>[].obs;
  var otherCompanyJob = <PostJob>[].obs;
  var userPreferJobs = <PostJob>[].obs;
  var bookmarkJobs = <PostJob>[].obs;
  var appliedJobs = <PostJob>[].obs;

  fetchOtherCompany() async {
    try {
      var url =
          "$api/seeker/fetch_jobPost/?token=${LoginController.authenticateToken}";
      var data = await http.post(
        Uri.parse(url),
        body: {"seeker_id": MainScreen.seekerId},
      );

      var result = jsonDecode(data.body);

      otherCompanyJob.value = postJobFromJson(jsonEncode(result["data"]));
      return otherCompanyJob;
    } catch (exception) {
      print(exception);
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

  getSearchPostJob() async {
    try {
      var url =
          "$api/seeker/fetch_searchJobPost/?token=${LoginController.authenticateToken}";
      var data = await http.post(
        Uri.parse(url),
        body: {
          "job_position":
              searchTextField.text.isEmpty ? "nothing" : searchTextField.text,
          "seeker_id": MainScreen.seekerId
        },
      );
      var result = jsonDecode(data.body);
      searchPostJob.value = postJobFromJson(jsonEncode(result["postJob"]));
      return searchPostJob;
    } catch (e) {
      print(e);
    } finally {
      filterPostJob.refresh();
      update();
    }
  }

  getFilterSearchData(searchPostJobValue, district, jobType, date) async {
    try {
      var url =
          "$api/seeker/filter_postJob/?token=${LoginController.authenticateToken}";
      var data = await http.post(Uri.parse(url), body: {
        "job_type": jobType,
        "job_position": searchPostJobValue,
        "district": district,
        "user_date": date,
        "seeker_id": MainScreen.seekerId
      });

      var result = jsonDecode(data.body);

      filterPostJob.value = postJobFromJson(jsonEncode(result["postJob"]));

      return filterPostJob;
    } catch (e) {
      print(e);
    } finally {
      filterPostJob.refresh();
      update();
    }
  }

  applyJob(jobId) async {
    try {
      var url =
          "$api/seeker/applyJob/?token=${LoginController.authenticateToken}";

      var response = await http.post(Uri.parse(url), body: {
        "job_id": jobId.toString(),
        "seeker_id": MainScreen.seekerId,
      });

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
      } else {
        Fluttertoast.showToast(
            msg: result["message"],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (exception) {
      Fluttertoast.showToast(
          msg: exception.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  bookmarkJob(jobId) async {
    try {
      var url =
          "$api/seeker/addBookmark/?token=${LoginController.authenticateToken}";

      var response = await http.post(Uri.parse(url), body: {
        "job_id": jobId.toString(),
        "seeker_id": MainScreen.seekerId,
      });
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
      } else {
        Fluttertoast.showToast(
            msg: result["message"],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
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

  getUserPreferJobs(jobPosition) async {
    try {
      var url =
          "$api/seeker/getPreferJob/?token=${LoginController.authenticateToken}";
      var data = await http.post(
        Uri.parse(url),
        body: {"job_position": jobPosition, "seeker_id": MainScreen.seekerId},
      );
      print(jobPosition);
      print(url);
      print(data.body);
      var result = jsonDecode(data.body);
      userPreferJobs.value = postJobFromJson(jsonEncode(result["postJob"]));
      print(userPreferJobs);
      return userPreferJobs;
    } catch (e) {
      print(e);
    }
  }

  getBookmarkJobs() async {
    try {
      var url =
          "$api/seeker/getBookmarkJob/?token=${LoginController.authenticateToken}";
      var data = await http.post(
        Uri.parse(url),
        body: {"seeker_id": MainScreen.seekerId},
      );

      var result = jsonDecode(data.body);
      bookmarkJobs.value = postJobFromJson(jsonEncode(result["postJob"]));

      return bookmarkJobs;
    } catch (e) {
      print(e);
    }
  }

  getAppliedJobs() async {
    try {
      var url =
          "$api/seeker/getAppliedJobs/?token=${LoginController.authenticateToken}";
      var data = await http.post(
        Uri.parse(url),
        body: {"seeker_id": MainScreen.seekerId},
      );
      var result = jsonDecode(data.body);

      appliedJobs.value = postJobFromJson(jsonEncode(result["postJob"]));
      return appliedJobs;
    } catch (e) {
      print(e);
    }
  }

  addBookmark(jobId) async {
    try {
      var url =
          "$api/seeker/addBookmark/?token=${LoginController.authenticateToken}";

      var response = await http.post(Uri.parse(url), body: {
        "job_id": jobId.toString(),
        "seeker_id": MainScreen.seekerId,
      });

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
      } else {
        Fluttertoast.showToast(
            msg: result["message"],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (exception) {
      Fluttertoast.showToast(
          msg: exception.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  removeBookmark(jobId) async {
    try {
      var url =
          "$api/seeker/delete_bookmark/?token=${LoginController.authenticateToken}";

      var response = await http.post(Uri.parse(url), body: {
        "job_id": jobId.toString(),
        "seeker_id": MainScreen.seekerId,
      });

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
      } else {
        Fluttertoast.showToast(
            msg: result["message"],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (exception) {
      Fluttertoast.showToast(
          msg: exception.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
