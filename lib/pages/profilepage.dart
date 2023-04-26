import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:googletracking_project/getxcontrollers/profilecontroller.dart';
import 'package:googletracking_project/model/usermodel.dart';
import 'package:googletracking_project/pages/loginpage.dart';
import 'package:nb_utils/nb_utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? password;
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  final newpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Controller = Get.put(ProfileController());
    return ListView(
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
                              height: 30, width: 30, child: Icon(Icons.email)),
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
                              height: 30, width: 30, child: Icon(Icons.phone)),
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
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                            leading: const SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(Icons.settings)),
                            title: Text(
                              "Change Password",
                              style: GoogleFonts.rubik(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff000000),
                              ),
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: const Text("Password Change"),
                                        content: SizedBox(
                                          height: MediaQuery.of(context).size.height/4,
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                decoration: InputDecoration(
                                                    label:
                                                        Text("${user.passWord}"),
                                                    hintText: 'old Password'),
                                                keyboardType:
                                                    TextInputType.visiblePassword,
                                              ),
                                              TextFormField(
                                                  decoration: new InputDecoration(
                                                      hintText: 'Password'),
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  controller: newpassword,
                                                  validator: validateMobile,
                                                  onSaved: (String? val) {
                                                    password = val;
                                                  }),
                                            ],
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("Cancel"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("OK"),
                                            onPressed: () async {
                                              var currentUser=FirebaseAuth.instance.currentUser;
                                              var cred=EmailAuthProvider.credential(email: user.email!, password: user.passWord!);
                                              await currentUser!.reauthenticateWithCredential(cred).then((value) => {
                                                currentUser!.updatePassword(newpassword.text)
                                              });
                                              toast(
                                                  "Password change successfully");
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ]);
                                  });
                            }),
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
                            "Logout",
                            style: GoogleFonts.rubik(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff000000),
                            ),
                          ),
                          onTap: () {
                            FirebaseAuth.instance.signOut();
                            Get.to(LoginPage());
                          },
                        ),
                      ),
                    ],
                  );
                }
              }
              return Container();
            })
      ],
    );
  }

  String? validateMobile(String? value) {
    if (value == null) return "";

    if (value.isEmpty) {
      return "Please enter your password";
    } else if (!pass_valid.hasMatch(value)) {
      return 'Password must containes atleast one capital letter,' +
          '\n' +
          'one lowercase letter,one special charcter';
    } else if (value.length != 9) {
      return "Please length atleast 8 character";
    } else {
      return null;
    }
  }
}
