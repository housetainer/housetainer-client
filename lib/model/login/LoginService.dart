import 'dart:convert';

import 'package:housetainer/model/network/NetworkInfo.dart';
import 'package:http/http.dart' as http;

class LoginService {
  final String _signUp = "$baseURL/sign/up";
  final String _signIn = "$baseURL/sign/in";

  Future<SignUpResponse> signUp(SignUpRequest request) async {
    final response = await http.post(Uri.parse(_signUp), headers: baseHeaders, body: jsonEncode(request.toJson()));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      final data = SignUpResponse.fromJson(jsonDecode(response.body));
      return data;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

class SignUpRequest {
  SignUpRequest(this.email, this.authId, this.authProvider, this.name, this.nickname, this.gender, this.birthday, this.phoneNumber, this.profileImage, this.countryCode, this.languageCode);

  late String email;
  late String authId;
  late String authProvider;
  late String name;
  late String nickname;
  late String gender;
  late String birthday;
  late String phoneNumber;
  late String profileImage;
  late String countryCode;
  late String languageCode;

  SignUpRequest.fromJson(Map<String, dynamic> json)
  : email = json['email'],
  authId = json['authId'],
  authProvider = json['authProvider'],
  name = json['name'],
  nickname = json['nickname'],
  gender = json['gender'],
  birthday = json['birthday'],
  phoneNumber = json['phoneNumber'],
  profileImage = json['profileImage'],
  countryCode = json['countryCode'],
  languageCode = json['languageCode'];

  Map<String, dynamic> toJson() => {
  "email": email,
  "authId": authId,
  "authProvider": authProvider,
  "name": name,
  "nickname": nickname,
  "gender": gender,
  "birthday": birthday,
  "phoneNumber": phoneNumber,
  "profileImage": profileImage,
  "countryCode": countryCode,
  "languageCode": languageCode
};
}

class SignUpResponse {
  late String email;
  late String authId;
  late String authProvider;
  late String name;
  late String? nickname;
  late String? gender;
  late String? birthday;
  late String? phoneNumber;
  late String? profileImage;
  late String? countryCode;
  late String? languageCode;
  late String? userId;
  late String? type;
  late String? status;
  late int? createTime;
  late int? updateTime;

  SignUpResponse.fromJson(Map<String, dynamic> json)
  : email = json['email'],
  authId = json['authId'],
  authProvider = json['authProvider'],
  name = json['name'],
  nickname = json['nickname'],
  gender = json['gender'],
  birthday = json['birthday'],
  phoneNumber = json['phoneNumber'],
  profileImage = json['profileImage'],
  countryCode = json['countryCode'],
  languageCode = json['languageCode'],
  userId = json['userId'],
  type = json['type'],
  status = json['status'],
  createTime = json['createTime'],
  updateTime = json['updateTime'];

  Map<String, dynamic> toJson() => {
  "email": email,
  "authId": authId,
  "authProvider": authProvider,
  "name": name,
  "nickname": nickname,
  "gender": gender,
  "birthday": birthday,
  "phoneNumber": phoneNumber,
  "profileImage": profileImage,
  "countryCode": countryCode,
  "languageCode": languageCode,
  "userId" : userId,
  "type" : type,
  "status" : status,
  "createTime" : createTime,
  "updateTime" : updateTime
};
}