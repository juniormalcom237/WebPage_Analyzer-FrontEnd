import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:web_page_analyzer/Feature/Parser/domain/entities/HtmlParse.dart';

import '../../domain/usecase/parse_html.dart';

part 'parser_event.dart';
part 'parser_state.dart';

class ParserBloc extends Bloc<ParserEvent, ParserState> {
  ParseHtmlUsecase _parseHtmlUsecase;
  // ParserBloc()
  ParserBloc({required ParseHtmlUsecase parseHtmlUsecase})
      : _parseHtmlUsecase = parseHtmlUsecase,
        super(ParserInitial()) {
    on<ParserEvent>((event, emit) => emit(ParserLoading()));
    on<FetchInfo>(_onParseHtml);
  }
  void _onParseHtml(FetchInfo event, Emitter<ParserState> emit) async {
    final res = await _parseHtmlUsecase(ParsedHtmlParams(
      url: event.url,
    ));

    res.fold((l) => emit(ParserError(error: l.message)), (r) {
      print(r);
      return emit(ParserDisplay(r));
    });
  }
}
