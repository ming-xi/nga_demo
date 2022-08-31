import 'package:common/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Post {
  String text;
  List<String>? images;
  List<Comment>? comments;
  int likeCount;
  int commentCount;
  int shareCount;
  User author;

  Post({
    required this.text,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.author,
    this.images,
    this.comments,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Comment {
  String text;
  String date;
  List<Comment>? subComments;
  int likeCount;
  int commentCount;
  int shareCount;
  User author;

  Comment({
    required this.text,
    required this.date,
    required this.author,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    this.subComments,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
