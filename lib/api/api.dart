import 'package:get/get_connect.dart';
import 'package:projet0_strat/Models/Server/server_response.dart';

class Api extends GetConnect {
  final String ip = "http://dandoappapi.xyz/api";
  Future<String> useCode(String code) async {
    Response response = await post(
      "$ip/use-code",
      {"code": code},
      headers: <String, String>{
        "Content-Type": "application/json"
      }
    );
    if (response.status.hasError) {
      return Future.error(ServerResponse.fromJson(response.body ?? {"message": "Impossible de joindre le serveur", "status": 404}).message);
    } else {
      return ServerResponse.fromJson(response.body).message;
    }
  }
}