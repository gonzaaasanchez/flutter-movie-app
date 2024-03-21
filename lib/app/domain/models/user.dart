import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.id,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

/// 
/// @JsonKey('userId') to keep model property & override parse key  
  final int id;
  final String username;

  @override
  List<Object?> get props => [
        id,
        username,
      ];

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
