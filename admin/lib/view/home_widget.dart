import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fyp_admin/components/constants.dart';
import 'package:fyp_admin/utilities/global.dart';
import 'package:fyp_admin/view/companies.dart';
import 'package:fyp_admin/view/jobPost_page.dart';
import 'package:fyp_admin/view/seeker_page.dart';
import 'package:fyp_admin/view/transaction.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';

class Home_WIdget extends StatelessWidget {
  Home_WIdget({
    Key? key,
  }) : super(key: key);

  String totalCompanies = "";
  String totalJobs = "";
  var totalInternship;
  var totalRemote;
  var totalFullTime;
  var totalPartTime;
  var totalSeekers;

  fetchTotalCountValues() async {
    var url = "$api/admin_home";
    var data = await http.get(Uri.parse(url));
    var response = jsonDecode(data.body);
    totalCompanies = response["data"].toString();
    totalJobs = response["jobs"].toString();
    totalFullTime = response["fullTime"];
    totalPartTime = response["partTime"];
    totalInternship = response["internJobs"];
    totalRemote = response["remoteJobs"];
    totalSeekers = response["jobSeeker"];
  }

  late List<GDPData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData("Full Time", totalFullTime == null ? 0 : totalFullTime),
      GDPData("Internship", totalInternship == null ? 0 : totalInternship),
      GDPData("Part Time", totalPartTime == null ? 0 : totalPartTime),
      GDPData("Remote Jobs", totalRemote == null ? 0 : totalRemote),
    ];
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchTotalCountValues(),
      builder: (c, s) {
        _chartData = getChartData();
        _tooltipBehavior = TooltipBehavior(enable: true);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(const JobPostPage());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [kPurple, klightpurple],
                          ),
                          // color: Colors.deepPurple,
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
                                        "Total Jobs",
                                        style: GoogleFonts.roboto(
                                          fontSize: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                      subtitle: Text(
                                        totalJobs.toString(),
                                        style: GoogleFonts.roboto(
                                          fontSize: 30,
                                          color: Colors.white38,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 50),
                                    child: Icon(
                                      Icons.work,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(Companies());
                      },
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
                                      title: Text(
                                        "Companies",
                                        style: GoogleFonts.roboto(
                                          fontSize: 30,
                                          color: kPurple,
                                        ),
                                      ),
                                      subtitle: Text(
                                        totalCompanies.toString(),
                                        style: GoogleFonts.roboto(
                                          fontSize: 30,
                                          color: kPurple,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 50),
                                    child: Icon(
                                      IconlyLight.category,
                                      size: 40,
                                      color: kPurple,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(SeekerPage());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [kPurple, klightpurple],
                          ),
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
                                        "Seekers",
                                        style: GoogleFonts.roboto(
                                          fontSize: 30,
                                          color: Colors.white,
                                        ),
                                      ),
                                      subtitle: Text(
                                        totalSeekers.toString(),
                                        style: GoogleFonts.roboto(
                                          fontSize: 30,
                                          color: Colors.white38,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 50),
                                    child: Icon(
                                      IconlyLight.profile,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(TransactionPage());
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 100),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [kPurple, klightpurple],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.4,
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
                                      "Transaction",
                                      style: GoogleFonts.roboto(
                                        fontSize: 30,
                                        color: Colors.white,
                                      ),
                                    ),
                                    subtitle: Text(
                                      totalJobs.toString(),
                                      style: GoogleFonts.roboto(
                                        fontSize: 30,
                                        color: Colors.white38,
                                      ),
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(right: 50),
                                  child: Icon(
                                    Icons.payment,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 2,
                            offset: const Offset(
                                0, 6), // changes position of shadow
                          ),
                        ],
                      ),
                      child: SfCircularChart(
                        palette: const [
                          Colors.deepPurple,
                          Color(0xfffa72bc),
                          Color(0xffF7464A),
                          Color(0xff00bfff),
                        ],
                        title: ChartTitle(
                            text: "Chart",
                            textStyle: const TextStyle(fontSize: 26)),
                        legend: Legend(
                          title: LegendTitle(
                              text: "Job Types",
                              textStyle: GoogleFonts.roboto(
                                fontSize: 18,
                              )),
                          isVisible: true,
                          overflowMode: LegendItemOverflowMode.wrap,
                        ),
                        tooltipBehavior: _tooltipBehavior,
                        series: <CircularSeries>[
                          DoughnutSeries<GDPData, String>(
                            dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                                textStyle: GoogleFonts.aBeeZee(fontSize: 14)),
                            dataSource: _chartData,
                            xValueMapper: (GDPData data, _) => data.content,
                            yValueMapper: (GDPData data, _) => data.gdp,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class GDPData {
  GDPData(this.content, this.gdp);
  final String content;
  final int gdp;
}
