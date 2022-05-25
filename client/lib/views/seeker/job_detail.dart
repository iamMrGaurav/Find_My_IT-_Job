import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fmij/components/constants.dart';
import 'package:fmij/controller/seeker_controller.dart';
import 'package:fmij/main.dart';
import 'package:fmij/model/post_job.dart';
import 'package:fmij/utilities/global.dart';
import 'package:fmij/views/pages/message.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetailPage extends StatefulWidget {
  final String isCompany;
  PostJob profile;
  JobDetailPage({Key? key, required this.profile, required this.isCompany})
      : super(key: key);

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  final SeekerController controller = Get.put(SeekerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: [
          widget.isCompany == "yes"
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    icon: Icon(widget.profile.isBookmark == 0
                        ? IconlyLight.bookmark
                        : Icons.bookmark),
                    onPressed: () async {
                      if (widget.profile.isBookmark == 0) {
                        await controller.bookmarkJob(widget.profile.jobId);

                        setState(() {
                          widget.profile.isBookmark = 1;
                        });
                      } else {
                        await controller.removeBookmark(widget.profile.jobId);

                        setState(() {
                          widget.profile.isBookmark = 0;
                        });
                      }
                    },
                  ),
                )
        ],
      ),
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.26,
                width: double.infinity,
                decoration: BoxDecoration(
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
                      height: 20,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 35,
                      backgroundImage: NetworkImage(
                        "$api/${widget.profile.imagePath}",
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.profile.jobPositionName.capitalizeFirst.toString(),
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                                  Icons.work,
                                  size: 17,
                                  color: Colors.white,
                                ),
                                Text(
                                  " ${widget.profile.companyName.capitalizeFirst.toString()}",
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
                                  IconlyLight.location,
                                  size: 17,
                                  color: Colors.white,
                                ),
                                Text(
                                  " ${widget.profile.districtName}",
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
                                  IconlyLight.calendar,
                                  size: 17,
                                  color: Colors.white,
                                ),
                                Text(
                                  " ${widget.profile.postedDate.toString().substring(0, 10)}",
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
              const SizedBox(
                height: 18,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "  About Us",
                    style: GoogleFonts.aBeeZee(fontSize: 19),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.profile.companyDescription.capitalizeFirst
                          .toString(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await launch('tel:${widget.profile.contactNo}');
                    },
                    child: Row(
                      children: [
                        const Icon(
                          IconlyLight.call,
                          color: klightpurple,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.profile.contactNo.toString(),
                          style: const TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        await launch(
                            'mailto:${widget.profile.emailAddress}?subject=This is Subject Title&body=This is Body of Email');
                      } catch (exception) {
                        print(exception);
                      }
                    },
                    child: Row(
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
                          widget.profile.emailAddress,
                          style: const TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Visit Us at :",
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(widget.profile.website,
                      style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: klightpurple,
                          decoration: TextDecoration.underline))
                ],
              ),
              const SizedBox(
                height: 20,
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
                            "${widget.profile.salary}",
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
                            widget.profile.jobType.capitalizeFirst.toString(),
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
                            "${widget.profile.experience} yrs",
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
                child: Text(
                  " ${widget.profile.minimumEducation}",
                  style: GoogleFonts.roboto(color: Colors.grey, fontSize: 17),
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
                    itemCount: widget.profile.languages.length,
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
                              widget.profile.languages[index],
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
                    style: GoogleFonts.aBeeZee(
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
                child: Text(widget.profile.jobDescription.toString()),
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
                    style: GoogleFonts.aBeeZee(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 19),
                child: Text(
                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and ting industry. Lorem Ipsum has been the industry's standard dummy "),
              ),
              const SizedBox(
                height: 10,
              ),
              widget.isCompany == "yes"
                  ? const SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 56,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: ElevatedButton(
                            child: Text(
                              widget.profile.isApplied == 0
                                  ? "Apply"
                                  : "Applied",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                letterSpacing: 1.1,
                              ),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.deepPurple,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide(
                                    color: Colors.deepPurple,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (widget.profile.isApplied == 0) {
                                controller.applyJob(widget.profile.jobId);
                                setState(() {
                                  widget.profile.isApplied = 1;
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Already Apply",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.green,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            },
                          ),
                        ),
                        widget.profile.isApplied != 0
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: IconButton(
                                      onPressed: () {
                                        Get.to(ChatScreen(
                                          companyId: widget.profile.comapnyId
                                              .toString(),
                                          seekerId: MainScreen.seekerId,
                                          isCompany: widget.isCompany,
                                          title: widget.profile.companyName,
                                          imagepath: widget.profile.imagePath,
                                          receiverName: widget.profile.userName,
                                        ));
                                      },
                                      icon: const Icon(
                                        Icons.message_sharp,
                                      )),
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
