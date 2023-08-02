import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:presisawit_app/core/services/auth_repository.dart';
import 'package:presisawit_app/firebase_options.dart';
import 'package:presisawit_app/routes/router_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late MyRouterDelegate _myRouterDelegate;

  @override
  void initState() {
    final AuthRepository authRepository = AuthRepository();
    _myRouterDelegate = MyRouterDelegate(authRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Router(routerDelegate: _myRouterDelegate),
    );
  }
}
