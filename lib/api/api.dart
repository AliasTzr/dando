import 'dart:convert';

import 'package:http/http.dart';
import 'package:projet0_strat/Models/Server/server_response.dart';


class Api {
  // final String ip = "http://dandoappapi.xyz/api";
  Future<String> useCode(String code) async {
    try {
      Response response = await post(
        Uri.http("dandoappapi.xyz" ,"/api/use-code"),
        body: {'code': code}
      );
      if (response.statusCode != 200) {
        return Future.error(ServerResponse.fromJson(jsonDecode(response.body)).message);
      } else {
        return ServerResponse.fromJson(jsonDecode(response.body)).message;
      }
    } catch (e) {
      return Future.error(ServerResponse.fromJson({"message": e.toString(), "status": 404}).message);
    }
  }
}