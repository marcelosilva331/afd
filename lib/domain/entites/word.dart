import 'package:equatable/equatable.dart';

class Word extends Equatable {
  final int? id;
  final String text;
  final String meaning;

  const Word({this.id, required this.text, required this.meaning});

  bool notEmpty() {
    return text.isNotEmpty;
  }

  @override
  List<Object?> get props => [text];
}
