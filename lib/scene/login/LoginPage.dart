import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:housetainer/model/UserLoginInfoModel.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              backgroundColor: Colors.transparent,
              bottomOpacity: 0.0,
              elevation: 0.0,
              foregroundColor: Colors.black,
              centerTitle: false,
              title: const Text('로그인', textAlign: TextAlign.left)),
          body: const LoginWidget(title: 'Flutter Demo Home Page'),
        ));
  }
}

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key, required this.title});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  // Get battery level.
  static const platform = MethodChannel('auth.social/naver');
  String _authResult = 'Unknown';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  late User currentUser;
  String name = "";
  String email = "";

  Future<void> _authNaver(UserLoginInfoModel loginProvider) async {
    String authResult;
    try {
      loginProvider.successLogin(UserLoginInfo("111", "111", "1111"));
    } on PlatformException catch (e) {
      return;
    }
  }

  Future<void> authGoogle(UserLoginInfoModel loginProvider) async {
    var info = await _authGoogle();
    loginProvider.successLogin(info);
  }

  Future<UserLoginInfo?> _authGoogle() async {
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      final GoogleSignInAuthentication authentication =
          await account!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken);

      final UserCredential authenticationResult =
          await _auth.signInWithCredential(credential);
      if (authenticationResult.user != null) {
        currentUser = authenticationResult.user!;
        return UserLoginInfo(
            authentication.accessToken, null, currentUser.email);
      } else {
        return null;
      }
    } on PlatformException catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider =
        Provider.of<UserLoginInfoModel>(context, listen: false);

    return Material(
      child: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(),
              Column(
                children: [
                  GestureDetector(
                    onTap: () async =>
                        _authNaver(loginProvider), // Image tapped
                    child: Image.asset(
                      'assets/loginButton/login-naver.png',
                      fit: BoxFit.cover, // Fixes border issues
                      // width: 110.0,
                      // height: 110.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async =>
                        await authGoogle(loginProvider), // Image tapped
                    child: Image.asset(
                      'assets/loginButton/login-kakao.png',
                      fit: BoxFit.cover, // Fixes border issues
                      // width: 110.0,
                      // height: 110.0,
                    ),
                  )
                ],
              ),
              const Spacer(),
              Text(_authResult),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}