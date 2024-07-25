import 'package:fpdart/fpdart.dart';
import 'package:web_page_analyzer/Core/Error/failure.dart';

import '../entities/HtmlParse.dart';

abstract interface class ParserRepository {
  Future<Either<Failure, HtmlParse>> getParsedHtml({required String url});
}
