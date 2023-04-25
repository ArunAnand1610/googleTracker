class UserModel {
  final String? id;
  final String? userName;
  final int? mobile;
  final String? email;
  final String? passWord;
  final String? role;
  const UserModel({
    this.id,
    required this.userName,
    required this.mobile,
    required this.email,
    required this.passWord,
    required this.role,
  });
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'],
      userName: data['userName'],
      email: data['email'],
      mobile: data["mobile"],
      passWord: data["password"],
      role: data["role"],
    );
  }
  tojson() {
    return {
      "userName": userName,
      "email": email,
      "mobile": mobile,
      "password": passWord,
      "role": role
    };
  }
}
