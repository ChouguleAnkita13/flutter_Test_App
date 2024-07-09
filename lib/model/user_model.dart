class UserModel {
  int? id;
  String name;
  String email;
  String password;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> userMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  @override
  String toString() {
    return '''{'id':$id,
      'name':$name,
      'email':$email,
      'password':$password,
      }''';
  }
}
