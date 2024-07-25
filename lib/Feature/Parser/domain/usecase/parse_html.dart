import 'package:fpdart/fpdart.dart';
import 'package:web_page_analyzer/Feature/Parser/domain/entities/HtmlParse.dart';
import 'package:web_page_analyzer/Feature/Parser/domain/repository/Parser_repository.dart';

import '../../../../Core/Error/failure.dart';
import '../../../../Core/Usecase/usecase.dart';

class ParseHtmlUsecase implements UseCase<HtmlParse, ParsedHtmlParams> {
  final ParserRepository parserRepository;

  ParseHtmlUsecase(this.parserRepository);
  @override
  Future<Either<Failure, HtmlParse>> call(ParsedHtmlParams params) async {
    return await parserRepository.getParsedHtml(url: params.url);
  }
}

class ParsedHtmlParams {
  final String url;

  ParsedHtmlParams({required this.url});
}
