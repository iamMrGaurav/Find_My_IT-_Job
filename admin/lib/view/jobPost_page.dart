import 'package:flutter/material.dart';
import 'package:fyp_admin/components/constants.dart';
import 'package:fyp_admin/view/jobDetail_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controller/admin Controller/postJob_controller.dart';

class JobPostPage extends StatefulWidget {
  const JobPostPage({Key? key}) : super(key: key);

  @override
  State<JobPostPage> createState() => _JobPostPageState();
}

class _JobPostPageState extends State<JobPostPage> {
  final PostJobController controller = Get.put(PostJobController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: kPurple,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(
                                0, 2), // changes position of shadow
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
                            controller: controller.searchPostJobText,
                            decoration: InputDecoration(
                              hintText: "Search Job",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  controller.getSearchPostJob();
                                },
                                icon: const Icon(
                                  Icons.search,
                                  size: 29,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 19,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.88,
                        width: MediaQuery.of(context).size.width * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(19),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 2,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: FutureBuilder(
                            future: controller.fetchPostJob(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Obx(() => ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: controller.checkLength(),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Get.to(JobDetail(
                                              profile: controller
                                                      .filterPostJob.isNotEmpty
                                                  ? controller
                                                      .filterPostJob[index]
                                                  : controller.searchPostJob
                                                          .isNotEmpty
                                                      ? controller
                                                          .searchPostJob[index]
                                                      : controller
                                                          .postJob[index],
                                            ));
                                          },
                                          child: SizedBox(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: SizedBox(
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              minRadius: 25,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                'http://localhost:4000/${controller.postJob[index].imagePath}',
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
                                                                        .filterPostJob
                                                                        .isNotEmpty
                                                                    ? controller
                                                                        .filterPostJob[
                                                                            index]
                                                                        .jobPositionName
                                                                    : controller
                                                                            .searchPostJob
                                                                            .isNotEmpty
                                                                        ? controller
                                                                            .searchPostJob[
                                                                                index]
                                                                            .jobPositionName
                                                                        : controller
                                                                            .postJob[index]
                                                                            .jobPositionName,
                                                                style:
                                                                    GoogleFonts
                                                                        .roboto(
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 6,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  const Icon(
                                                                    Icons.work,
                                                                    size: 13,
                                                                    color:
                                                                        klightpurple,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 3,
                                                                  ),
                                                                  Text(
                                                                    controller
                                                                            .filterPostJob
                                                                            .isNotEmpty
                                                                        ? controller
                                                                            .filterPostJob[index]
                                                                            .companyName
                                                                        : controller.searchPostJob.isNotEmpty
                                                                            ? controller.searchPostJob[index].companyName
                                                                            : controller.postJob[index].companyName,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey
                                                                            .shade600),
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 7,
                                                                  ),
                                                                  const Icon(
                                                                    Icons
                                                                        .location_on,
                                                                    size: 13,
                                                                    color:
                                                                        klightpurple,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 3,
                                                                  ),
                                                                  Text(
                                                                    controller
                                                                            .filterPostJob
                                                                            .isNotEmpty
                                                                        ? controller
                                                                            .filterPostJob[index]
                                                                            .districtName
                                                                        : controller.searchPostJob.isNotEmpty
                                                                            ? controller.searchPostJob[index].districtName
                                                                            : controller.postJob[index].districtName,
                                                                    style:
                                                                        TextStyle(
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
                                                              SizedBox(
                                                                height: 30,
                                                                width: 240,
                                                                child: ListView
                                                                    .builder(
                                                                  shrinkWrap:
                                                                      true,
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  itemCount: controller
                                                                          .filterPostJob
                                                                          .isNotEmpty
                                                                      ? controller
                                                                          .filterPostJob[
                                                                              index]
                                                                          .languages
                                                                          .length
                                                                      : controller
                                                                              .searchPostJob
                                                                              .isNotEmpty
                                                                          ? controller
                                                                              .searchPostJob[
                                                                                  index]
                                                                              .languages
                                                                              .length
                                                                          : controller
                                                                              .postJob[index]
                                                                              .languages
                                                                              .length,
                                                                  itemBuilder:
                                                                      (contex,
                                                                          i) {
                                                                    return Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        horizontal:
                                                                            4,
                                                                      ),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color: index % 2 == 0
                                                                              ? const Color(
                                                                                  0xffcdd3ff,
                                                                                )
                                                                              : const Color(
                                                                                  0xffddc2ff,
                                                                                ),
                                                                          borderRadius:
                                                                              BorderRadius.circular(
                                                                            6,
                                                                          ),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            controller.filterPostJob.isNotEmpty
                                                                                ? controller.filterPostJob[index].languages[i]
                                                                                : controller.searchPostJob.isNotEmpty
                                                                                    ? controller.searchPostJob[index].languages[i]
                                                                                    : controller.postJob[index].languages[i],
                                                                            style:
                                                                                GoogleFonts.roboto(
                                                                              color: kPurple,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            const Icon(
                                                              Icons
                                                                  .calendar_today,
                                                              size: 13,
                                                              color:
                                                                  klightpurple,
                                                            ),
                                                            const SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text(
                                                              controller
                                                                      .filterPostJob
                                                                      .isNotEmpty
                                                                  ? "${controller.getDuration(
                                                                      controller
                                                                          .filterPostJob[
                                                                              index]
                                                                          .postedDate,
                                                                    )}"
                                                                  : controller
                                                                          .searchPostJob
                                                                          .isNotEmpty
                                                                      ? "${controller.getDuration(
                                                                          controller
                                                                              .searchPostJob[index]
                                                                              .postedDate,
                                                                        )}"
                                                                      : "${controller.getDuration(
                                                                          controller
                                                                              .postJob[index]
                                                                              .postedDate,
                                                                        )}",
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .access_time_filled,
                                                              color:
                                                                  klightpurple,
                                                              size: 16,
                                                            ),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              controller
                                                                      .filterPostJob
                                                                      .isNotEmpty
                                                                  ? controller
                                                                      .filterPostJob[
                                                                          index]
                                                                      .jobType
                                                                  : controller
                                                                          .searchPostJob
                                                                          .isNotEmpty
                                                                      ? controller
                                                                          .searchPostJob[
                                                                              index]
                                                                          .jobType
                                                                      : controller
                                                                          .postJob[
                                                                              index]
                                                                          .jobType,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .grey
                                                                    .shade600,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ));
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.deepPurple,
                                ));
                              }
                            })),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(19),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 2,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: kPurple,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    )),
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Center(
                                  child: Text(
                                    "Filter Your Search",
                                    style: GoogleFonts.roboto(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        GetBuilder<PostJobController>(
                            init: controller,
                            builder: (controller) {
                              return Container(
                                height: 50,
                                padding: const EdgeInsets.all(5.0),
                                child: DropdownButton(
                                  underline: const SizedBox(),
                                  hint: const Text(
                                    "Hint Text",
                                    textAlign: TextAlign.center,
                                  ),
                                  isExpanded: true,
                                  value: controller.dropdownvalue,
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  iconSize: 24,
                                  items: controller.items.map(
                                    (String items) {
                                      return DropdownMenuItem(
                                        value: items,
                                        child: Center(
                                          child: Text(
                                            items,
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (String? newValue) {
                                    setState(
                                      () {
                                        controller.dropdownvalue =
                                            newValue.toString();
                                      },
                                    );
                                  },
                                ),
                              );
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.all(5.0),
                          child: DropdownButton(
                            underline: const SizedBox(),
                            hint: const Text(
                              "Hint Text",
                              textAlign: TextAlign.center,
                            ),
                            isExpanded: true,
                            value: controller.jobTypeValue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            items: controller.jobTypes.map(
                              (String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Center(
                                    child: Text(
                                      items,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (String? newValue) {
                              setState(
                                () {
                                  controller.jobTypeValue = newValue.toString();
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.all(5.0),
                          child: DropdownButton(
                            underline: const SizedBox(),
                            hint: const Text(
                              "Hint Text",
                              textAlign: TextAlign.center,
                            ),
                            isExpanded: true,
                            value: controller.dateValue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            items: controller.dateValues.map(
                              (String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Center(
                                    child: Text(
                                      items,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (String? newValue) {
                              setState(
                                () {
                                  controller.dateValue = newValue.toString();
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.all(5.0),
                          child: DropdownButton(
                            underline: const SizedBox(),
                            hint: const Text(
                              "Hint Text",
                              textAlign: TextAlign.center,
                            ),
                            isExpanded: true,
                            value: controller.expiredValue,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            items: controller.expiredValues.map(
                              (String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Center(
                                    child: Text(
                                      items,
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                            onChanged: (String? newValue) {
                              setState(
                                () {
                                  controller.expiredValue = newValue.toString();
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        Container(
                          width: 200,
                          height: 46,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: kPurple,
                            ),
                            onPressed: () {
                              controller.getFilterSearchData(
                                  controller.dropdownvalue.toString(),
                                  controller.jobTypeValue.toString(),
                                  controller.dateValue.toString());
                            },
                            child: Text(
                              "Save",
                              style: GoogleFonts.roboto(
                                fontSize: 21,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              style: TextButton.styleFrom(
                                primary: kPurple,
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    controller.dropdownvalue =
                                        controller.items[0];
                                    controller.jobTypeValue =
                                        controller.jobTypes[0];
                                    controller.dateValue =
                                        controller.dateValues[0];
                                  },
                                );

                                controller.filterPostJob.clear();
                                controller.searchPostJob.clear();
                              },
                              child: const Text('Clear All'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
