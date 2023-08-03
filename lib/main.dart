import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:presisawit_app/core/providers/auth_provider.dart';
import 'package:presisawit_app/core/services/auth_repository.dart';
import 'package:presisawit_app/core/services/firebase_repository.dart';
import 'package:presisawit_app/firebase_options.dart';
import 'package:presisawit_app/routes/router_delegate.dart';
import 'package:provider/provider.dart';

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
  late AuthProvider _authProvider;

  @override
  void initState() {
    final AuthRepository authRepository = AuthRepository();
    final FirebaseRepository firebaseRepository = FirebaseRepository();
    _myRouterDelegate = MyRouterDelegate(authRepository);
    _authProvider = AuthProvider(firebaseRepository, authRepository);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Presisawit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => _authProvider)
      ], child: Router(routerDelegate: _myRouterDelegate)),
    );
  }
}
