import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fmij/components/constants.dart';
import 'package:fmij/controller/company_controller.dart';
import 'package:fmij/controller/login_controller.dart';
import 'package:fmij/utilities/global.dart';
import 'package:fmij/views/login_screen.dart';
import 'package:fmij/views/pages/company_postJob.dart';
import 'package:fmij/views/setup_profile.dart';
import 'package:get/get.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:badges/badges.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final CompanyController getController = CompanyController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: FutureBuilder(
          future: getController.fetchCompanyProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Obx(
                () => ListView(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: IconButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            icon: const Icon(Icons.arrow_back),
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                    colors: [kPurple, klightpurple],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 100,
                          left: 35,
                          child: GestureDetector(
                            onTap: () {
                              if (getController
                                      .companyProfile[0].membershipName ==
                                  "premium") {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.SUCCES,
                                  headerAnimationLoop: false,
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'You are a premium company',
                                  desc: 'Your job will be highlighted first',
                                  buttonsTextStyle:
                                      const TextStyle(color: Colors.black),
                                  showCloseIcon: true,
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {},
                                ).show();
                              } else {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.INFO,
                                  headerAnimationLoop: false,
                                  animType: AnimType.BOTTOMSLIDE,
                                  title: 'Upgrade to a premium company',
                                  desc: 'Your job will be highlighted first',
                                  buttonsTextStyle:
                                      const TextStyle(color: Colors.black),
                                  showCloseIcon: true,
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    final config = PaymentConfig(
                                      amount: 10000,
                                      productIdentity:
                                          '${getController.companyProfile[0].userId}',
                                      productName: 'membership',
                                    );

                                    KhaltiScope.of(context).pay(
                                      config: config,
                                      onSuccess: (s) {
                                        getController.verifyPayment(s);
                                      },
                                      onFailure: (f) {},
                                      onCancel: () {},
                                    );
                                  },
                                ).show();
                              }
                            },
                            child: CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.white38,
                              child: Badge(
                                // showBadge: false,
                                showBadge: getController
                                            .companyProfile[0].membershipName ==
                                        "premium"
                                    ? true
                                    : false,
                                badgeColor: klightpurple,
                                badgeContent: const Icon(
                                  IconlyLight.shieldDone,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                position: BadgePosition.topEnd(
                                  top: 80,
                                  end: 9,
                                ),
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                animationType: BadgeAnimationType.slide,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "$api/${getController.companyProfile[0].imagePath}"),
                                  backgroundColor: Colors.grey.shade200,
                                  radius: 50,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 59,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          getController.companyProfile[0].companyName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        Text(
                          "@ ${getController.companyProfile[0].userName}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              IconlyLight.call,
                              color: Colors.grey,
                              size: 17,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(getController.companyProfile[0].contactNo
                                .toString())
                          ],
                        ),
                        const SizedBox(
                          width: 9,
                        ),
                        Row(
                          children: [
                            const Icon(IconlyLight.location,
                                color: Colors.grey, size: 17),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              getController.companyProfile[0].districtName,
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 9,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(width: 40),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        child: Text(
                            getController.companyProfile[0].companyDescription
                                .toString(),
                            style: const TextStyle(
                                overflow: TextOverflow.fade,
                                color: Colors.grey),
                            textAlign: TextAlign.start),
                      ),
                    ),
                    const SizedBox(height: 17),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        const Icon(IconlyLight.message,
                            color: klightpurple, size: 17),
                        const SizedBox(width: 5),
                        Text(
                          getController.companyProfile[0].emailAddress,
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const SizedBox(width: 20),
                        const Icon(IconlyLight.paper,
                            color: klightpurple, size: 17),
                        const SizedBox(width: 5),
                        Text(getController.companyProfile[0].website)
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 36,
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: ElevatedButton(
                            child: const Text(
                              "Edit",
                              style: TextStyle(
                                fontSize: 18,
                                color: klightpurple,
                                letterSpacing: 1.1,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffF0EEFA),
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide(
                                    color: Color(0xffF0EEFA),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Get.to(FirstSignUp(
                                text: "company/update",
                              ));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: ElevatedButton(
                            child: const Text(
                              "Log Out",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  letterSpacing: 1.1),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.deepPurple),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                  side: const BorderSide(
                                      color: Colors.deepPurple, width: 2),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.clear();

                              LoginController.authenticateToken = "";
                              Get.to(LoginScreen());
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 40),
                        SizedBox(
                          height: 36,
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: ElevatedButton(
                            child: const Text(
                              "View Post",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: klightpurple,
                                  letterSpacing: 1.1),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xffF0EEFA)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide(
                                      color: Color(0xffF0EEFA), width: 2),
                                ),
                              ),
                            ),
                            onPressed: () {
                              Get.to(CompanyPostJob());
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 90,
                    ),
                    getController.companyProfile[0].membershipName == "premium"
                        ? const SizedBox()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 46,
                                width: MediaQuery.of(context).size.width * 0.49,
                                child: ElevatedButton(
                                  child: const Text(
                                    "Be a member",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.deepPurple,
                                        letterSpacing: 1.1),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color(0xffF0EEFA)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        side: const BorderSide(
                                            color: Color(0xffF0EEFA), width: 1),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            backgroundColor: kPurple,
                                            title: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.45,
                                              width: 100,
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Image.asset(
                                                          "assets/images/men.png",
                                                          height: 200,
                                                          width: 170),
                                                    ],
                                                  ),
                                                  const Text(
                                                    "Your job will be highlighted first !!",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  const SizedBox(height: 30),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Get.back();
                                                        },
                                                        child: const Text(
                                                          "No",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          final config =
                                                              PaymentConfig(
                                                            amount: 10000,
                                                            productIdentity:
                                                                '${getController.companyProfile[0].userId}',
                                                            productName:
                                                                'membership',
                                                          );

                                                          KhaltiScope.of(
                                                                  context)
                                                              .pay(
                                                            config: config,
                                                            onSuccess:
                                                                (data) async {
                                                              PaymentSuccessModel
                                                                  model = data;
                                                              try {
                                                                var url =
                                                                    "$api/company/verifyPayment/?token=${LoginController.authenticateToken}";
                                                                var data =
                                                                    await http
                                                                        .post(
                                                                  Uri.parse(
                                                                      url),
                                                                  body: {
                                                                    "idx": model
                                                                        .idx
                                                                        .toString(),
                                                                    "user_id": model
                                                                        .productIdentity
                                                                        .toString(),
                                                                    "amount": model
                                                                        .amount
                                                                        .toString(),
                                                                    "token": model
                                                                        .token
                                                                        .toString()
                                                                  },
                                                                );
                                                                var result =
                                                                    jsonDecode(
                                                                        data.body);
                                                                if (data.statusCode ==
                                                                    200) {
                                                                  Get.to(
                                                                      ProfilePage());
                                                                  AwesomeDialog(
                                                                    context:
                                                                        context,
                                                                    dialogType:
                                                                        DialogType
                                                                            .SUCCES,
                                                                    headerAnimationLoop:
                                                                        false,
                                                                    animType:
                                                                        AnimType
                                                                            .BOTTOMSLIDE,
                                                                    title:
                                                                        'You are a premium company',
                                                                    desc:
                                                                        'Your job will be highlighted first',
                                                                    buttonsTextStyle:
                                                                        const TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                    showCloseIcon:
                                                                        true,
                                                                    btnCancelOnPress:
                                                                        () {},
                                                                    btnOkOnPress:
                                                                        () {},
                                                                  ).show();
                                                                  getController
                                                                      .fetchCompanyProfile();
                                                                } else {
                                                                  AwesomeDialog(
                                                                    context:
                                                                        context,
                                                                    dialogType:
                                                                        DialogType
                                                                            .ERROR,
                                                                    headerAnimationLoop:
                                                                        false,
                                                                    animType:
                                                                        AnimType
                                                                            .BOTTOMSLIDE,
                                                                    title:
                                                                        'Payment Not Succesfull',
                                                                    desc:
                                                                        'Please try again',
                                                                    buttonsTextStyle:
                                                                        const TextStyle(
                                                                            color:
                                                                                Colors.black),
                                                                    showCloseIcon:
                                                                        true,
                                                                    btnCancelOnPress:
                                                                        () {},
                                                                    btnOkOnPress:
                                                                        () {},
                                                                  ).show();
                                                                }
                                                              } catch (exception) {
                                                                Fluttertoast.showToast(
                                                                    msg:
                                                                        "${exception}",
                                                                    toastLength:
                                                                        Toast
                                                                            .LENGTH_LONG,
                                                                    gravity: ToastGravity
                                                                        .BOTTOM,
                                                                    timeInSecForIosWeb:
                                                                        1,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .red,
                                                                    textColor:
                                                                        Colors
                                                                            .white,
                                                                    fontSize:
                                                                        16.0);
                                                              }
                                                              // }
                                                            },
                                                            onFailure: (f) {},
                                                            onCancel: () {},
                                                          );
                                                        },
                                                        child: const Text(
                                                          "Proceed",
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ));
                                      },
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                  ],
                ),
              );
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                color: klightpurple,
              ));
            }
          }),
    );
  }
}
