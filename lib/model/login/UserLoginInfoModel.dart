// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import "package:flutter/foundation.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:housetainer/model/login/LoginService.dart';
import 'package:housetainer/model/login/entity/SignUpRequest.dart';
import 'package:housetainer/util/JWTParser.dart';

class UserLoginInfo {
  String? socialAuthId;
  String? socialAccessToken;
  String? socialRefreshToken;
  String? houstainerUserId;
  String? houstainerToken;
  UserLoginInfo(
    this.socialAuthId,
    this.socialAccessToken,
    this.socialRefreshToken,
    this.houstainerUserId,
    this.houstainerToken,
  );
}

class UserLoginModel extends ChangeNotifier {
  UserLoginInfo? info;
  // loginService
  final loginService = LoginService();

  // google
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  // naver
  final _naverAuthChannel = const MethodChannel('auth.social/naver');

  void _successLogin(UserLoginInfo? loginInfo) {
    info = loginInfo;
    notifyListeners();
  }

  Future<void> authNaver() async {
    try {
      // 전달받을 데이터를 dict로 던질 수 있는지, string으로 대충 던져서 받을지
      final accessToken = await _naverAuthChannel.invokeMethod("authNaver");
      // _successLogin(UserLoginInfo(accessToken, null, null));
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
        
        final jwtDict = parseJwtPayLoad(await currentUser.getIdToken());
        final authId = jwtDict['sub'];
        final request = SignUpRequest(email: currentUser.email!, authId: authId, authProvider: "GOOGLE", name: "정하민", nickname: currentUser.displayName!, gender: "FEMALE", birthday: "", phoneNumber: "010-9465-9404", profileImage: currentUser.photoURL!, countryCode: "082", languageCode: "ko-KR");
        
        final result = await loginService.signUp(request);
        _successLogin(UserLoginInfo(result.item1.authId, authentication.accessToken, currentUser.refreshToken, result.item1.userId, result.item2));
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