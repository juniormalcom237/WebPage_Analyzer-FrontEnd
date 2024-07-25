class HtmlModel {
  BasicInfo basicInfo;

  HtmlModel(
      {required this.basicInfo,
      required this.heading,
      required this.hyperLinks});
  Map<String, int> heading;
  Map<String, int> hyperLinks;
}

class BasicInfo {
  String version;
  String? pageTitle;
  bool isLogin;
  BasicInfo({required this.version, this.pageTitle, required this.isLogin});
}

enum Heading {
  h1(count: 0),
  h2(count: 0),
  h3(count: 0),
  h4(count: 0),
  h5(count: 0),
  h6(count: 0);

  const Heading({required this.count});

  final int count;
}

enum HyperLinks {
  internal(count: 0),
  external(count: 0);

  const HyperLinks({required this.count});

  final int count;
}
