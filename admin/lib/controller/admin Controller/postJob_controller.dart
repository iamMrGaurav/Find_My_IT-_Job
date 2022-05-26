import 'dart:convert';
import 'package:age_calculator/age_calculator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fyp_admin/components/constants.dart';
import 'package:fyp_admin/model/districts.dart';
import 'package:fyp_admin/model/post_job.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PostJobController extends GetxController {
  var postJob = <PostJob>[].obs;
  var searchPostJob = <PostJob>[].obs;
  var filterPostJob = <PostJob>[].obs;
  var listOfDistricts = <District>[].obs;

  TextEditingController searchPostJobText = TextEditingController();

  // var initialIndex = 10.obs;
  var currentIndex = 0.obs;
  bool isPastWeekCheck = false;
  bool isThisMonthCheck = false;

  var dropdownvalue = 'Select district';
  var items = [
    'Select district',
  ];
  var jobTypeValue = 'Select jobType';
  var expiredValue = 'Choose expired';
  var expiredValues = ['Choose expired', 'expired', 'not expired'];
  var dateValue = 'Select Date';
  var dateValues = ['Select Date', 'This Month', 'This Week'];

  var jobTypes = [
    'Select jobType',
    'Full Time',
    'Part Time',
    'Internship',
    'Remote'
  ];

  checkLength() {
    if (filterPostJob.isEmpty) {
      if (searchPostJob.isEmpty) {
        return postJob.length;
      } else {
        return searchPostJob.length;
      }
    } else {
      return filterPostJob.length;
    }
  }

  fetchPostJob() async {
    try {
      var url = "http://localhost:4000/admin_home/fetch_post_job";
      var data = await http.get(Uri.parse(url));
      var result = jsonDecode(data.body);

      postJob.value = postJobFromJson(jsonEncode(result["postJob"]));
      fetchDistrict();
      return postJob;
    } catch (exception) {
      print(exception);
    }
  }

  fetchDistrict() async {
    var url =
        "https://iamkrishnaa.github.io/nepal_province_to_municipality/districts.json";

    var data = await http.get(Uri.parse(url));
    listOfDistricts.value = districtFromJson(data.body);
    if (items.length < 2) {
      for (District d in listOfDistricts) {
        items.add(d.name);
      }
    }
    listOfDistricts.refresh();
    update();
  }

  getDuration(date) {
    var dateTime = DateTime.parse(date.toString());

    final day = DateTime(dateTime.year, dateTime.month, dateTime.day);

    DateDuration duration;

    duration = AgeCalculator.age(day);
    if (duration.months > 0) {
      return ("${duration.days.toString()} months ago");
    } else {
      return ("${duration.days.toString()} days ago");
    }
  }

  getSearchPostJob() async {
    try {
      var url = "http://localhost:4000/admin_home/get_search_job";
      var data = await http.post(
        Uri.parse(url),
        body: {
          "job_position": searchPostJobText.text,
        },
      );
      var result = jsonDecode(data.body);
      searchPostJob.value = postJobFromJson(jsonEncode(result["postJob"]));
    } catch (e) {
      print(e);
    }
  }

  getFilterSearchData(district, jobType, date) async {
    try {
      var url = "http://localhost:4000/admin_home/filter_data";
      var data = await http.post(
        Uri.parse(url),
        body: {
          "job_position": searchPostJobText.text,
          "district": district,
          "job_type": jobType,
          "user_date": date,
          "is_expired": expiredValue
        },
      );
      var result = jsonDecode(data.body);
      filterPostJob.value = postJobFromJson(jsonEncode(result["postJob"]));
      if (filterPostJob.length == 0) {
        Fluttertoast.showToast(
            msg: "No data found",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      print(e);
    }
  }
}
