import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:googletracking_project/model/usermodel.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<UserModel> getuserDetails(String email) async {
    final usersCollection =
        FirebaseFirestore.instance.collection('users').withConverter(
              fromFirestore: (snap, _) => UserModel.fromMap(snap.data()!),
              toFirestore: (user, _) => user.tojson(),
            );
    final snapshot = await usersCollection
        .where('email', isEqualTo: email)
        .get()
        .then((value) => value.docs[0].data());
    return snapshot;
  }
  Future<String?> getuserRole(String email) async {
    final usersCollection =
        FirebaseFirestore.instance.collection('users').withConverter(
              fromFirestore: (snap, _) => UserModel.fromMap(snap.data()!),
              toFirestore: (user, _) => user.tojson(),
            );
    final snapshot = await usersCollection
        .where('email', isEqualTo: email)
        .get()
        .then((value) => value.docs[0].data());
    return snapshot.role;
  }
}
