import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fyp_admin/components/constants.dart';
import 'package:fyp_admin/view/add_widget.dart';
import 'package:fyp_admin/view/admin_login.dart';
import 'package:fyp_admin/view/home_widget.dart';
import 'package:get/get.dart';

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  Widget homeContent = Home_WIdget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        title: const Text("Admin"),
        backgroundColor: kPurple,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurple),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Colors.deepPurple,
                  ),
                ),
                accountName: Text("Admin"),
                accountEmail: Text("admin@admin.com")),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: kPurple,
                child: Icon(
                  IconlyLight.home,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                setState(() {
                  homeContent = Home_WIdget();
                });
                Navigator.pop(context);
              },
              title: const Text("Home"),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: kPurple,
                child: Icon(
                  IconlyLight.work,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                setState(() {
                  homeContent = Add_Widget();
                });
                Navigator.pop(context);
              },
              title: const Text("Job Position"),
            ),
            Divider(
              color: Colors.grey.shade300,
              thickness: 1,
            ),
            ListTile(
              onTap: () {
                Get.off(const Admin_Login());
              },
              leading: const Icon(
                IconlyLight.logout,
                color: klightpurple,
              ),
              title: const Text(
                "Logout",
                style: TextStyle(
                  color: kPurple,
                  fontSize: 20,
                ),
              ),
            )
          ],
        ),
      ),
      body: homeContent,
    );
  }
}
