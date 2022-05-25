import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fmij/controller/company_controller.dart';
import 'package:fmij/utilities/global.dart';
import 'package:fmij/views/seeker/job_detail.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../components/constants.dart';
import '../../controller/seeker_controller.dart';

class AppliedJob extends StatelessWidget {
  final String title;
  AppliedJob({Key? key, required this.title}) : super(key: key);
  final CompanyController obj = CompanyController();
  final SeekerController controller = Get.put(SeekerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(title.toString()),
          elevation: 0,
          backgroundColor: Colors.deepPurple,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: title == "Applied Jobs"
                      ? controller.getAppliedJobs()
                      : controller.getBookmarkJobs(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (title == "Applied Jobs") {
                        if (controller.appliedJobs.isEmpty) {
                          return Center(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 290,
                                ),
                                Image.asset(
                                  "assets/images/men.png",
                                  width: 150,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "You have not applied yet",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Obx(
                            () => ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: title == "Applied Jobs"
                                    ? controller.appliedJobs.length
                                    : controller.bookmarkJobs.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(title == "Applied Jobs"
                                            ? JobDetailPage(
                                                isCompany: "no",
                                                profile: controller
                                                    .appliedJobs[index])
                                            : JobDetailPage(
                                                isCompany: "no",
                                                profile: controller
                                                    .bookmarkJobs[index]));
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
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.26,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.82,
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
                                                title == "Applied Jobs"
                                                    ? IconButton(
                                                        icon: controller
                                                                    .appliedJobs[
                                                                        index]
                                                                    .isBookmark ==
                                                                0
                                                            ? const Icon(
                                                                IconlyLight
                                                                    .bookmark)
                                                            : const Icon(
                                                                Icons.bookmark),
                                                        onPressed: () {
                                                          if (controller
                                                                  .appliedJobs[
                                                                      index]
                                                                  .isBookmark ==
                                                              0) {
                                                            controller.addBookmark(
                                                                controller
                                                                    .appliedJobs[
                                                                        index]
                                                                    .jobId);
                                                          } else {
                                                            controller.removeBookmark(
                                                                controller
                                                                    .appliedJobs[
                                                                        index]
                                                                    .jobId);
                                                          }
                                                          controller
                                                              .getAppliedJobs();
                                                        },
                                                        color: index % 2 == 0
                                                            ? Colors.white54
                                                            : kPurple,
                                                      )
                                                    : IconButton(
                                                        onPressed: () {
                                                          if (controller
                                                                  .bookmarkJobs[
                                                                      index]
                                                                  .isBookmark ==
                                                              0) {
                                                            controller.addBookmark(
                                                                controller
                                                                    .bookmarkJobs[
                                                                        index]
                                                                    .jobId);
                                                          } else {
                                                            controller.removeBookmark(
                                                                controller
                                                                    .bookmarkJobs[
                                                                        index]
                                                                    .jobId);
                                                          }
                                                          controller
                                                              .getBookmarkJobs();
                                                        },
                                                        icon: controller
                                                                    .bookmarkJobs[
                                                                        index]
                                                                    .isBookmark ==
                                                                0
                                                            ? const Icon(
                                                                IconlyLight
                                                                    .bookmark)
                                                            : const Icon(
                                                                Icons.bookmark),
                                                        color: index % 2 == 0
                                                            ? Colors.white54
                                                            : kPurple,
                                                      ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: ListTile(
                                                    leading: CircleAvatar(
                                                      radius: 35,
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      backgroundImage: NetworkImage(
                                                          "$api/${controller.appliedJobs[index].imagePath}"),
                                                    ),
                                                    title: Text(
                                                      title == "Applied Jobs"
                                                          ? controller
                                                              .appliedJobs[
                                                                  index]
                                                              .jobPositionName
                                                          : controller
                                                              .bookmarkJobs[
                                                                  index]
                                                              .jobPositionName,
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 24,
                                                        color: index % 2 == 0
                                                            ? Colors.white
                                                            : kPurple,
                                                      ),
                                                    ),
                                                    subtitle: Text(
                                                      title == "Applied Jobs"
                                                          ? controller
                                                              .appliedJobs[
                                                                  index]
                                                              .jobType
                                                          : controller
                                                              .bookmarkJobs[
                                                                  index]
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
                                                const SizedBox(
                                                  width: 9,
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.01),
                                                  decoration: BoxDecoration(
                                                    color: index % 2 == 0
                                                        ? Colors.white24
                                                        : Colors.deepPurple,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          IconlyLight.work,
                                                          size: 17,
                                                          color: Colors.white,
                                                        ),
                                                        title == "Applied Jobs"
                                                            ? Text(
                                                                " ${controller.appliedJobs[index].companyName}",
                                                                style:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  color: Colors
                                                                      .white70,
                                                                ),
                                                              )
                                                            : Text(
                                                                " ${controller.bookmarkJobs[index].companyName}",
                                                                style:
                                                                    GoogleFonts
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
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          IconlyLight.location,
                                                          size: 17,
                                                          color: Colors.white,
                                                        ),
                                                        title == "Applied Jobs"
                                                            ? Text(
                                                                " ${controller.appliedJobs[index].districtName}",
                                                                style:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  color: Colors
                                                                      .white70,
                                                                ),
                                                              )
                                                            : Text(
                                                                " ${controller.bookmarkJobs[index].districtName}",
                                                                style:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  color: Colors
                                                                      .white70,
                                                                )),
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
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          IconlyLight.calendar,
                                                          size: 17,
                                                          color: Colors.white,
                                                        ),
                                                        title == "Applied Jobs"
                                                            ? Text(
                                                                " ${controller.appliedJobs[index].experience} yrs",
                                                                style:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  color: Colors
                                                                      .white70,
                                                                ),
                                                              )
                                                            : Text(
                                                                " ${controller.bookmarkJobs[index].experience} yrs",
                                                                style:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  color: Colors
                                                                      .white70,
                                                                )),
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
                                                title == "Applied Jobs"
                                                    ? Text(
                                                        "${obj.calculatePostedDate(controller.appliedJobs[index].postedDate.toString())} ",
                                                        style: TextStyle(
                                                          color: index % 2 == 0
                                                              ? Colors.white24
                                                              : Colors
                                                                  .deepPurple,
                                                        ),
                                                      )
                                                    : Text(
                                                        "${obj.calculatePostedDate(controller.bookmarkJobs[index].postedDate.toString())} ",
                                                        style: TextStyle(
                                                          color: index % 2 == 0
                                                              ? Colors.white24
                                                              : Colors
                                                                  .deepPurple,
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
                        }
                      } else if (title == "Bookmark Jobs" &&
                          controller.bookmarkJobs.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 290,
                              ),
                              Image.asset(
                                "assets/images/nodata.png",
                                width: 150,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "You have not bookmark yet",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Obx(
                          () => ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: title == "Applied Jobs"
                                  ? controller.appliedJobs.length
                                  : controller.bookmarkJobs.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(title == "Applied Jobs"
                                          ? JobDetailPage(
                                              isCompany: "no",
                                              profile:
                                                  controller.appliedJobs[index])
                                          : JobDetailPage(
                                              isCompany: "no",
                                              profile: controller
                                                  .bookmarkJobs[index]));
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
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.26,
                                      width: MediaQuery.of(context).size.width *
                                          0.82,
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
                                              title == "Applied Jobs"
                                                  ? IconButton(
                                                      icon: controller
                                                                  .appliedJobs[
                                                                      index]
                                                                  .isBookmark ==
                                                              0
                                                          ? const Icon(
                                                              IconlyLight
                                                                  .bookmark)
                                                          : const Icon(
                                                              Icons.bookmark),
                                                      onPressed: () {
                                                        if (controller
                                                                .appliedJobs[
                                                                    index]
                                                                .isBookmark ==
                                                            0) {
                                                          controller.addBookmark(
                                                              controller
                                                                  .appliedJobs[
                                                                      index]
                                                                  .jobId);
                                                        } else {
                                                          controller
                                                              .removeBookmark(
                                                                  controller
                                                                      .appliedJobs[
                                                                          index]
                                                                      .jobId);
                                                        }
                                                        controller
                                                            .getAppliedJobs();
                                                      },
                                                      color: index % 2 == 0
                                                          ? Colors.white54
                                                          : kPurple,
                                                    )
                                                  : IconButton(
                                                      onPressed: () {
                                                        if (controller
                                                                .bookmarkJobs[
                                                                    index]
                                                                .isBookmark ==
                                                            0) {
                                                          controller.addBookmark(
                                                              controller
                                                                  .bookmarkJobs[
                                                                      index]
                                                                  .jobId);
                                                        } else {
                                                          controller.removeBookmark(
                                                              controller
                                                                  .bookmarkJobs[
                                                                      index]
                                                                  .jobId);
                                                        }
                                                        controller
                                                            .getBookmarkJobs();
                                                      },
                                                      icon: controller
                                                                  .bookmarkJobs[
                                                                      index]
                                                                  .isBookmark ==
                                                              0
                                                          ? const Icon(
                                                              IconlyLight
                                                                  .bookmark)
                                                          : const Icon(
                                                              Icons.bookmark),
                                                      color: index % 2 == 0
                                                          ? Colors.white54
                                                          : kPurple,
                                                    ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ListTile(
                                                  leading: CircleAvatar(
                                                    radius: 35,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    backgroundImage: NetworkImage(
                                                        "$api/${controller.bookmarkJobs[index].imagePath}"),
                                                  ),
                                                  title: Text(
                                                    title == "Applied Jobs"
                                                        ? controller
                                                            .appliedJobs[index]
                                                            .jobPositionName
                                                        : controller
                                                            .bookmarkJobs[index]
                                                            .jobPositionName,
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 24,
                                                      color: index % 2 == 0
                                                          ? Colors.white
                                                          : kPurple,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    title == "Applied Jobs"
                                                        ? controller
                                                            .appliedJobs[index]
                                                            .jobType
                                                        : controller
                                                            .bookmarkJobs[index]
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
                                              const SizedBox(
                                                width: 9,
                                              ),
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
                                                      title == "Applied Jobs"
                                                          ? Text(
                                                              " ${controller.appliedJobs[index].companyName}",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                color: Colors
                                                                    .white70,
                                                              ),
                                                            )
                                                          : Text(
                                                              " ${controller.bookmarkJobs[index].companyName}",
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
                                                      title == "Applied Jobs"
                                                          ? Text(
                                                              " ${controller.appliedJobs[index].districtName}",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                color: Colors
                                                                    .white70,
                                                              ),
                                                            )
                                                          : Text(
                                                              " ${controller.bookmarkJobs[index].districtName}",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                color: Colors
                                                                    .white70,
                                                              )),
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
                                                      title == "Applied Jobs"
                                                          ? Text(
                                                              " ${controller.appliedJobs[index].experience} yrs",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                color: Colors
                                                                    .white70,
                                                              ),
                                                            )
                                                          : Text(
                                                              " ${controller.bookmarkJobs[index].experience} yrs",
                                                              style: GoogleFonts
                                                                  .roboto(
                                                                color: Colors
                                                                    .white70,
                                                              )),
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
                                              title == "Applied Jobs"
                                                  ? Text(
                                                      "${obj.calculatePostedDate(controller.appliedJobs[index].postedDate.toString())} ",
                                                      style: TextStyle(
                                                        color: index % 2 == 0
                                                            ? Colors.white24
                                                            : Colors.deepPurple,
                                                      ),
                                                    )
                                                  : Text(
                                                      "${obj.calculatePostedDate(controller.bookmarkJobs[index].postedDate.toString())} ",
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
                      }
                    } else {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: klightpurple,
                      ));
                    }
                  }),
            ],
          ),
        ));
  }
}
