import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_admin/model/company.dart';
import 'package:fyp_admin/model/jobPosition.dart';
import 'package:fyp_admin/model/seeker.dart';
import 'package:fyp_admin/model/transaction.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Admin_Controller extends GetxController {
  var companies = <CompanyDetails>[].obs;
  var searchText = <CompanyDetails>[].obs;
  var JobPostPosition = <JobPosition>[].obs;
  var searchJobPosition = <JobPosition>[].obs;
  TextEditingController jobPosition = TextEditingController();
  var seekerDerail = <SeekerProfile>[].obs;
  var searchSeeker = <SeekerProfile>[].obs;
  var transaction = <Transaction>[].obs;
  var searchTransaction = <Transaction>[].obs;

  TextEditingController editJobPosition = TextEditingController();
  TextEditingController searchedCompany = TextEditingController();
  TextEditingController searchTransactionValue = TextEditingController();
  TextEditingController searchSeekerText = TextEditingController();

  var initialIndex = 10.obs;

  searchCompanies() async {
    try {
      var url = "http://localhost:4000/admin_home/search_companies";
      var response = await http
          .post(Uri.parse(url), body: {"search": searchedCompany.text});
      var data = jsonDecode(response.body);
      searchText.value = companyDetailsFromJson(jsonEncode(data["data"]));
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
    } catch (exception) {}
  }

  fetchCompaniesData() async {
    var url = "http://localhost:4000/admin_home/companies_details";
    var data = await http.get(Uri.parse(url));
    var result = jsonDecode(data.body);
    companies.value = companyDetailsFromJson(jsonEncode(result["data"]));
    return companies;
  }

  fetchCompanyJobPosition() async {
    try {
      var url = "http://localhost:4000/admin_home/job_position";
      var data = await http.get(Uri.parse(url));
      var result = jsonDecode(data.body);
      JobPostPosition.value = jobPositionFromJson(jsonEncode(result["data"]));

      return JobPostPosition;
    } catch (exception) {
      print(exception);
    }
  }

  fetchLimitJobPosition(index) async {
    var url = "http://localhost:4000/admin_home/job_position";
    var data = await http.post(Uri.parse(url), body: {
      "index": index,
    });
    var result = jsonDecode(data.body);
    JobPostPosition.value = jobPositionFromJson(jsonEncode(result["data"]));
    return JobPostPosition;
  }

  addJobPostPosition(JobPosition) async {
    var url = "http://localhost:4000/admin_home/job_position/add";
    var response = await http.post(
      Uri.parse(url),
      body: {
        "jobPosition": JobPosition,
      },
    );

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

  searchSelectedJobPosition(String userSearchText) {
    searchJobPosition.value = JobPostPosition.where((text) => text
        .jobPositionName
        .toLowerCase()
        .startsWith(userSearchText.toLowerCase())).toList();
    return searchJobPosition;
  }

  addJobPosition(jobPostPosition) async {
    var url = "http://localhost:4000/admin_home/job_position/";
    var response = await http.post(Uri.parse(url), body: {
      "jobPosition": jobPostPosition,
    });

    var data = jsonDecode(response.body);
    print(data);
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

  searchSeekerData() async {
    try {
      var url = "http://localhost:4000/admin_home/search_seeker";
      var data = await http.post(
        Uri.parse(url),
        body: {"userSearchText": searchSeekerText.text},
      );
      var result = jsonDecode(data.body);
      print(result);
      searchSeeker.value = seekerProfileFromJson(jsonEncode(result["data"]));
      return searchSeeker;
    } catch (e) {
      print(e);
    }
  }

  fetchSeekerDetails() async {
    try {
      var url = "http://localhost:4000/admin_home/get_seekerDetails";
      var data = await http.get(Uri.parse(url));
      var result = jsonDecode(data.body);
      seekerDerail.value = seekerProfileFromJson(jsonEncode(result["data"]));
      return seekerDerail;
    } catch (e) {
      print(e);
    }
  }

  updateJobPosition(jobPositionID, jobPositionName) async {
    try {
      var url = "http://localhost:4000/admin_home/update_job_position";
      var response = await http.post(Uri.parse(url), body: {
        "job_position_id": jobPositionID.toString(),
        "job_position_name": jobPositionName.toString()
      });
      var data = jsonDecode(response.body);
      print(data);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: data["message"],
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Get.back();
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
    } catch (exception) {
      print(exception);
    }
  }

  deleteJobPosition(jobPositionID) async {
    try {
      var url = "http://localhost:4000/admin_home/delete_job_position/";

      var response = await http.post(Uri.parse(url),
          body: {"job_position_id": jobPositionID.toString()});

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

        JobPostPosition.removeAt(jobPositionID);

        Get.back();
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
    } catch (exception) {
      print(exception);
    }
  }

  fetchTransaction() async {
    try {
      var url = "http://localhost:4000/admin_home/get_transaction";
      var data = await http.get(Uri.parse(url));
      var result = jsonDecode(data.body);

      transaction.value = transactionFromJson(jsonEncode(result["data"]));
      return transaction;
    } catch (exception) {
      print(exception);
    }
  }

  searchTransactionDetail() async {
    try {
      if (searchTransactionValue.text.isEmpty) {
        Fluttertoast.showToast(
            msg: "Empty field detected",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        var url = "http://localhost:4000/admin_home/search_transaction";
        var response = await http.post(Uri.parse(url),
            body: {"company_name": searchTransactionValue.text});
        var data = jsonDecode(response.body);
        print(data);
        searchTransaction.value = transactionFromJson(jsonEncode(data["data"]));
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
    } catch (exception) {
      print(exception);
    }
  }
}
