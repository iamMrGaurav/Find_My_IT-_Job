import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fmij/main.dart';
import 'package:fmij/utilities/global.dart';
import 'package:fmij/views/Company_Home.dart';
import 'package:fmij/views/choose_role.dart';
import 'package:fmij/views/forgotpass_screen.dart';
import 'package:fmij/views/otp_screen.dart';
import 'package:fmij/views/seeker/seeker_home.dart';
import 'package:fmij/views/seeker/update_seekerProfile.dart';
import 'package:fmij/views/setup_profile.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  static String token = "";
  static String email_address = "";
  static String google_email = "";
  static String userID = "";

  static String authenticateToken = "";

  bool isEye = true;

  verify(email, password) async {
    var url = "$api/verify";
    var response = await http.post(Uri.parse(url), body: {
      "email_address": email,
      "password": password,
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      login();
    } else {
      Fluttertoast.showToast(
          msg: data["message"],
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  forgotPass() async {
    var url = "$api/forgot_pass/passwordreset";
    var response = await http.post(Uri.parse(url), body: {
      "email_address": email.text,
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
      Get.to(OtpScreen());
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

  login() async {
    var url = "$api/login";
    var response = await http.post(Uri.parse(url), body: {
      "email_address": email.text,
      "password": password.text,
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (data["message"] == "company") {
        email.clear();
        password.clear();
        Get.to(FirstSignUp(
          text: "stats/insert",
        ));
      } else if (data["message"] == "seeker") {
        LoginController.userID = data["user_id"].toString();
        Get.to(UpdateProfile(
          isUpdate: "no",
        ));
      } else {
        if (data["company_id"] == null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("token", data["token"]);
          prefs.setString("uName", data["user_name"]);

          authenticateToken = prefs.getString("token").toString();
          MainScreen.seekerId = data["seeker_id"].toString();
          Get.to(SeekerHome());
          Fluttertoast.showToast(
              msg: data["message"],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          email.clear();
          password.clear();
        } else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("token", data["token"]);
          prefs.setString("uName", data["user_name"]);

          print("Below is company user id");
          print(data["user_id"]);

          authenticateToken = prefs.getString("token").toString();
          MainScreen.companyId = data["company_id"].toString();
          Fluttertoast.showToast(
              msg: data["message"],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Get.offAll(CompanyPage());
        }
      }
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

  var googleToken;
  GoogleSignIn googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;

  googleLogin() async {
    googleSignInAccount = await googleSignIn.signIn();
  }

  googleSign() async {
    await googleLogin();
    var url = "$api/googlelogin/validate";
    var response = await http.post(Uri.parse(url), body: {
      "email": googleSignInAccount!.email,
      "UId": googleSignInAccount!.id,
      "displayName": googleSignInAccount!.displayName
    });

    var data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200) {
      if (data["role"] == null) {
        LoginController.google_email = googleSignInAccount!.email;
        Get.off(const RoleScreen());
        return;
      }
      if (data["message"] == "company") {
        LoginController.userID = data["user_id"].toString();
        email.clear();
        password.clear();
        Get.to(FirstSignUp(
          text: "stats/insert",
        ));
      } else if (data["message"] == "seeker") {
        LoginController.userID = data["user_id"].toString();
        Get.to(UpdateProfile(
          isUpdate: "no",
        ));
      } else {
        if (data["company_id"] == null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("token", data["token"]);
          authenticateToken = prefs.getString("token").toString();
          MainScreen.seekerId = data["seeker_id"].toString();
          Get.to(SeekerHome());
          Fluttertoast.showToast(
              msg: data["message"],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          email.clear();
          password.clear();
        } else {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("token", data["token"]);
          authenticateToken = prefs.getString("token").toString();
          MainScreen.companyId = data["company_id"].toString();
          Fluttertoast.showToast(
              msg: data["message"],
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Get.offAll(CompanyPage());
        }
      }
      Fluttertoast.showToast(
          msg: data["message"],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      googleToken = data["token"];
      LoginController.google_email = googleSignInAccount!.email;
      Fluttertoast.showToast(
          msg: data["message"],
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Get.to(const RoleScreen());
    }
  }

  String otp = "";
  var data;

  verifyOtp(token, otp) async {
    token = LoginController.token;
    var url = "$api/forgot_pass/passwordreset/verifyotp";
    var response = await http.post(Uri.parse(url), body: {
      "token": token,
      "otp": otp,
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
      Get.to(ForgotPass());
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

  TextEditingController forgotPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  changePassword() async {
    var url = "$api/forgot_pass/passwordreset/changepassword";
    var response = await http.post(Uri.parse(url), body: {
      "email_address": email.text,
      "newpassword": confirmPassword.text,
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
}
