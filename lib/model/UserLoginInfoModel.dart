import "package:flutter/foundation.dart";

class UserLoginInfo {
  UserLoginInfo(this.accessToken, this.refreshToken, this.email);

  String? accessToken;
  String? refreshToken;
  String? email;
}

class UserLoginInfoModel extends ChangeNotifier {
  UserLoginInfo? info;

  void successLogin(UserLoginInfo? loginInfo) {
    info = loginInfo;
    notifyListeners();
  }
}
