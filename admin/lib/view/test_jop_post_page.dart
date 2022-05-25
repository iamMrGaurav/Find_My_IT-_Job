import 'package:flutter/material.dart';
import 'package:fyp_admin/controller/admin%20Controller/admin_controller.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class JobPost extends StatelessWidget {
  JobPost({Key? key}) : super(key: key);
  final Admin_Controller controller = Get.put(Admin_Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: controller
                .fetchLimitJobPosition(controller.initialIndex.toString()),
            builder: (context, snapshot) {
              return LazyLoadScrollView(
                onEndOfPage: () {
                  controller.initialIndex += 10;
                  controller.fetchLimitJobPosition(
                      controller.initialIndex.toString());
                },
                child: Obx(
                  () => ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.JobPostPosition.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 90,
                        child: Text(
                          controller.JobPostPosition[index].jobPositionId
                              .toString(),
                        ),
                      );
                    },
                  ),
                ),
              );
            }),
      ),
    );
  }
}
