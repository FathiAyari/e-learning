// To parse this JSON data, do
// final dataModel = dataModelFromJson(jsonString);
//hedha mafhmtouch 3lech 3malna ta3 document wehd
import 'dart:convert';

List<DataModel> dataModelFromJson(String str) =>//List<DataModel> = hedhy li
    List<DataModel>.from(json.decode(str).map((x) => DataModel.fromJson(x)));

String dataModelToJson(List<DataModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DataModel {
  DataModel({
    required this.programmation,//hedha esm document 3andi f colle course 
  });

  String programmation;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        programmation: json["programmation"],
      );

  Map<String, dynamic> toJson() => {
        "programmation": programmation,
      };
}
