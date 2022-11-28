import "package:flutter/foundation.dart";
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class UserLoginInfo {
  UserLoginInfo(this.accessToken, this.refreshToken, this.email);

  String? accessToken;
  String? refreshToken;
  String? email;
}

class UserLoginInfoModel extends ChangeNotifier {
  UserLoginInfo? info;

  // google
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _naverAuthChannel = MethodChannel('auth.social/naver');

  void _successLogin(UserLoginInfo? loginInfo) {
    info = loginInfo;
    notifyListeners();
  }

  Future<void> authNaver() async {
    try {
      // 전달받을 데이터를 dict로 던질 수 있는지, string으로 대충 던져서 받을지
      final accessToken = await _naverAuthChannel.invokeMethod("authNaver");
      _successLogin(UserLoginInfo(accessToken, null, null));
    } on PlatformException catch (e) {
      return;
    }
  } 

  Future<void> authGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      final GoogleSignInAuthentication authentication =
          await account!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);

      final UserCredential authenticationResult =
          await _auth.signInWithCredential(credential);
      if (authenticationResult.user != null) {
        User currentUser = authenticationResult.user!;
        // 이메일 분기??
        _successLogin(UserLoginInfo(authentication.accessToken, authentication.idToken, currentUser.email!));
      } else {
        // fail
        return;
      }
    } on PlatformException catch (e) {
      // fail
      return;
    }
  }
}
