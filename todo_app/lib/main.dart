import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/screens/login.dart';
import 'package:todo_app/services/auth.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: FutureBuilder(
        // Initialize FlutterFire
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text("error"),
              ),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            //final String uid = Auth()?.uid;
            return Root();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return const Scaffold(
            body: Center(
              child: Text("loading"),
            ),
          );
        },
      ),
    );
  }
}

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth(auth: auth).user,
      builder: (_, AsyncSnapshot<User> user) {
        if (user.connectionState == ConnectionState.active) {
          if (user.data?.uid == null) {
            return Login(
              auth: auth,
              firestore: firestore,
            );
          } else {
            return Home(
              auth: auth,
              firestore: firestore,
            );
          }
        } else {
          return const Scaffold(
            body: Center(
              child: Text("loading..."),
            ),
          );
        }
      },
    );
  }
}
