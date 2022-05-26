import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fmij/controller/company_controller.dart';
import 'package:fmij/model/post_job.dart';
import 'package:fmij/utilities/global.dart';
import 'package:fmij/views/pages/seeker_profile_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PostedJobDetail extends StatelessWidget {
  final PostJob profile;
  PostedJobDetail({
    Key? key,
    required this.profile,
  }) : super(key: key);

  final CompanyController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.21,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(80),
                  ),
                  color: Colors.deepPurple,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      profile.jobPositionName.capitalizeFirst.toString(),
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 28,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0xff91C788),
                            child: Text(
                              "\$",
                              style: TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Salary",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${profile.salary}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0xffB980F0),
                            child: Icon(
                              IconlyLight.timeSquare,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Job Type",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            profile.jobType.capitalizeFirst.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Color(0xffFF6363),
                            child: Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Experience",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${profile.experience} yrs",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                  Text(
                    "Minimum Education",
                    style: GoogleFonts.aBeeZee(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      profile.minimumEducation,
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "  Applicants",
                  style: GoogleFonts.aBeeZee(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 30,
                  child: FutureBuilder(
                      future: controller.getApplicants(profile.jobId),
                      builder: (context, snapshot) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.applicants.length,
                          itemBuilder: (contex, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(SeekerProfilePage(
                                  isAppliedSeeker: "yes",
                                  profileController:
                                      controller.applicants[index],
                                ));
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage(
                                    "$api/${controller.applicants[index].imagePath}"),
                              ),
                            );
                          },
                        );
                      }),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                  Text(
                    "Skills Required",
                    style: GoogleFonts.aBeeZee(
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
                height: 8,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                  Text(
                    "Job Description",
                    style: GoogleFonts.roboto(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                child: Text(profile.jobDescription.toString()),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.04,
                  ),
                  Text(
                    "Job Specification",
                    style: GoogleFonts.roboto(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19),
                child: Text(profile.jobSpecification.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
