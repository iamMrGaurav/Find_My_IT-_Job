import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fmij/components/constants.dart';
import 'package:fmij/controller/company_controller.dart';
import 'package:fmij/utilities/global.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/seeker_profile_page.dart';

class SeekerList extends StatelessWidget {
  SeekerList({Key? key}) : super(key: key);

  final CompanyController getController = CompanyController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Seekers"),
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [kPurple, klightpurple],
                ),
              ),
              height: 150,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 10, right: 30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
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
                            autofocus: false,
                            controller: getController.searchSeekerText,
                            decoration: InputDecoration(
                              hintText: "Search Seekers",
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if (getController
                                      .searchSeekerText.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Empty Fields Detected",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    getController.searchSeeker.clear();
                                  } else {
                                    getController.searchSeekerData();
                                  }

                                  // getController.otherCompanyJob.clear();
                                  // getController.filterPostJob.clear();
                                  // getController.getSearchPostJob();
                                },
                                icon: const Icon(
                                  IconlyLight.search,
                                  size: 28,
                                ),
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
          ),
          Expanded(
            child: FutureBuilder(
                future: getController.fetchSeekerDetails(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Obx(
                      () => ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: getController.searchSeeker.isEmpty
                              ? getController.seekerDerail.length
                              : getController.searchSeeker.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Get.to(SeekerProfilePage(
                                  isAppliedSeeker: "no",
                                  profileController:
                                      getController.searchSeeker.isEmpty
                                          ? getController.seekerDerail[index]
                                          : getController.searchSeeker[index],
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
                                                    '$api/${getController.seekerDerail[index].imagePath}',
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  getController
                                                          .searchSeeker.isEmpty
                                                      ? Text(
                                                          "${getController.seekerDerail[index].firstName.capitalizeFirst} ${getController.seekerDerail[index].lastName.capitalizeFirst}",
                                                          style: GoogleFonts
                                                              .roboto(
                                                            fontSize: 18,
                                                          ),
                                                        )
                                                      : Text(
                                                          "${getController.searchSeeker[index].firstName.capitalizeFirst} ${getController.searchSeeker[index].lastName.capitalizeFirst}",
                                                          style: GoogleFonts
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
                                                        color: klightpurple,
                                                      ),
                                                      const SizedBox(
                                                        width: 3,
                                                      ),
                                                      Text(
                                                        getController
                                                                .searchSeeker
                                                                .isEmpty
                                                            ? getController
                                                                .seekerDerail[
                                                                    index]
                                                                .jobPositionName
                                                            : getController
                                                                .searchSeeker[
                                                                    index]
                                                                .jobPositionName,
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
                                                        getController
                                                                .searchSeeker
                                                                .isEmpty
                                                            ? getController
                                                                .seekerDerail[
                                                                    index]
                                                                .districtName
                                                            : getController
                                                                .searchSeeker[
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
                                            "${getController.searchSeeker.isEmpty ? getController.seekerDerail[index].workExperience.toString() : getController.searchSeeker[index].workExperience.toString()} yrs",
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
