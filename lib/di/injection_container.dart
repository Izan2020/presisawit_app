import 'package:get_it/get_it.dart';
import 'package:presisawit_app/core/providers/auth_provider.dart';
import 'package:presisawit_app/core/api/firebase_repository.dart';
import 'package:presisawit_app/core/providers/company_provider.dart';
import 'package:presisawit_app/core/providers/fields_provider.dart';

import 'package:presisawit_app/core/services/firebase_repository_impl.dart';

import 'package:presisawit_app/routes/router_delegate.dart';

final inject = GetIt.instance;

Future<void> initializeDependencies() async {
  // Repositories
  inject.registerSingleton<FirebaseRepository>(FirebaseRepositoryImpl());

  // Router Delegate
  inject.registerSingleton(MyRouterDelegate(inject()));

  // View Models
  inject.registerFactory(() => AuthProvider(firebaseRepository: inject()));
  inject.registerFactory(() => CompanyProvider(firebaseRepository: inject()));
  inject.registerFactory(() => FieldsProvider(firebaseRepository: inject()));
}
