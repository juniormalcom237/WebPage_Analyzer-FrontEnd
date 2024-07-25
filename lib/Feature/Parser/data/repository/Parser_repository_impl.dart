import 'package:fpdart/src/either.dart';
import 'package:web_page_analyzer/Core/Error/failure.dart';
import 'package:web_page_analyzer/Feature/Parser/domain/entities/HtmlParse.dart';

import '../../../../Core/Error/exception.dart';
import '../../domain/repository/Parser_repository.dart';
import '../datasources/parser_remote_data_source.dart';

class ParserRepositoryImpl implements ParserRepository {
  ParserRemoteDataSource parserRemoteDataSource;

  ParserRepositoryImpl(this.parserRemoteDataSource);
  @override
  Future<Either<Failure, HtmlParse>> getParsedHtml(
      {required String url}) async {
    try {
      final parseData =
          await parserRemoteDataSource.getParsedData(urlString: url);
      return right(parseData);
    } on ServerException catch (e) {
      print("printer ${e.message}");
      return left(Failure(e.message));
    }
  }
}
