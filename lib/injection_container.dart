import 'package:get_it/get_it.dart';
import 'package:presisawit_app/data/datasources/remote_datasource.dart';

import 'package:presisawit_app/data/repository/firebase_repository_impl.dart';
import 'package:presisawit_app/domain/repository/repository.dart';

final inject = GetIt.instance;

Future<void> initializeDependencies() async {
  // Datasources
  inject.registerLazySingleton(() => RemoteDataSourceImpl(
        firebaseAuth: inject(),
        firestore: inject(),
      ));

  // Repositories
  inject.registerSingleton<FirebaseRepository>(
    FirebaseRepositoryImpl(
      remoteDataSource: inject(),
    ),
  );

  // Usecases

  // View Models
}
