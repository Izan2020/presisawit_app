import 'package:flutter/material.dart';
import 'package:presisawit_app/core/constants/enum.dart';
import 'package:presisawit_app/core/constants/value_keys.dart';

import 'package:presisawit_app/interface/authentication/auth_screen.dart';
import 'package:presisawit_app/interface/authentication/login_screen.dart';
import 'package:presisawit_app/interface/authentication/register_screen.dart';
import 'package:presisawit_app/interface/authentication/reset_password_screen.dart';
import 'package:presisawit_app/interface/screens/home_screen.dart';
import 'package:presisawit_app/interface/screens/splash_screen.dart';

import '../core/api/auth_repository.dart';

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
  bool isResetPassword = false;

  // Logged in Stacks

  @override
  Widget build(BuildContext context) {
    _authorization();
    return Navigator(
      key: _navigatorKey,
      pages: _historyStack,
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) {
          return false;
        }

        isRegister ? _setRegister(false) : null;
        isLogin ? _setLogin(false) : null;
        isResetPassword ? {_setResetPassword(false), _setLogin(true)} : null;

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
              key: registerScreenKey,
              child: RegisterScreen(
                onPop: () => _setRegister(false),
                onRegister: () => {
                  _setRegister(false),
                  Future.delayed(const Duration(milliseconds: 600)),
                  _setAuthState(CurrentAuth.success)
                },
              )),
        if (isLogin)
          MaterialPage(
              key: loginScreenKey,
              child: LoginScreen(
                onLogin: () {
                  _setLogin(false);
                  Future.delayed(const Duration(milliseconds: 600));
                  _setAuthState(CurrentAuth.success);
                },
                onForgotPassword: () => _setResetPassword(true),
              )),
        if (isResetPassword)
          const MaterialPage(
            key: resetPasswordScreenKey,
            child: ResetPasswordScreen(),
          )
      ];

  List<Page> get _loggedInStack =>
      [const MaterialPage(key: homeScreenScreenKey, child: HomeScreen())];

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

  _setResetPassword(bool value) {
    isResetPassword = value;
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
