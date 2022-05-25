import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fmij/controller/company_controller.dart';
import 'package:fmij/utilities/global.dart';
import 'package:fmij/views/login_screen.dart';
import 'package:fmij/views/seeker/applied_job.dart';
import 'package:fmij/views/seeker/job_detail.dart';
import 'package:fmij/views/seeker/job_postList.dart';
import 'package:fmij/views/seeker/seeker_profile.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/constants.dart';
import '../../controller/seeker_controller.dart';

class SeekerHome extends StatelessWidget {
  final SeekerController controller = Get.put(SeekerController());
  final CompanyController obj = Get.put(CompanyController());

  @override
  Widget build(BuildContext context) {
    Widget homeContent = HomeContent(
      controller: controller,
      obj: obj,
    );

    return FutureBuilder(
        future: controller.fetchSeekerProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              backgroundColor: Colors.grey.shade200,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                elevation: 5,
                title: Text(
                  controller.seekerProfileDetail[0].userName
                      .toString()
                      .capitalizeFirst
                      .toString(),
                  style: GoogleFonts.roboto(color: Colors.white),
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
                          radius: 25,
                          backgroundImage: NetworkImage(
                            "$api/${controller.seekerProfileDetail[0].imagePath}",
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              drawer: Drawer(
                child: FutureBuilder(
                    future: controller.fetchSeekerProfile(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(SeekerProfile());
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
                                        "$api/${controller.seekerProfileDetail[0].imagePath}"),
                                  ),
                                  accountName: Text(controller
                                      .seekerProfileDetail[0].firstName),
                                  accountEmail: Text(controller
                                      .seekerProfileDetail[0].emailAddress)),
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
                                child:
                                    Icon(IconlyLight.bookmark, color: kPurple),
                              ),
                              onTap: () {
                                Get.to(AppliedJob(title: "Bookmark Jobs"));
                              },
                              title: const Text("Bookmarks"),
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                            ),
                            ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: Color(0xffF0EEFA),
                                child: Icon(
                                  IconlyLight.work,
                                  color: kPurple,
                                ),
                              ),
                              onTap: () {
                                Get.to(AppliedJob(title: "Applied Jobs"));
                              },
                              title: const Text("Applied Jobs"),
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
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
              ),
              body: homeContent,
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: klightpurple,
            ));
          }
        });
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({
    Key? key,
    required this.controller,
    required this.obj,
  }) : super(key: key);

  final SeekerController controller;
  final CompanyController obj;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(AppliedJob(
                          title: "Applied Jobs",
                        ));
                      },
                      child: Text(
                        "Find Your",
                        style: GoogleFonts.roboto(
                            fontSize: 30, color: Colors.grey.shade400),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Dream Jobs",
                      style: GoogleFonts.roboto(
                        fontSize: 30,
                        color: kPurple,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 20),
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ThemeData().colorScheme.copyWith(
                            primary: klightpurple,
                          ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: TextField(
                        autofocus: false,
                        controller: controller.searchTextField,
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              width: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: GestureDetector(
                                  onTap: () {
                                    if (controller
                                        .searchTextField.text.isEmpty) {
                                      Fluttertoast.showToast(
                                          msg: "Please fill the empty fields",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      controller.getSearchPostJob();
                                      Get.to(JobPostList());
                                    }
                                  },
                                  child: const Icon(
                                    IconlyLight.search,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          hintText: "Search Jobs e.g Database...",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  " Recent Jobs",
                  style: GoogleFonts.roboto(fontSize: 22),
                ),
                TextButton(
                  onPressed: () {
                    Get.to(JobPostList());
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
            height: MediaQuery.of(context).size.height * 0.30,
            child: FutureBuilder(
                future: controller.fetchOtherCompany(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Obx(
                      () => ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.otherCompanyJob.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(JobDetailPage(
                                      isCompany: "no",
                                      profile:
                                          controller.otherCompanyJob[index]));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [
                                        index % 2 == 0 ? kPurple : Colors.white,
                                        index % 2 == 0
                                            ? klightpurple
                                            : Colors.white
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  width:
                                      MediaQuery.of(context).size.width * 0.82,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              if (controller
                                                      .otherCompanyJob[index]
                                                      .isBookmark ==
                                                  0) {
                                                controller.addBookmark(
                                                    controller
                                                        .otherCompanyJob[index]
                                                        .jobId);
                                              } else {
                                                controller.removeBookmark(
                                                    controller
                                                        .otherCompanyJob[index]
                                                        .jobId);
                                              }
                                              controller.fetchOtherCompany();
                                            },
                                            icon: Icon(
                                              controller.otherCompanyJob[index]
                                                          .isBookmark ==
                                                      0
                                                  ? IconlyLight.bookmark
                                                  : Icons.bookmark,
                                              size: 26,
                                              color: index % 2 == 0
                                                  ? Colors.white54
                                                  : kPurple,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                radius: 25,
                                                backgroundColor:
                                                    Colors.transparent,
                                                backgroundImage: NetworkImage(
                                                  "$api/${controller.otherCompanyJob[index].imagePath}",
                                                ),
                                              ),
                                              title: Text(
                                                controller
                                                    .otherCompanyJob[index]
                                                    .jobPositionName,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 24,
                                                  color: index % 2 == 0
                                                      ? Colors.white
                                                      : kPurple,
                                                ),
                                              ),
                                              subtitle: Text(
                                                controller
                                                    .otherCompanyJob[index]
                                                    .jobType,
                                                style: GoogleFonts.roboto(
                                                  fontSize: 20,
                                                  color: index % 2 == 0
                                                      ? Colors.white24
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
                                          Container(
                                            margin: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01),
                                            decoration: BoxDecoration(
                                              color: index % 2 == 0
                                                  ? Colors.white24
                                                  : Colors.deepPurple,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    IconlyLight.work,
                                                    size: 17,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    " ${controller.otherCompanyJob[index].companyName}",
                                                    style: GoogleFonts.roboto(
                                                      color: Colors.white70,
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
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    IconlyLight.location,
                                                    size: 17,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    " ${controller.otherCompanyJob[index].districtName}",
                                                    style: GoogleFonts.roboto(
                                                      color: Colors.white70,
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
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    IconlyLight.calendar,
                                                    size: 17,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    " ${controller.otherCompanyJob[index].experience} yrs",
                                                    style: GoogleFonts.roboto(
                                                      color: Colors.white70,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${obj.calculatePostedDate(controller.otherCompanyJob[index].postedDate.toString())} ",
                                            style: TextStyle(
                                              color: index % 2 == 0
                                                  ? Colors.white24
                                                  : Colors.deepPurple,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  } else {
                    return const Scaffold(
                        body: Center(
                      child: CircularProgressIndicator(),
                    ));
                  }
                }),
          ),
          const SizedBox(
            height: 13,
          ),
          Text(
            " Jobs you may like",
            style: GoogleFonts.roboto(fontSize: 22),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.38,
            child: FutureBuilder(
                future: controller.getUserPreferJobs(controller
                    .seekerProfileDetail[0].jobPosition
                    .toString()
                    .substring(0, 3)),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Obx(
                      () => ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: controller.userPreferJobs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 0.2,
                                        blurRadius: 0.1,
                                        offset: const Offset(0,
                                            0.1), // changes position of shadow
                                      ),
                                    ],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(JobDetailPage(
                                        isCompany: "no",
                                        profile:
                                            controller.userPreferJobs[index],
                                      ));
                                    },
                                    child: SizedBox(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: SizedBox(
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        minRadius: 25,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          "$api/${controller.userPreferJobs[index].imagePath}",
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          controller
                                                              .userPreferJobs[
                                                                  index]
                                                              .jobPositionName,
                                                          style: GoogleFonts
                                                              .roboto(
                                                            fontSize: 17,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons.work,
                                                              size: 16,
                                                              color:
                                                                  klightpurple,
                                                            ),
                                                            const SizedBox(
                                                              width: 3,
                                                            ),
                                                            Text(
                                                              controller
                                                                  .userPreferJobs[
                                                                      index]
                                                                  .jobType,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600),
                                                            ),
                                                            const SizedBox(
                                                              width: 7,
                                                            ),
                                                            const Icon(
                                                              IconlyLight
                                                                  .location,
                                                              size: 16,
                                                              color:
                                                                  klightpurple,
                                                            ),
                                                            const SizedBox(
                                                              width: 3,
                                                            ),
                                                            Text(
                                                              controller
                                                                  .userPreferJobs[
                                                                      index]
                                                                  .districtName,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade600,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 8,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    if (controller
                                                            .userPreferJobs[
                                                                index]
                                                            .isBookmark ==
                                                        0) {
                                                      controller.addBookmark(
                                                          controller
                                                              .userPreferJobs[
                                                                  index]
                                                              .jobId);
                                                    } else {
                                                      controller.removeBookmark(
                                                          controller
                                                              .userPreferJobs[
                                                                  index]
                                                              .jobId);
                                                    }

                                                    controller.getUserPreferJobs(
                                                        controller
                                                            .seekerProfileDetail[
                                                                0]
                                                            .jobPosition
                                                            .toString()
                                                            .substring(0, 3));
                                                  },
                                                  icon: Icon(
                                                    controller
                                                                .userPreferJobs[
                                                                    index]
                                                                .isBookmark ==
                                                            0
                                                        ? IconlyLight.bookmark
                                                        : Icons.bookmark,
                                                    size: 26,
                                                    color: kPurple,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      IconlyLight.timeCircle,
                                                      color: klightpurple,
                                                      size: 13,
                                                    ),
                                                    const SizedBox(
                                                      width: 8,
                                                    ),
                                                    Text(
                                                      obj.calculatePostedDate(
                                                          controller
                                                              .userPreferJobs[
                                                                  index]
                                                              .postedDate
                                                              .toString()),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                            );
                          }),
                    );
                  } else {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: klightpurple,
                    ));
                  }
                }),
          )
        ],
      ),
    );
  }
}
