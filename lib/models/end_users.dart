import 'dart:convert';

EndUser endUserFromJson(String str) => EndUser.fromJson(json.decode(str));

String endUserToJson(EndUser data) => json.encode(data.toJson());

class EndUser {
  EndUser({
   this.nomPrenom,
   this.email,
   this.phone,
   this.uid, 
   
  
  });
  String? uid;
  String? nomPrenom;
  String? email;
  String? phone;
 
  factory EndUser.fromJson(Map<String, dynamic> json) => EndUser(
        uid: json["uid"],
        nomPrenom : json["nomPrenom"],
        email: json["email"],
        phone: json["phone"],
    
      );

  Map<String, dynamic> toJsonUpdate() => {//hedhy l fonction 3maltha ki nheb nbadel ken hedhom
        "nomPrenom": nomPrenom,
        "email":email,
        "phone": phone,
      };

  Map<String, dynamic> toJson() => {
      // "uid": uid,
       "nomPrenom": nomPrenom,
       "email": email,
       "phone": phone,
      };
}
