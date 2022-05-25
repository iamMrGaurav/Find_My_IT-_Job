import 'package:flutter/material.dart';
import 'package:fyp_admin/components/constants.dart';
import 'package:fyp_admin/model/post_job.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class JobDetail extends StatelessWidget {
  final PostJob profile;
  const JobDetail({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPurple,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade200,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: Text(
                                    profile.jobPositionName[0].toUpperCase() +
                                        profile.jobPositionName.substring(1),
                                    style: GoogleFonts.roboto(
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  subtitle: Text(
                                    profile.jobType[0].toUpperCase() +
                                        profile.jobType.substring(1),
                                    style: GoogleFonts.roboto(
                                      fontSize: 30,
                                      color: Colors.white38,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.01),
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
                                        size: 17,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        " ${profile.experience} yrs",
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
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        size: 17,
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
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.calendar_today,
                                        size: 17,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        " ${profile.postedDate.toString().substring(0, 10)}",
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
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        "http://localhost:4000/${profile.imagePath}"),
                                  ),
                                  title: Text(
                                    profile.companyName[0].toUpperCase() +
                                        profile.companyName.substring(1),
                                    style: GoogleFonts.roboto(
                                      fontSize: 30,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width *
                                        0.068),
                                decoration: BoxDecoration(
                                  color: const Color(0xffcdd3ff),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.email_outlined,
                                        size: 17,
                                        color: Colors.deepPurple,
                                      ),
                                      Text(
                                        " ${profile.emailAddress}",
                                        style: GoogleFonts.roboto(
                                          color: Colors.deepPurple,
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
                                  color: const Color(
                                    0xffddc2ff,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.web,
                                        size: 17,
                                        color: Colors.deepPurple,
                                      ),
                                      Text(
                                        " www.google.com",
                                        style: GoogleFonts.roboto(
                                          color: Colors.deepPurple,
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
                                  color: const Color(0xffcdd3ff),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.phone,
                                        size: 17,
                                        color: Colors.deepPurple,
                                      ),
                                      Text(
                                        " ${profile.contactNo}",
                                        style: GoogleFonts.roboto(
                                          color: Colors.deepPurple,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 30),
                            child: Text(
                              "About Company",
                              style: GoogleFonts.aBeeZee(
                                  fontSize: 18, color: kPurple),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              margin: const EdgeInsets.only(left: 20),
                              child: Text(
                                profile.companyDescription,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Job Description",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 18, color: kPurple),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Text(
                            profile.jobDescription,
                            style: TextStyle(
                              overflow: TextOverflow.fade,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Job Specification",
                            style: GoogleFonts.aBeeZee(
                                fontSize: 18, color: kPurple),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Text(
                            profile.jobSpecification,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 70),
                    height: MediaQuery.of(context).size.height * 0.3,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Membership : ",
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 18, color: kPurple),
                                ),
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xffddc2ff,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "${profile.membershipName.toString().capitalizeFirst}"),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "${profile.membershipName == "premium" ? "Membership Registered date" : "Registered date"}: ",
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 18, color: kPurple),
                                ),
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffcdd3ff),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(profile.registeredDate
                                      .toString()
                                      .substring(0, 10)),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Salary : ",
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 18, color: kPurple),
                                ),
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xffddc2ff,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(profile.salary.toString()),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "is Negotiable : ",
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 18, color: kPurple),
                                ),
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffcdd3ff),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Text(profile.isNegotiable.toUpperCase()),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Education : ",
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 18, color: kPurple),
                                ),
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xffddc2ff,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(profile.minimumEducation),
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                margin: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Expired Date : ",
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 18, color: kPurple),
                                ),
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffcdd3ff),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(profile.expiredDate
                                      .toString()
                                      .substring(0, 10)),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
