import 'package:devflubase/screens/home_page.dart';
import 'package:devflubase/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:devflubase/screens/login_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: Provider.of<AuthService>(context).getUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.error != null) {
              print("Ini error");
              return Text(snapshot.error.toString());
            }
            return snapshot.hasData
                ? HomePage(currentUser: snapshot.data)
                : LoginPage();
          } else {
            return Center(
              child: Container(
                child: CircularProgressIndicator(),
                alignment: Alignment(0.0, 0.0),
              ),
            );
          }
        },
      ),
    );
  }
}
