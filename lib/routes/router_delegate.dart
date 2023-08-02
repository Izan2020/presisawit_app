import 'package:flutter/material.dart';
import 'package:presisawit_app/core/constants/enum.dart';
import 'package:presisawit_app/core/constants/value_keys.dart';
import 'package:presisawit_app/core/services/auth_repository.dart';
import 'package:presisawit_app/interface/authentication/auth_screen.dart';
import 'package:presisawit_app/interface/authentication/login_screen.dart';
import 'package:presisawit_app/interface/authentication/register_screen.dart';
import 'package:presisawit_app/interface/screens/home_screen.dart';
import 'package:presisawit_app/interface/screens/splash_screen.dart';

class MyRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final AuthRepository authRepository;
  final GlobalKey<NavigatorState> _navigatorKey;
  MyRouterDelegate(this.authRepository)
      : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }

  List<Page> _historyStack = [];

  // Logged out Stacks
  CurrentAuth _currentAuth = CurrentAuth.auth;
  bool isRegister = false;
  bool isLogin = false;

  // Logged in Stacks

  @override
  Widget build(BuildContext context) {
    _authorization();
    return Navigator(
      key: _navigatorKey,
      pages: _historyStack,
      onPopPage: (route, result) {
        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) {
    throw UnimplementedError();
  }

  // O=========================================================================>
  // ? List Of Pages
  // <=========================================================================O

  List<Page> get _splashStack =>
      [const MaterialPage(key: splashScreenKey, child: SplashScreen())];

  List<Page> get _loggedOutStack => [
        if (_currentAuth == CurrentAuth.select)
          MaterialPage(
              key: authScreenKey,
              child: AuthScreen(
                onGotoRegister: () => _setRegister(true),
                onGotoLogin: () => _setLogin(true),
              )),
        if (isRegister)
          MaterialPage(
              key: splashScreenKey,
              child: RegisterScreen(
                onPop: () => _setRegister(false),
                onRegister: () => _setAuthState(CurrentAuth.login),
              )),
        if (isLogin)
          const MaterialPage(key: splashScreenKey, child: LoginScreen()),
      ];

  List<Page> get _loggedInStack =>
      [const MaterialPage(key: splashScreenKey, child: HomeScreen())];

  // O=========================================================================>
  // ? Additional Functions
  // <=========================================================================O

  _setAuthState(CurrentAuth value) {
    _currentAuth = value;
    notifyListeners();
  }

  _setHistoryStack(List<Page> value) {
    _historyStack = value;
  }

  _setRegister(bool value) {
    isRegister = value;
    notifyListeners();
  }

  _setLogin(bool value) {
    isLogin = value;
    notifyListeners();
  }

  // O=========================================================================>
  // ? Other Functions
  // <=========================================================================O

  _init() async {
    bool? authLogin = await authRepository.isLoggedIn();
    if (authLogin) {
      _setAuthState(CurrentAuth.success);
    } else {
      _setAuthState(CurrentAuth.select);
    }
    notifyListeners();
  }

  _authorization() async {
    switch (_currentAuth) {
      case CurrentAuth.auth:
        _setHistoryStack(_splashStack);
        break;
      case CurrentAuth.success:
        _setHistoryStack(_loggedInStack);
        break;
      default:
        _setHistoryStack(_loggedOutStack);
    }
  }
}
