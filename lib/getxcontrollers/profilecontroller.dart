import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:googletracking_project/getxcontrollers/logincontroller.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _userdetail = Get.put(LoginController());
  late final String? name;
  final _db = FirebaseAuth.instance;
  getuserData() {
    final email = _db.currentUser!.email;

    if (email != null) {
      return _userdetail.getuserDetails(email);
    } else {
      Get.snackbar("Error", "SomethingWent wrong");
    }
  }

  getuserName() {
    final email = _db.currentUser!.email;

    if (email != null) {
      return _userdetail.getuserRole(email);
    } else {
      Get.snackbar("Error", "SomethingWent wrong");
    }
  }
}
