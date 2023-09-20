import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presisawit_app/injection_container.dart';
import 'package:presisawit_app/firebase_options.dart';
import 'package:presisawit_app/presentation/interface/authentication/auth_screen.dart';
import 'package:presisawit_app/presentation/interface/authentication/login_screen.dart';
import 'package:presisawit_app/presentation/interface/authentication/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Presisawit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: GoRouter(
        routes: [
          // Authentication
          GoRoute(
            path: AuthScreen.routePath,
            builder: (context, state) => const AuthScreen(),
          ),
          GoRoute(
            path: LoginScreen.routePath,
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: RegisterScreen.routePath,
            builder: (context, state) => const RegisterScreen(),
          ),

          // Pages
          // Screens
        ],
      ),
    );
  }
}
