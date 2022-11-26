import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          body: const MyHomePage(title: 'Flutter Demo Home Page'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Get battery level.
  static const platform = MethodChannel('auth.social/naver');
  String _authResult = 'Unknown';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  late User currentUser;
  String name = "";
  String email = "";

  Future<void> _authNaver() async {
    String authResult;
    try {
      final String result = await platform.invokeMethod('authNaver');
      authResult = result;
    } on PlatformException catch (e) {
      authResult = "Failed to Auth By Naver: '${e.message}'.";
    }

    setState(() {
      _authResult = authResult;
    });
  }

  Future<void> _authGoogle() async {
    String authResult;
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      final GoogleSignInAuthentication authentication = await account!.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken
          );

      final UserCredential authenticationResult =
          await _auth.signInWithCredential(credential);
      if (authenticationResult.user != null) {
        currentUser = authenticationResult.user!;
        authResult = currentUser.email!;
      } else {
        authResult = "Failed to Auth By Google: Empty User.";  
      }
    } on PlatformException catch (e) {
      authResult = "Failed to Auth By Google: '${e.message}'.";
    }

    setState(() {
      _authResult = authResult;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    onTap: _authNaver, // Image tapped
                    child: Image.asset(
                      'assets/loginButton/login-naver.png',
                      fit: BoxFit.cover, // Fixes border issues
                      // width: 110.0,
                      // height: 110.0,
                    ),
                  ),
                  GestureDetector(
                    onTap: _authGoogle, // Image tapped
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
