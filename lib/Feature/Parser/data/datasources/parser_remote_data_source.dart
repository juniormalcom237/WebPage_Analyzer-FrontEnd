import 'dart:convert';
import 'dart:io';

import 'package:html/parser.dart' as htmlParser;
import 'package:http/http.dart' as http;
import 'package:web_page_analyzer/Feature/Parser/data/model/Html_model.dart';
import 'package:web_page_analyzer/Feature/Parser/domain/entities/HtmlParse.dart';

import '../../../../Core/Error/exception.dart';
import '../../domain/entities/Html.dart';

class ParserRemoteDataSource {
  // Future<HtmlModelData> getParsedData({required String urlString}) async {
  //   final url = Uri.parse(urlString);
  //   try {
  //     final response = await http.get(url);
  //     return fetchAndParseHTML(response);
  //   } catch (e) {
  //     throw ServerException(e.toString());
  //   }
  // }
  final hasError = {'error': 'connexion'};

  String parseHtmlVersion(String html) {
    RegExp regex = RegExp(r'<!DOCTYPE html.*>');
    Match match = regex.firstMatch(html) as Match;

    if (match != null) {
      String doctype = match.group(0)!;
      doctype = doctype.toLowerCase();
      print(doctype);
      if (doctype.contains('html 4.01')) {
        return 'HTML 4.01';
      } else if (doctype.contains('xhtml')) {
        return 'XHTML';
      } else {
        return 'HTML 5';
      }
    }
    return 'Unknown';
  }

  HtmlModelData fetchAndParseHTML(http.Response response) {
    String _pageTitle = '';
    String _htmlVersion = '';
    Map<String, int> _headingCounts = {
      'h1': 0,
      'h2': 0,
      'h3': 0,
      'h4': 0,
      'h5': 0,
      'h6': 0,
    };
    int _internalLinksCount = 0;
    int _externalLinksCount = 0;

    if (response.statusCode == 200) {
      // print(response.body);
      final document = htmlParser.parse(response.body);

      // Get page title
      final titleElement = document.querySelector('title');
      if (titleElement != null) {
        _pageTitle = titleElement.text.trim();
      }

      final version = parseHtmlVersion(response.body);
      _htmlVersion = version;

      // Count headings
      _headingCounts.keys.forEach((key) {
        final elements = document.getElementsByTagName(key);
        _headingCounts[key] = elements.length;
      });

      // Count internal and external links
      final internalLinks = <String>{};
      final externalLinks = <String>{};

      document.querySelectorAll('a').forEach((element) {
        final href = element.attributes['href'];
        if (href != null) {
          if (href.startsWith('http')) {
            externalLinks.add(href);
          } else {
            internalLinks.add(href);
          }
        }
      });

      _internalLinksCount = internalLinks.length;
      _externalLinksCount = externalLinks.length;

      return HtmlModelData(
          basicInfo: BasicInfo(
              version: _htmlVersion, isLogin: false, pageTitle: _pageTitle),
          heading: _headingCounts,
          hyperLinks: {
            'internalLink': _internalLinksCount,
            'externalLink': _externalLinksCount
          });
    } else {
      throw Exception('Failed to load HTML');
    }
  }

  Future<HtmlParse> getParsedData({required String urlString}) async {
    final url = Uri.parse("http://localhost:3000/scrape?url=$urlString");
    try {
      final response = await http.get(url);
      //     .timeout(const Duration(seconds: 6),
      //     onTimeout: () {
      //   // Time has run out, do what you wanted to do.
      //     return http.Response(
      //       hasError.toString(), 408); // Request Timeout response status code
      // });

      var data = jsonDecode(response.body);
      // print(HtmlParse.fromJson(data[0]));

      print(data);
      if (data['error'] != null) {
        print(data['error']);
        throw ServerException(data['error']);
      }
      return HtmlParse.fromJson(data);
    } on ServerException catch (e) {
      print(e.toString());
      throw ServerException(e.message);
    } on SocketException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
