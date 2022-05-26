import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fmij/utilities/global.dart';
import 'package:fmij/views/login_screen.dart';
import 'package:fmij/views/pages/bottomSheet.dart';
import 'package:fmij/components/constants.dart';
import 'package:fmij/controller/company_controller.dart';
import 'package:fmij/views/seeker/job_detail.dart';
import 'package:fmij/views/other_Post.dart';
import 'package:fmij/views/pages/seeker_profile_page.dart';
import 'package:fmij/views/pages/profile_page.dart';
import 'package:fmij/views/seeker_list.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/company_postJob.dart';

class CompanyPage extends StatelessWidget {
  CompanyPage({Key? key}) : super(key: key);

  final CompanyController getController = CompanyController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: FutureBuilder(
          future: getController.fetchCompanyProfile(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.grey.shade200,
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  elevation: 5,
                  title: Text(
                    getController.companyProfile[0].companyName,
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.1),
                  ),
                  backgroundColor: Colors.deepPurple,
                  actions: [
                    Builder(builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: CircleAvatar(
                            // radius: 25,
                            backgroundImage: NetworkImage(
                              "$api/${getController.companyProfile[0].imagePath}",
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                drawer: Drawer(
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(ProfilePage());
                        },
                        child: UserAccountsDrawerHeader(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [kPurple, klightpurple],
                              ),
                            ),
                            currentAccountPicture: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: NetworkImage(
                                  "$api/${getController.companyProfile[0].imagePath}"),
                            ),
                            accountName: Text(
                                getController.companyProfile[0].companyName),
                            accountEmail: Text(
                                getController.companyProfile[0].emailAddress)),
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xffF0EEFA),
                          child: Icon(IconlyLight.home, color: kPurple),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: const Text("Home"),
                      ),
                      Divider(color: Colors.grey.shade300, thickness: 1),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xffF0EEFA),
                          child: Icon(IconlyLight.work, color: kPurple),
                        ),
                        onTap: () {
                          Get.to(CompanyPostJob());
                        },
                        title: const Text("Your Posted Jobs"),
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                      ),
                      ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xffF0EEFA),
                          child: Icon(
                            IconlyLight.search,
                            color: kPurple,
                          ),
                        ),
                        onTap: () {
                          Get.to(SeekerList());
                        },
                        title: const Text("Search Seekers"),
                      ),
                      Divider(
                        color: Colors.grey.shade300,
                        thickness: 1,
                      ),
                      ListTile(
                        onTap: () async {
                          Get.deleteAll();
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.getString("token").toString();
                          prefs.clear();

                          Get.to(LoginScreen());
                        },
                        leading: const Icon(
                          IconlyLight.logout,
                          color: klightpurple,
                        ),
                        title: const Text(
                          "Logout",
                          style: TextStyle(
                            color: kPurple,
                            fontSize: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hire the",
                                      style: GoogleFonts.roboto(
                                          fontSize: 30,
                                          color: Colors.grey.shade400),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "best seekers",
                                          style: GoogleFonts.roboto(
                                            fontSize: 30,
                                            color: kPurple,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Image.asset(
                                  "assets/images/men.png",
                                  width: 100,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Other company Jobs",
                              style: GoogleFonts.roboto(fontSize: 22),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(OtherCompaniesPost());
                              },
                              child: Text(
                                "View All",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: klightpurple,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.24,
                        child: FutureBuilder(
                            future: getController.fetchOtherCompany(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        getController.otherCompanyJob.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(JobDetailPage(
                                              profile: getController
                                                  .otherCompanyJob[index],
                                              isCompany: "yes",
                                            ));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.bottomLeft,
                                                end: Alignment.topRight,
                                                colors: [
                                                  index % 2 == 0
                                                      ? kPurple
                                                      : Colors.white,
                                                  index % 2 == 0
                                                      ? klightpurple
                                                      : Colors.white
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.23,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "${getController.calculatePostedDate(getController.otherCompanyJob[index].postedDate.toString())}    ",
                                                      style: TextStyle(
                                                        color: index % 2 == 0
                                                            ? Colors.white54
                                                            : kPurple,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ListTile(
                                                        leading: CircleAvatar(
                                                          radius: 35,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  "$api/${getController.otherCompanyJob[index].imagePath}"),
                                                        ),
                                                        title: Text(
                                                          getController
                                                                      .otherCompanyJob[
                                                                          index]
                                                                      .jobPositionName
                                                                      .toString()
                                                                      .toLowerCase() ==
                                                                  "select job"
                                                              ? getController
                                                                  .otherCompanyJob[
                                                                      index]
                                                                  .toString()
                                                                  .capitalizeFirst
                                                                  .toString()
                                                              : getController
                                                                  .otherCompanyJob[
                                                                      index]
                                                                  .jobPositionName
                                                                  .toString()
                                                                  .capitalizeFirst
                                                                  .toString(),
                                                          style: GoogleFonts
                                                              .roboto(
                                                            fontSize: 24,
                                                            color: index % 2 ==
                                                                    0
                                                                ? Colors.white
                                                                : kPurple,
                                                          ),
                                                        ),
                                                        subtitle: Text(
                                                          getController
                                                              .otherCompanyJob[
                                                                  index]
                                                              .jobType
                                                              .capitalizeFirst
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .roboto(
                                                            fontSize: 20,
                                                            color: index % 2 ==
                                                                    0
                                                                ? Colors.white38
                                                                : kPurple,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 19,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                      width: 9,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.01),
                                                      decoration: BoxDecoration(
                                                        color: index % 2 == 0
                                                            ? Colors.white24
                                                            : Colors.deepPurple,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.work,
                                                              size: 17,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            Text(
                                                              " ${getController.otherCompanyJob[index].companyName}",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                color: Colors
                                                                    .white70,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: index % 2 == 0
                                                            ? Colors.white24
                                                            : Colors.deepPurple,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.location_on,
                                                              size: 17,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            Text(
                                                              " ${getController.otherCompanyJob[index].districtName}",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                color: Colors
                                                                    .white70,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: index % 2 == 0
                                                            ? Colors.white24
                                                            : Colors.deepPurple,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .calendar_today,
                                                              size: 17,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            Text(
                                                              "  ${getController.otherCompanyJob[index].experience} yrs ",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                color: Colors
                                                                    .white70,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  color: klightpurple,
                                ));
                              }
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Seekers",
                              style: GoogleFonts.roboto(fontSize: 22),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.to(SeekerList());
                              },
                              child: Text(
                                "View All",
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    color: klightpurple,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.24,
                        child: FutureBuilder(
                            future: getController.fetchSeekerDetails(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        getController.seekerDerail.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Get.to(SeekerProfilePage(
                                              isAppliedSeeker: "no",
                                              profileController: getController
                                                  .seekerDerail[index],
                                            ));
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Color(0xffcdd3ff),
                                                  spreadRadius: 1,
                                                  blurRadius: 1,
                                                  offset: Offset(0, 2),
                                                ),
                                              ],
                                              color: kTheme,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.25,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.35,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    radius: 35,
                                                    backgroundImage: NetworkImage(
                                                        "$api/${getController.seekerDerail[index].imagePath}"),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${getController.seekerDerail[index].firstName.capitalizeFirst} ${getController.seekerDerail[index].lastName.capitalizeFirst}",
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: ListTile(
                                                      title: Text(
                                                        getController
                                                                    .seekerDerail[
                                                                        index]
                                                                    .jobPositionName
                                                                    .toString() ==
                                                                "No data"
                                                            ? getController
                                                                .seekerDerail[
                                                                    index]
                                                                .jobPosition
                                                            : getController
                                                                .seekerDerail[
                                                                    index]
                                                                .jobPositionName
                                                                .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          letterSpacing: 1,
                                                        ),
                                                      ),
                                                    ))
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }
                              return Scaffold(
                                body: Center(
                                    child: CircularProgressIndicator(
                                  color: klightpurple,
                                )),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.endFloat,
                floatingActionButton: FloatingActionButton(
                  backgroundColor: klightpurple,
                  onPressed: () {
                    Get.bottomSheet(
                      BottomSheetContent(),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
              );
            } else {
              return Scaffold(
                body: Center(
                    child: CircularProgressIndicator(
                  color: klightpurple,
                )),
              );
            }
          }),
    );
  }
}
