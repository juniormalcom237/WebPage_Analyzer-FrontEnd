part of 'parser_bloc.dart';

@immutable
abstract class ParserEvent {}

class FetchInfo extends ParserEvent {
  String url;
  FetchInfo({required this.url});
}
