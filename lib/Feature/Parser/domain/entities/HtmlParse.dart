import 'dart:convert';

import 'package:web_page_analyzer/Feature/Parser/domain/entities/LinkValidationResults.dart';

HtmlParse htmlParseFromJson(String str) => HtmlParse.fromJson(json.decode(str));

class HtmlParse {
  HtmlParse({
    this.pageTitle,
    this.htmlVersion,
    this.headings,
    this.links,
    this.linkValidation,
    this.isLoginForm,
  });

  HtmlParse.fromJson(Map<String, dynamic> json) {
    pageTitle = json['pageTitle'];
    htmlVersion = json['htmlVersion'];
    headings = json['headingCounts'] != null
        ? Headings.fromJson(json['headingCounts'])
        : null;
    links = json['links'] != null ? Links.fromJson(json['links']) : null;
    if (json['linkValidationResults'] != null) {
      linkValidation = [];
      json['linkValidationResults'].forEach((v) {
        linkValidation?.add(LinkValidationResults.fromJson(v));
      });
    }

    isLoginForm = json['isLoginForm'];
  }
  String? pageTitle;
  String? htmlVersion;
  Headings? headings;
  Links? links;
  List<LinkValidationResults>? linkValidation;
  bool? isLoginForm;
}

// class LinkValidation {
//   LinkValidation({
//     required this.link,
//   });
//
//   LinkValidation.fromJson(Map<String, dynamic> json) {
//     link = json['link'];
//   }
//   late String link;
//   late bool available;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['link'] = link;
//     return map;
//   }
// }

class Links {
  Links({
    this.internal,
    this.external,
  });

  Links.fromJson(Map<String, dynamic> json) {
    internal = json['internal'];
    external = json['external'];
  }
  int? internal;
  int? external;
}

class Headings {
  Headings({
    this.h1,
    this.h2,
    this.h3,
    this.h4,
    this.h5,
    this.h6,
  });

  Headings.fromJson(dynamic json) {
    h1 = json['h1'];
    h2 = json['h2'];
    h3 = json['h3'];
    h4 = json['h4'];
    h5 = json['h5'];
    h6 = json['h6'];
  }
  int? h1;
  int? h2;
  int? h3;
  int? h4;
  int? h5;
  int? h6;
}
