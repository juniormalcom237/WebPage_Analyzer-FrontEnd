part of 'parser_bloc.dart';

@immutable
abstract class ParserState {}

class ParserInitial extends ParserState {}

class ParserLoading extends ParserState {}

class ParserDisplay extends ParserState {
  HtmlParse htmlModel;
  ParserDisplay(this.htmlModel);
}

class ParserError extends ParserState {
  String error;
  ParserError({required this.error});
}
