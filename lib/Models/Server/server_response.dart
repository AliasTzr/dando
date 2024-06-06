import 'package:json_annotation/json_annotation.dart';

part 'server_response.g.dart';

@JsonSerializable()
class ServerResponse {
  final int status;
  final String message;
  ServerResponse({required this.status, required this.message});
  Map<String, dynamic> toJson() => _$ServerResponseToJson(this);

  factory ServerResponse.fromJson(Map<String, dynamic> json) => _$ServerResponseFromJson(json);
}
