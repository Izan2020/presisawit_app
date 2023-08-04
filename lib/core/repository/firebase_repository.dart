import 'package:presisawit_app/core/models/company_response.dart';
import 'package:presisawit_app/core/models/register_response.dart';

abstract class FirebaseRepository {
  Future<DataState<CompanyValidate?>> getCompanyData(String companyId);
}
