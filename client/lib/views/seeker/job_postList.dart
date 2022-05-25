import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fmij/components/constants.dart';
import 'package:fmij/controller/company_controller.dart';
import 'package:fmij/controller/seeker_controller.dart';
import 'package:fmij/utilities/global.dart';
import 'package:fmij/views/seeker/job_detail.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/filter_bottomsheet.dart';

class JobPostList extends StatelessWidget {
  JobPostList({Key? key}) : super(key: key);

  final SeekerController controller = Get.put(SeekerController());
  final CompanyController getController = CompanyController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,
        title: const Text(
          "Job Post",
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 50,
                    margin: const EdgeInsets.only(left: 10),
                    width: MediaQuery.of(context).size.width * 0.7,
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
                          controller: controller.searchTextField,
                          decoration: InputDecoration(
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      controller.getSearchPostJob();
                                    },
                                    icon: const Icon(IconlyLight.search),
                                  ),
                                ),
                              ),
                            ),
                            hintText: "Search Jobs",
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
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      Get.bottomSheet(const FilterBottomSheet(
                        isSeeker: "seeker",
                      ));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 30,
                      ),
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Icon(
                          IconlyLight.filter,
                          size: 28,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
              future: controller.fetchOtherCompany(),
              builder: (context, snapshot) {
                return Expanded(
                  child: Obx(
                    () => ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.checkLength(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.to(JobDetailPage(
                                isCompany: "no",
                                profile: controller.filterPostJob.isNotEmpty
                                    ? controller.filterPostJob[index]
                                    : controller.searchPostJob.isNotEmpty
                                        ? controller.searchPostJob[index]
                                        : controller.otherCompanyJob[index],
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
                                                  const EdgeInsets.all(8.0),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                    Colors.transparent,
                                                minRadius: 25,
                                                backgroundImage: NetworkImage(
                                                  "$api/${controller.filterPostJob.isNotEmpty ? controller.filterPostJob[index].imagePath : controller.searchPostJob.isNotEmpty ? controller.searchPostJob[index].imagePath : controller.otherCompanyJob[index].imagePath}",
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  controller.filterPostJob
                                                          .isNotEmpty
                                                      ? controller
                                                          .filterPostJob[index]
                                                          .jobPositionName
                                                      : controller.searchPostJob
                                                              .isNotEmpty
                                                          ? controller
                                                              .searchPostJob[
                                                                  index]
                                                              .jobPositionName
                                                          : controller
                                                              .otherCompanyJob[
                                                                  index]
                                                              .jobPositionName,
                                                  style: GoogleFonts.roboto(
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
                                                      size: 16,
                                                      color: klightpurple,
                                                    ),
                                                    const SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      controller.filterPostJob
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
                                                                  .otherCompanyJob[
                                                                      index]
                                                                  .jobType,
                                                      style: TextStyle(
                                                          color: Colors
                                                              .grey.shade600),
                                                    ),
                                                    const SizedBox(
                                                      width: 7,
                                                    ),
                                                    const Icon(
                                                      IconlyLight.location,
                                                      size: 16,
                                                      color: klightpurple,
                                                    ),
                                                    const SizedBox(
                                                      width: 3,
                                                    ),
                                                    Text(
                                                      controller.filterPostJob
                                                              .isNotEmpty
                                                          ? controller
                                                              .filterPostJob[
                                                                  index]
                                                              .districtName
                                                          : controller
                                                                  .searchPostJob
                                                                  .isNotEmpty
                                                              ? controller
                                                                  .searchPostJob[
                                                                      index]
                                                                  .districtName
                                                              : controller
                                                                  .otherCompanyJob[
                                                                      index]
                                                                  .districtName,
                                                      style: TextStyle(
                                                        color: Colors
                                                            .grey.shade600,
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
                                    Row(
                                      children: [
                                        const Icon(
                                          IconlyLight.timeCircle,
                                          color: klightpurple,
                                          size: 16,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          getController.calculatePostedDate(
                                              controller
                                                      .filterPostJob.isNotEmpty
                                                  ? controller
                                                      .filterPostJob[index]
                                                      .postedDate
                                                      .toString()
                                                  : controller.searchPostJob
                                                          .isNotEmpty
                                                      ? controller
                                                          .searchPostJob[index]
                                                          .postedDate
                                                          .toString()
                                                      : controller
                                                          .otherCompanyJob[
                                                              index]
                                                          .postedDate
                                                          .toString()),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                );
              })
        ],
      ),
    );
  }
}
