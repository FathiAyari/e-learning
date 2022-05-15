import 'dart:convert';

EndUser endUserFromJson(String str) => EndUser.fromJson(json.decode(str));

String endUserToJson(EndUser data) => json.encode(data.toJson());

class EndUser {
  EndUser({
    required this.uid,
    this.lastName,
    this.email,
    this.phone,
    this.url,
    this.name,
    this.role,
  });
  String? uid;
  String? name;
  String? url;
  String? lastName;
  String? email;
  String? phone;
  String? role;

  factory EndUser.fromJson(Map<String, dynamic> json) => EndUser(
        uid: json['uid'],
        name: json['name'],
        lastName: json["lastName"],
        email: json["email"],
        phone: json["phone"],
        url: json["url"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "lastName": lastName,
        "url": url,
        "email": email,
        "phoner": phone,
        "role": role,
      };
}
