import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rainbow_wings/provider/auth_provider.dart';
import 'package:rainbow_wings/routes/routes.dart';
import 'package:rainbow_wings/routes/routes.gr.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      // options: const FirebaseOptions(
      //     apiKey: "AIzaSyDf8TZKitOucOaQ9kE6RKn3hJRSIaPjkLg",
      //     authDomain: "rainbow-wings.firebaseapp.com",
      //     projectId: "rainbow-wings",
      //     storageBucket: "rainbow-wings.appspot.com",
      //     messagingSenderId: "716076978299",
      //     appId: "1:716076978299:web:826257b41ce4d2e177d2de"),
      );

  // Firebase.initializeApp();

  await _connectToFirebaseEmulator();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

Future _connectToFirebaseEmulator() async {
  final localHostString = Platform.isAndroid ? '10.0.2.2' : 'localhost';

  FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);

  // ignore: deprecated_member_use
  await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
}

final routesProvider = Provider((ref) => AppRouter(authGuard: AuthGuard()));

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    final _routes = ref.watch(routesProvider);

    return MaterialApp.router(
      title: 'Wings',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      routeInformationParser: _routes.defaultRouteParser(),
      routerDelegate: _routes.delegate(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    // final _auth = ref.watch(authProvider);
    return Scaffold(
        body: Text(
      'Home',
      style: TextStyle(
        color: Colors.black,
        fontSize: 50,
      ),
    ));
  }
}
