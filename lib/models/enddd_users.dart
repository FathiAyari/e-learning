import 'dart:convert';

EndUser endUserFromJson(String str) => EndUser.fromJson(json.decode(str));

String endUserToJson(EndUser data) => json.encode(data.toJson());

class EndUser {
  EndUser({
    this.username,
    this.fullName,
    this.email,
    this.phone,
    this.uid,
  });

  String? uid;
  String? username;
  String? fullName;
  String? email;
  String? phone;

  factory EndUser.fromJson(Map<String, dynamic> json) => EndUser(
        uid: json["uid"],
        username: json["username"],
        fullName: json["full_name"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJsonUpdate() => {//hedhy l fonction 3maltha ki nheb nbadel ken hedhom
        "username": username,
        "phone": phone,
      };

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "full_name": fullName,
        "email": email,
        "phone": phone,
      };
}
