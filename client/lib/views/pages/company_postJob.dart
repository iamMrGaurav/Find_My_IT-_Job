import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fmij/components/constants.dart';
import 'package:fmij/controller/company_controller.dart';
import 'package:fmij/views/pages/posted_jobDetail.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CompanyPostJob extends StatelessWidget {
  CompanyPostJob({Key? key}) : super(key: key);
  CompanyController controller = Get.put(CompanyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: const Text("Your Posted Job"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: controller.getPostedJob(2),
                builder: (context, snapshot) {
                  if (controller.postedJobs.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 210,
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset("assets/images/nodata.png",
                                    width: 150),
                                const Text("Empty Data found")
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Obx(
                      () => ListView.builder(
                          itemCount: controller.postedJobs.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(PostedJobDetail(
                                    profile: controller.postedJobs[index],
                                  ));
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.20,
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
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(
                                          0,
                                          1,
                                        ), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              " ${controller.calculatePostedDate(controller.postedJobs[index].postedDate.toString())}",
                                              style: TextStyle(
                                                color: index % 2 == 0
                                                    ? Colors.white54
                                                    : Colors.deepPurple,
                                              ),
                                            ),
                                          ),
                                          PopupMenuButton(
                                            icon: Icon(
                                              Icons.more_horiz,
                                              color: index % 2 == 0
                                                  ? Colors.white
                                                  : Colors.deepPurple,
                                            ),
                                            color: Colors.white,
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                onTap: () {
                                                  controller.deleteJob(
                                                      controller
                                                          .postedJobs[index]
                                                          .jobId);
                                                },
                                                child: const Text("Delete Job"),
                                                value: 1,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      ListTile(
                                        title: Text(
                                          controller
                                              .postedJobs[index].jobPositionName
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 28,
                                            color: index % 2 == 0
                                                ? Colors.white
                                                : Colors.deepPurple,
                                          ),
                                        ),
                                        subtitle: Text(
                                          controller.postedJobs[index].jobType,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: index % 2 == 0
                                                ? Colors.white38
                                                : Colors.deepPurple,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          const SizedBox(
                                            width: 14,
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
                                                    Icons.calendar_today,
                                                    size: 17,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    "  ${controller.postedJobs[index].experience}  yrs ",
                                                    style: GoogleFonts.roboto(
                                                      color: Colors.white70,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
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
                                                    Icons.book,
                                                    size: 17,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    " ${controller.postedJobs[index].minimumEducation}",
                                                    style: GoogleFonts.roboto(
                                                      color: Colors.white70,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
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
                                                    IconlyLight.wallet,
                                                    size: 17,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    "  ${controller.postedJobs[index].salary}",
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
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
