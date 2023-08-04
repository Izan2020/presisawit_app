import 'package:presisawit_app/core/classes/models/company_response.dart';
import 'package:presisawit_app/core/classes/logic/data_response.dart';

abstract class FirebaseRepository {
  Future<DataState<CompanyValidate?>> getCompanyData(String companyId);
}
