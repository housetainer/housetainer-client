import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:housetainer/model/UserLoginInfoModel.dart';
import 'package:housetainer/scene/login/LoginPage.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(const MyApp());
  runApp(ChangeNotifierProvider(
      create: ((context) => UserLoginInfoModel()),
      child: Consumer<UserLoginInfoModel>(builder: (context, loginInfo, child) {
        if (loginInfo.info == null) {
          return const LoginPage();
        }
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
                    title: const Text('메인', textAlign: TextAlign.left)),
                body: const Center(
                  child: Text("MainView"),
                )));
      })));
}
