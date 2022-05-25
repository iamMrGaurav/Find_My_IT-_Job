import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fmij/components/constants.dart';
import 'package:fmij/controller/login_controller.dart';
import 'package:fmij/utilities/global.dart';
import 'package:fmij/views/Company_Home.dart';
import 'package:fmij/views/login_screen.dart';
import 'package:fmij/views/seeker/seeker_home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    KhaltiScope(
        publicKey: "test_public_key_3c4166e0582141a2a496a1fbe2ae1797",
        builder: (context, navigatorKey) {
          return GetMaterialApp(
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            home: const MainScreen(),
            debugShowCheckedModeBanner: false,
          );
        }),
  );
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  static String companyId = "";
  static String seekerId = "";

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    authencticate();
  }

  authencticate() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token").toString();
      if (token == "null") {
        Get.offAll(LoginScreen());
      } else {
        var url = "$api/login/authenticate/?token=$token";
        var response = await http.get(Uri.parse(url));
        if (response != null) {
          var jsonData = jsonDecode(response.body);

          if (jsonData["data"]["role"] == 1) {
            MainScreen.companyId = jsonData["data"]["company_id"].toString();

            LoginController.authenticateToken = token;
            Get.to(CompanyPage());
          } else {
            MainScreen.seekerId = jsonData["data"]["seeker_id"].toString();

            LoginController.authenticateToken = token;
            Get.to(SeekerHome());
          }
        }
      }
    } catch (exception) {
      print(exception);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPurple,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/Untitled.png",
            width: 200,
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            "Find My IT Job",
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Center(
            child: SizedBox(
              width: 150,
              child: LinearProgressIndicator(
                color: kPurple,
                backgroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
