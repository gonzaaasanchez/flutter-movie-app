import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

// to generate .g model: flutter pub run build_runner build

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.id,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  final String username;

  @override
  List<Object?> get props => [
        id,
        username,
      ];

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
