class Cusers {
  String name;
  String uid;
  String Gsm;

  String Role;
  String Email;
  String Url;

  Cusers(
      {required this.uid,
      required this.name,
      required this.Email,
      required this.Gsm,
      required this.Role,
      required this.Url});
  factory Cusers.fromJson(Map<String, dynamic> json) {
    return Cusers(
      uid: json["uid"],
      name: json["name"],
      Email: json["Email"],
      Role: json["Role"],
      Gsm: json["Gsm"],
      Url: json["Url"],
    );
  }
// from object to json
  Map<String, dynamic> Tojson() {
    return {
      "uid": uid,
      "name": name,
      "Email": Email,
      "Role": "client",
      "Url": Url,
      "Gsm": Gsm,
    };
  }
}
