import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:googletracking_project/getxcontrollers/profilecontroller.dart';
import 'package:googletracking_project/model/usermodel.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final Controller = Get.put(ProfileController());
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
                child: Center(
              child: ListView(
                children: [
                  const Center(
                    child: UserAccountsDrawerHeader(
                      accountName: Text("Yours Details"),
                      accountEmail: Text(""),
                      currentAccountPicture: CircleAvatar(
                          radius: 86,
                          backgroundColor: Colors.blue,
                          backgroundImage: AssetImage('assets/images.png')),
                    ),
                  ),
                  FutureBuilder(
                      future: Controller.getuserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            UserModel user = snapshot.data as UserModel;
                            return Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: ListTile(
                                    leading: const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Icon(Icons.person_2)),
                                    title: Text(
                                      user.userName ?? "",
                                      style: GoogleFonts.rubik(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: ListTile(
                                    leading: const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Icon(Icons.email)),
                                    title: Text(
                                      user.email ?? "",
                                      style: GoogleFonts.rubik(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: ListTile(
                                    leading: const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Icon(Icons.phone)),
                                    title: Text(
                                      "${user.mobile}" ?? "",
                                      style: GoogleFonts.rubik(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  child: ListTile(
                                    leading: const SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: Icon(Icons.settings)),
                                    title: Text(
                                      "${user.role}" ?? "",
                                      style: GoogleFonts.rubik(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                        }
                        return Container();
                      })
                ],
              ),
            )),
            body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView(children: [
                  Container(
                    height: 48,
                    width: double.infinity,
                    color: const Color.fromRGBO(40, 115, 240, 1),
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                _scaffoldKey.currentState!.openDrawer();
                              },
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 28,
                              )),
                          const Padding(
                            padding: EdgeInsets.only(left: 56.0),
                            child: Text(
                              "Home Page",
                              style: TextStyle(
                                  fontFamily: "Gortita",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 2,
                    margin: const EdgeInsets.only(right: 16, left: 16, top: 16),
                    color: Colors.white,
                  )
                ]))));
  }
}
