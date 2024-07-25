import 'dart:convert';

LinkValidationResults linkValidationResultsFromJson(String str) =>
    LinkValidationResults.fromJson(json.decode(str));
String linkValidationResultsToJson(LinkValidationResults data) =>
    json.encode(data.toJson());

// class LinkValidationResults {
//   LinkValidationResults({
//     this.linkValidationResults,
//   });
//
//
//   List<LinkValidationResults>? linkValidationResults;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     if (linkValidationResults != null) {
//       map['linkValidationResults'] =
//           linkValidationResults?.map((v) => v.toJson()).toList();
//     }
//     return map;
//   }
// }

class LinkValidationResults {
  LinkValidationResults({
    this.link,
    this.available,
    this.error,
  });
  // LinkValidationResults.fromJson(dynamic json) {
  //
  // }

  LinkValidationResults.fromJson(dynamic json) {
    link = json['link'];
    available = json['available'];
    error = json['error'];
  }
  String? link;
  bool? available;
  dynamic error;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['link'] = link;
    map['available'] = available;
    map['error'] = error;
    return map;
  }
}
