import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.id,
    required this.username,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  final String username;
  @JsonKey(name: 'avatar', fromJson: avatarPathFromJson)
  final String? avatar;

  @override
  List<Object?> get props => [
        id,
        username,
      ];

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

String? avatarPathFromJson(Map<String, dynamic> json) {
  return json['tmdb']?['avatar_path'] as String?;
}
