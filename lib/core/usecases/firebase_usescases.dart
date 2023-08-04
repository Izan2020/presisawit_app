import 'package:presisawit_app/core/models/company_response.dart';
import 'package:presisawit_app/core/models/register_response.dart';
import 'package:presisawit_app/core/repository/firebase_repository.dart';

class FirebaseUsecases {
  final FirebaseRepository _firebaseRepository;
  FirebaseUsecases(this._firebaseRepository);

  Future<DataState<CompanyValidate?>> validateCompanyId(String companyId) =>
      _firebaseRepository.getCompanyData(companyId);
}
