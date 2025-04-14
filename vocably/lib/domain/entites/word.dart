import 'package:equatable/equatable.dart';

class Word extends Equatable {
  final String text;

  const Word({required this.text});

  bool notEmpty() {
    return text.isNotEmpty;
  }

  @override
  List<Object?> get props => [text];
}
