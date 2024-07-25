import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart' as htmlParser;
import 'package:http/http.dart' as http;
import 'package:web_page_analyzer/Feature/Parser/data/datasources/parser_remote_data_source.dart';
import 'package:web_page_analyzer/Feature/Parser/data/repository/Parser_repository_impl.dart';
import 'package:web_page_analyzer/Feature/Parser/domain/usecase/parse_html.dart';
import 'package:web_page_analyzer/Feature/Parser/presentation/bloc/parser_bloc.dart';

import 'Feature/Parser/presentation/pages/home_page.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => ParserBloc(
      parseHtmlUsecase: ParseHtmlUsecase(
        ParserRepositoryImpl(
          ParserRemoteDataSource(),
        ),
      ),
    ),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTML Parser Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  @override
  void initState() {
    super.initState();
    fetchAndParseHTML();
  }

  void fetchAndParseHTML() async {
    final url = 'https://www.amazon.com'; // Replace with your URL
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // print(response.body);
      final document = htmlParser.parse(response.body);

      // Get page title
      final titleElement = document.querySelector('title');
      if (titleElement != null) {
        setState(() {
          _pageTitle = titleElement.text.trim();
        });
      }

      final version = parseHtmlVersion(response.body);
      setState(() {
        _htmlVersion = version ?? 'HTML version not found';
      });

      // Count headings
      _headingCounts.keys.forEach((key) {
        final elements = document.getElementsByTagName(key);
        setState(() {
          _headingCounts[key] = elements.length;
        });
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

      setState(() {
        _internalLinksCount = internalLinks.length;
        _externalLinksCount = externalLinks.length;
      });
    } else {
      throw Exception('Failed to load HTML');
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTML Parser Demo'),
      ),
      body: _pageTitle.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Page Title: $_pageTitle',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'HTML Version: $_htmlVersion',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Headings:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _headingCounts.entries.map((entry) {
                      return Text('${entry.key}: ${entry.value}');
                    }).toList(),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Internal Links Count: $_internalLinksCount',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'External Links Count: $_externalLinksCount',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
    );
  }
}
