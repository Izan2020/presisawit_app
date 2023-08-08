import 'package:presisawit_app/core/classes/models/company_details.dart';
import 'package:presisawit_app/core/classes/models/company_validate.dart';
import 'package:presisawit_app/core/classes/logic/data_response.dart';
import 'package:presisawit_app/core/classes/models/field.dart';

import '../classes/login_credentials.dart';
import '../classes/register_credentials.dart';

abstract class FirebaseRepository {
  Future<DataState<CompanyValidate?>> validateCompanyData(String companyId);
  Future<DataState<CompanyDetail>> getCompanyDetails(String companyId);

  Future<DataState> registerUser(RegisterCredentials user);
  Future<DataState> loginUser(LoginCredentials user);
  Future<bool> isLoggedIn();
  Future<DataState> getSavedCredentials();

  Future<DataState<List<Field>>> getListOfFields(String companyId);
}
