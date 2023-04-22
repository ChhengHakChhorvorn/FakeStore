import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  @JsonKey(name: 'id')
  final int? id;

  @JsonKey(name: 'email')
  final String? email;

  @JsonKey(name: 'username')
  final String? userName;

  @JsonKey(name: 'password')
  final String? password;

  @JsonKey(name: 'phone')
  final String? phone;

  UserResponse({this.id, this.email, this.userName, this.password, this.phone});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
