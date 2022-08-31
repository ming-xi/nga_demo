import 'package:common/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Question {
  String text;
  int answerCount;
  User author;

  Question({
    required this.text,
    required this.answerCount,
    required this.author,
  });

  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
