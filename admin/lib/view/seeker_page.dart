import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fyp_admin/controller/admin%20Controller/admin_controller.dart';
import 'package:fyp_admin/model/seeker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../components/constants.dart';

class SeekerPage extends StatelessWidget {
  SeekerPage({Key? key}) : super(key: key);

  final Admin_Controller controller = Get.put(Admin_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: kPurple,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * 0.1,
                width: double.infinity,
                color: kPurple,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          margin: const EdgeInsets.only(left: 59),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ThemeData().colorScheme.copyWith(
                                    primary: klightpurple,
                                  ),
                            ),
                            child: TextField(
                              controller: controller.searchSeekerText,
                              decoration: const InputDecoration(
                                hintText: "Search ",
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 29,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          height: 44,
                          width: MediaQuery.of(context).size.width * 0.05,
                          child: ElevatedButton(
                            child: const Text(
                              "Search",
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
                                  borderRadius: BorderRadius.circular(4.0),
                                  side: const BorderSide(
                                    color: Color(0xffF0EEFA),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              controller.searchSeekerData();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
                        future: controller.fetchSeekerDetails(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Obx(
                              () => ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: controller.searchSeeker.isNotEmpty
                                      ? controller.searchSeeker.length
                                      : controller.seekerDerail.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: SeekerDialogBox(
                                                profile: controller
                                                        .searchSeeker.isNotEmpty
                                                    ? controller
                                                        .searchSeeker[index]
                                                    : controller
                                                        .seekerDerail[index],
                                              ),
                                            );
                                          },
                                        );
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
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: CircleAvatar(
                                                          // backgroundColor:
                                                          //     Colors.transparent,
                                                          minRadius: 25,
                                                          backgroundImage:
                                                              NetworkImage(
                                                            'http://localhost:4000/${controller.searchSeeker.isNotEmpty ? controller.searchSeeker[index].imagePath : controller.seekerDerail[index].imagePath}',
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          controller
                                                                  .searchSeeker
                                                                  .isEmpty
                                                              ? Text(
                                                                  "${controller.seekerDerail[index].firstName.capitalizeFirst} ${controller.seekerDerail[index].lastName.capitalizeFirst}",
                                                                  style:
                                                                      GoogleFonts
                                                                          .roboto(
                                                                    fontSize:
                                                                        18,
                                                                  ),
                                                                )
                                                              : Text(
                                                                  "${controller.searchSeeker[index].firstName.capitalizeFirst} ${controller.searchSeeker[index].lastName.capitalizeFirst}",
                                                                  style:
                                                                      GoogleFonts
                                                                          .roboto(
                                                                    fontSize:
                                                                        18,
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
                                                                " ${controller.searchSeeker.isEmpty ? controller.seekerDerail[index].jobPositionName : controller.searchSeeker[index].jobPositionName} ",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600,
                                                                ),
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
                                                                " ${controller.searchSeeker.isEmpty ? controller.seekerDerail[index].districtName : controller.searchSeeker[index].districtName}",
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
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.access_time,
                                                    color: klightpurple,
                                                    size: 16,
                                                  ),
                                                  const SizedBox(
                                                    width: 8,
                                                  ),
                                                  Text(
                                                    " ${controller.searchSeeker.isEmpty ? controller.seekerDerail[index].workExperience : controller.searchSeeker[index].workExperience} yrs work experience",
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
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SeekerDialogBox extends StatelessWidget {
  SeekerDialogBox({
    Key? key,
    required this.profile,
  }) : super(key: key);

  SeekerProfile profile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.29,
                  color: Colors.deepPurple,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                  "http://localhost:4000/${profile.imagePath}"),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${profile.firstName.capitalizeFirst} ${profile.lastName.capitalizeFirst}",
                            style: GoogleFonts.roboto(
                              fontSize: 23,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "@${profile.userName}",
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              color: Colors.white38,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.01),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.work,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    " ${profile.jobPositionName}",
                                    style: GoogleFonts.roboto(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.01),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    IconlyLight.calendar,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    " ${profile.dob.toString().substring(0, 10)}",
                                    style: GoogleFonts.roboto(
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.01),
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    IconlyLight.location,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    " ${profile.districtName}",
                                    style: GoogleFonts.roboto(
                                      color: Colors.white70,
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
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                " Bio",
                style: GoogleFonts.aBeeZee(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              child: Text(
                " ${profile.bio}",
                style: const TextStyle(
                  overflow: TextOverflow.fade,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  const Icon(
                    IconlyLight.call,
                    color: klightpurple,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(profile.contactNo)
                ],
              ),
              const SizedBox(
                width: 9,
              ),
              Row(
                children: [
                  const Icon(
                    IconlyLight.message,
                    color: klightpurple,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    profile.emailAddress,
                  )
                ],
              ),
              const SizedBox(
                width: 9,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: const CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xffB980F0),
              child: Icon(
                IconlyLight.document,
                color: Colors.white,
              ),
            ),
            title: Text(
              "Highest Qualification",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
              ),
            ),
            subtitle: Text(
              profile.highestQualification,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ListTile(
            leading: const CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xffFF6363),
              child: Icon(
                IconlyLight.timeCircle,
                color: Colors.white,
              ),
            ),
            title: Text(
              "Work Experience",
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
              ),
            ),
            subtitle: Text(
              "${profile.workExperience} yrs",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.01,
              ),
              Text(
                "Skills",
                style: GoogleFonts.roboto(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 30,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: profile.languages.length,
                itemBuilder: (contex, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? const Color(0xffcdd3ff)
                            : const Color(
                                0xffddc2ff,
                              ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          profile.languages[index],
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 44,
                width: MediaQuery.of(context).size.width * 0.07,
                child: ElevatedButton(
                  child: const Text(
                    "View CV",
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
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: const BorderSide(
                          color: Color(0xffF0EEFA),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ThemeData().colorScheme.copyWith(
                                    primary: klightpurple,
                                  ),
                            ),
                            child: SizedBox(
                                height: 230,
                                child: SfPdfViewer.network(
                                    "http://www.africau.edu/images/default/sample.pdf")),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 44,
                width: MediaQuery.of(context).size.width * 0.07,
                child: ElevatedButton(
                  child: const Text(
                    "Back",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      letterSpacing: 1.1,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.red,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
