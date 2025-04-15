import 'package:equatable/equatable.dart';

class Word extends Equatable {
  final int? id;
  final String text;

  const Word({this.id, required this.text});

  bool notEmpty() {
    return text.isNotEmpty;
  }

  @override
  List<Object?> get props => [text];
}
