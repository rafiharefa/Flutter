import 'package:contacts/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'pages/home_page.dart';

Future main() async {

  //connecting app to firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Museo',
        splashColor: Color.fromRGBO(35, 34, 39, 100),
        inputDecorationTheme: InputDecorationTheme(labelStyle: TextStyle(color: Colors.white)),
      ),

      //initiate pages route
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/user': (context) => UserPage(),

      },
    );
  }
}
