import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googletracking_project/firebase/authentication_repostory.dart';
import 'package:googletracking_project/model/usermodel.dart';




class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  
  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final role = TextEditingController();
  final _auth = FirebaseAuth.instance;
  
  //Call this Function from Design & it will do the rest
  void registerUser(String email, String password) {
    _auth.createUserWithEmailAndPassword(email: email, password: password);
   
  }
  
 void addUser(UserModel userdata) async {
  await FirebaseFirestore.instance.collection('users').add(userdata.tojson()).whenComplete(() {
    Get.snackbar("Success", "Your account has been created",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green.withOpacity(0.1),
    colorText: Colors.green
    );
  }).catchError((error,stackTrace){
   Get.snackbar("Error", "Something went wrong Try Again",
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.redAccent.withOpacity(0.1),
    colorText: Colors.red
    );
  });
 }

 

}