class User {
  int? id;
  String? name;
  String? roleid;
  String? email;
  String? token;

  User({this.id, this.name, this.roleid, this.email, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['user']['id'],
        name: json['user']['name'],
        roleid: json['user']['role_id'],
        email: json['user']['email'],
        token: json['user']['token']);
  }
}
