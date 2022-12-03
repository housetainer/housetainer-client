import 'dart:convert';
import 'package:housetainer/model/network/NetworkInfo.dart';
import 'package:http/http.dart' as http;
import 'package:housetainer/model/login/entity/SignUpRequest.dart';
import 'package:housetainer/model/login/entity/SignUpResponse.dart';
import 'package:housetainer/util/Tuple.dart';

class LoginService {
  final String _signUp = "$baseURL/sign/up";
  final String _signIn = "$baseURL/sign/in";

  Future<Tuple<SignUpResponse, String>> signUp(SignUpRequest request) async {
    print(request.toString());
    final response = await http.post(Uri.parse(_signUp), headers: baseHeaders, body: jsonEncode(request.toString()));

    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final data = SignUpResponse.fromJson(jsonDecode(response.body));
      final header = response.headers["tokenName"].toString();
      return Tuple<SignUpResponse, String>(item1: data, item2: header);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}