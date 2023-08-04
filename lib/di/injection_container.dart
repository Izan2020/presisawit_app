import 'package:get_it/get_it.dart';
import 'package:presisawit_app/core/providers/auth_provider.dart';
import 'package:presisawit_app/core/api/firebase_repository.dart';
import 'package:presisawit_app/core/services/firebase_repository_impl.dart';

import 'package:presisawit_app/routes/router_delegate.dart';

import '../core/api/auth_repository.dart';
import '../core/services/auth_repository_impl.dart';

final inject = GetIt.instance;

Future<void> initializeDependencies() async {
  // Repositories
  inject.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  inject.registerSingleton<FirebaseRepository>(FirebaseRepositoryImpl());

  // Router Delegate
  inject.registerSingleton(MyRouterDelegate(inject()));

  // View Models
  inject.registerFactory(() =>
      AuthProvider(authRepository: inject(), firebaseRepository: inject()));
}
