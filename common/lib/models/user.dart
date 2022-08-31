import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class User {
  String name;
  String? signature;
  String? avatarUrl;

  User({
    required this.name,
    this.signature,
    this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Community {
  String name;
  String iconUrl;
  int userCount;

  Community({
    required this.name,
    required this.iconUrl,
    required this.userCount,
  });

  factory Community.fromJson(Map<String, dynamic> json) => _$CommunityFromJson(json);

  Map<String, dynamic> toJson() => _$CommunityToJson(this);
}
