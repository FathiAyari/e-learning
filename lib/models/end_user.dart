import 'dart:convert';

EndUser endUserFromJson(String str) => EndUser.fromJson(json.decode(str));

String endUserToJson(EndUser data) => json.encode(data.toJson());

class EndUser {
    EndUser({
         required this.uid,
         this.username,
         this.email,
         this.phone,
    });
    String uid;
    String?username;
    String? email;
    int? phone;

    factory EndUser.fromJson(Map<String, dynamic> json) => EndUser(
        uid: json['uid'] ,
        username: json["username"],
        email: json["email"],
        phone: json["phoner"], 
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "phoner": phone,
    };
}
