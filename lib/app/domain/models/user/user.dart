import 'package:freezed_annotation/freezed_annotation.dart';

import '../../typedefs.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String username,

    ///
    @JsonKey(
      name: 'avatar',
      fromJson: avatarPathFromJson,
    )
    String? avatar,
  }) = _User;
  const User._();

  factory User.fromJson(Json json) => _$UserFromJson(json);

  String getCustomFunction() {
    return '$username $id';
  }
}

String? avatarPathFromJson(Json json) {
  return json['tmdb']?['avatar_path'] as String?;
}
