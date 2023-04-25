// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, non_constant_identifier_names, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, unused_local_variable, deprecated_member_use

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googletracking_project/getxcontrollers/signupcntroller.dart';
import 'package:googletracking_project/model/usermodel.dart';
import 'package:googletracking_project/pages/loginpage.dart';
import 'package:googletracking_project/styles/registerstyle.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with WidgetsBindingObserver {
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();
  final FocusNode focusNode5 = FocusNode();
  List<String> items = ['Police', 'Ambulance', 'Hospital', "Doctor"];
  String? selectedItem ;
  final controller = Get.put(SignUpController());
  final _formKey1 = GlobalKey<FormState>();
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  bool hide = false;
  int flag = 0;
  bool validate = false;
  bool namevalid = false;
  bool mailvalid = false;
  bool phonevalid = false;
  bool passwordvalid = false;
  bool rolevalid = false;

  bool? usernameExists;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    focusNode1.addListener(() {
      setState(() {});
    });
    focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      focusNode1.unfocus();
      focusNode2.unfocus();
      focusNode3.unfocus();
      focusNode4.unfocus();
      focusNode5.unfocus();
      print("inactive");
    } else if (state == AppLifecycleState.resumed) {
      print('app resumed');
    }
  }

  usersLogin() async {
    setState(() {
      validate = true;
    });
    if (_formKey1.currentState!.validate()) {
      setState(() {
        validate = true;
        isLoading = true;
      });

      try {
        final user = UserModel(
          userName: controller.fullName.text,
          email: controller.email.text,
          passWord: controller.password.text,
          mobile: int.parse(controller.phoneNo.text),
          role: selectedItem,
        );
        controller.registerUser(
            controller.email.text, controller.password.text);
        controller.addUser(user);
        Get.to(LoginPage());
        setState(() {
          isLoading = false;
        });
      } catch (e) {
        toast('$e');
        debugPrint("Error: $e");
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Form(
            key: _formKey1,
            child: Column(
              children: [
                Container(
                  height: 72,
                  width: 72,
                  margin: const EdgeInsets.only(
                    top: 40,
                  ),
                  child: Center(child: Image.asset("assets/images.png")),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 40, left: 32, right: 32),
                  child: Center(child: Text("Register", style: headstyle)),
                ),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 6, left: 32, right: 32),
                  child: Center(
                      child: Text(
                          "Lorem ipsum dolor sit amet, consetetur adipscing elitr, sed diam nonumy eirmod tempor",
                          textAlign: TextAlign.center,
                          style: contentstyle)),
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 40, left: 34, right: 34),
                      height: 60,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          focusNode: focusNode2,
                          style: logintextstyle,
                          
                          cursorHeight: 18,
                          validator: (value) {
                            if (value == null) return "";

                            if (value.isEmpty) {
                              setState(() {
                                namevalid = true;
                              });
                              return "Please enter your Name";
                            } else {
                              setState(() {
                                namevalid = false;
                              });
                              return null;
                            }
                          },
                          onChanged: (v) {
                            if (validate == true) {
                              _formKey1.currentState!.validate();
                            }
                          },
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xff007ebc))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xff00c09d))),
                            errorBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.red)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xffe8e8e8))),
                            hintText: 'UserName',
                            hintStyle: TextStyle(
                                fontSize: 13,
                                fontFamily: "Gordita",
                                fontWeight: focusNode2.hasFocus
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                                color: focusNode2.hasFocus
                                    ? Color(0xFF00c19d)
                                    : Color(0xFFd4d4d4)),
                            suffixIcon: IconButton(
                                onPressed: (() {}), icon: Icon(Icons.person)),
                          ),
                          controller: controller.fullName,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 34, right: 34),
                      height: 50,
                      width: double.infinity,
                      child: TextFormField(
                        enableSuggestions: false,
                        autocorrect: false,
                        scrollPadding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        style: logintextstyle,
                        cursorHeight: 18,
                        onChanged: ((v) {
                          if (controller.email.text.isEmpty) {
                            if (v.isEmpty) {
                              setState(() {
                                mailvalid = true;
                              });
                            }
                          } else {
                            if (controller.email.text[0] == " " && v == " ") {
                              setState(() {
                                mailvalid = true;
                                controller.email.clear();
                              });
                            } else {
                              setState(() {
                                mailvalid = false;
                              });
                            }
                          }
                          debugPrint("te vali : $validate");
                          if (validate == true) {
                            _formKey1.currentState!.validate();
                          }
                        }),
                        validator: (value) {
                          if (value!.isEmpty) {
                            setState(() {
                              mailvalid = true;
                            });
                            return "Please Enter Your Mail";
                          } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            setState(() {
                              mailvalid = true;
                            });
                            return "Please Enter Valid Mail";
                          } else {
                            setState(() {
                              mailvalid = false;
                            });
                            return null;
                          }
                        },
                        focusNode: focusNode1,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xff007ebc))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xff00c09d))),
                          errorBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1, color: Colors.red)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1, color: Color(0xffe8e8e8))),
                          hintText: 'E-Mail',
                          hintStyle: TextStyle(
                              fontSize: 13,
                              fontFamily: "Gordita",
                              fontWeight: focusNode1.hasFocus
                                  ? FontWeight.w500
                                  : FontWeight.normal,
                              color: focusNode1.hasFocus
                                  ? Color(0xFF00c19d)
                                  : Color(0xFFd4d4d4)),
                          suffixIcon: IconButton(
                              onPressed: (() {}), icon: Icon(Icons.email)),
                        ),
                        controller: controller.email,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 34, right: 34),
                      height: 60,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          focusNode: focusNode3,
                          style: logintextstyle,
                          cursorHeight: 18,
                          validator: (value) {
                            if (value == null) return "";

                            if (value.isEmpty) {
                              setState(() {
                                phonevalid = true;
                              });
                              return "Please enter your phonenumber";
                            } else if (value.length != 10) {
                              return 'Please enter valid phone number';
                            } else {
                              setState(() {
                                phonevalid = false;
                              });
                              return null;
                            }
                          },
                          onChanged: (v) {
                            if (validate == true) {
                              _formKey1.currentState!.validate();
                            }
                          },
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xff007ebc))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xff00c09d))),
                            errorBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.red)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xffe8e8e8))),
                            hintText: 'Phone',
                            hintStyle: TextStyle(
                                fontSize: 13,
                                fontFamily: "Gordita",
                                fontWeight: focusNode2.hasFocus
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                                color: focusNode2.hasFocus
                                    ? Color(0xFF00c19d)
                                    : Color(0xFFd4d4d4)),
                            suffixIcon: IconButton(
                                onPressed: (() {
                                  setState(() {
                                    hide = !hide;
                                  });
                                }),
                                icon: Icon(Icons.phone)),
                          ),
                          controller: controller.phoneNo,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30, left: 34, right: 34),
                      height: 60,
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          scrollPadding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          focusNode: focusNode4,
                          style: logintextstyle,
                          obscureText: hide == true ? false : true,
                          obscuringCharacter: "*",
                          cursorHeight: 18,
                          validator: (value) {
                            if (value == null) return "";

                            if (value.isEmpty) {
                              setState(() {
                                passwordvalid = true;
                              });
                              return "Please enter your password";
                            } else if (!pass_valid.hasMatch(value)) {
                              return 'Password must containes atleast one capital letter,' '\n' +
                                  'one lowercase letter,one special charcter,8 character';
                            } else {
                              setState(() {
                                passwordvalid = false;
                              });
                              return null;
                            }
                          },
                          onChanged: (v) {
                            if (validate == true) {
                              _formKey1.currentState!.validate();
                            }
                          },
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xff007ebc))),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xff00c09d))),
                            errorBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.red)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Color(0xffe8e8e8))),
                            hintText: 'Password',
                            hintStyle: TextStyle(
                                fontSize: 13,
                                fontFamily: "Gordita",
                                fontWeight: focusNode2.hasFocus
                                    ? FontWeight.w500
                                    : FontWeight.normal,
                                color: focusNode2.hasFocus
                                    ? Color(0xFF00c19d)
                                    : Color(0xFFd4d4d4)),
                            suffixIcon: IconButton(
                                onPressed: (() {
                                  setState(() {
                                    hide = !hide;
                                  });
                                }),
                                icon: hide == false
                                    ? Image(
                                        image: AssetImage("assets/Hide.png"),
                                        height: 20,
                                        width: 20,
                                      )
                                    : Image(
                                        image: AssetImage("assets/Show.png"),
                                        height: 20,
                                        width: 20,
                                      )),
                          ),
                          controller: controller.password,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 30, left: 34, right: 34),
                        height: 60,
                        width: double.infinity,
                        child: Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(
                                      width: 3, color: Color(0xff1FAB89)),
                                ),
                              ),
                              value: selectedItem,
                              items: items
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(item,
                                            style: TextStyle(fontSize: 18)),
                                      ))
                                  .toList(),
                              onChanged: (item) =>
                                  setState(() => selectedItem = item),
                            ))),
                  ],
                ),
                Container(
                  height: 48,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 72, left: 32, right: 32),
                  decoration: buttondecoration,
                  child: MaterialButton(
                    child: Center(
                      child: !isLoading
                          ? Text("REGISTER", style: buttonstyle)
                          : LoadingAnimationWidget.prograssiveDots(
                              color: Colors.white, size: 40),
                    ),
                    onPressed: () {
                      usersLogin();
                    },
                  ),
                ),
                SizedBox(
                  height: focusNode1.hasFocus ? 16 : 0,
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
