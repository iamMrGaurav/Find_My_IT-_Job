import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fmij/utilities/global.dart';
import 'package:fmij/views/pages/filter_bottomsheet.dart';
import 'package:fmij/controller/company_controller.dart';
import 'package:fmij/views/seeker/job_detail.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/constants.dart';

class OtherCompaniesPost extends StatelessWidget {
  OtherCompaniesPost({Key? key}) : super(key: key);

  final CompanyController getController = Get.put(CompanyController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Other company job post"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.deepPurple,
            height: 100,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 2), // changes position of shadow
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
                          controller: getController.searchJob,
                          decoration: InputDecoration(
                            hintText: "Search Jobs",
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            suffixIcon: IconButton(
                              onPressed: () {
                                if (getController.searchJob.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please fill all the fields",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else {
                                  getController.otherCompanyJob.clear();
                                  getController.filterPostJob.clear();
                                  getController.getSearchPostJob();
                                }
                              },
                              icon: const Icon(
                                Icons.search,
                                size: 28,
                              ),
                            ),
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
                      Get.bottomSheet(
                        const FilterBottomSheet(
                          isSeeker: "company",
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 20,
                        right: 30,
                      ),
                      height: 45,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/images/klight_filter.png'),
                          fit: BoxFit.none,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: getController.fetchOtherCompany(),
                builder: (context, snapshot) {
                  return Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: getController.checkLength(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(JobDetailPage(
                              isCompany: "yes",
                              profile: getController.filterPostJob.isNotEmpty
                                  ? getController.filterPostJob[index]
                                  : getController.searchPostJob.isNotEmpty
                                      ? getController.searchPostJob[index]
                                      : getController.otherCompanyJob[index],
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              minRadius: 25,
                                              backgroundImage: NetworkImage(
                                                '$api/${getController.filterPostJob.isNotEmpty ? getController.filterPostJob[index].imagePath : getController.searchPostJob.isNotEmpty ? getController.searchPostJob[index].imagePath : getController.otherCompanyJob[index].imagePath}',
                                              ),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                getController.filterPostJob
                                                        .isNotEmpty
                                                    ? getController
                                                        .filterPostJob[index]
                                                        .jobPositionName
                                                    : getController
                                                            .searchPostJob
                                                            .isNotEmpty
                                                        ? getController
                                                            .searchPostJob[
                                                                index]
                                                            .jobPositionName
                                                        : getController
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
                                                    IconlyLight.work,
                                                    size: 13,
                                                    color: klightpurple,
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    getController.filterPostJob
                                                            .isNotEmpty
                                                        ? getController
                                                            .filterPostJob[
                                                                index]
                                                            .jobType
                                                        : getController
                                                                .searchPostJob
                                                                .isNotEmpty
                                                            ? getController
                                                                .searchPostJob[
                                                                    index]
                                                                .jobType
                                                            : getController
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
                                                    size: 13,
                                                    color: klightpurple,
                                                  ),
                                                  const SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    getController.filterPostJob
                                                            .isNotEmpty
                                                        ? getController
                                                            .filterPostJob[
                                                                index]
                                                            .districtName
                                                        : getController
                                                                .searchPostJob
                                                                .isNotEmpty
                                                            ? controller
                                                                .searchPostJob[
                                                                    index]
                                                                .districtName
                                                            : getController
                                                                .otherCompanyJob[
                                                                    index]
                                                                .districtName,
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade600,
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
                                        IconlyLight.timeSquare,
                                        color: klightpurple,
                                        size: 16,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        getController.calculatePostedDate(
                                            getController
                                                    .filterPostJob.isNotEmpty
                                                ? getController
                                                    .filterPostJob[index]
                                                    .postedDate
                                                    .toString()
                                                : getController.searchPostJob
                                                        .isNotEmpty
                                                    ? controller
                                                        .searchPostJob[index]
                                                        .postedDate
                                                        .toString()
                                                    : getController
                                                        .otherCompanyJob[index]
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
                      },
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
