import 'package:presisawit_app/common/utils/data_response.dart';
import 'package:presisawit_app/data/models/company_detail_response.dart';
import 'package:presisawit_app/data/models/company_validate.dart';
import 'package:presisawit_app/data/models/field_response.dart';
import 'package:presisawit_app/domain/entities/login.dart';
import 'package:presisawit_app/domain/entities/register.dart';

abstract class FirebaseRepository {
  Future<DataState<CompanyValidateResponse?>> validateCompanyData(
      String companyId);
  Future<DataState<CompanyDetailResponse>> getCompanyDetails(String companyId);
  Future<DataState> registerUser(Register user);
  Future<DataState> loginUser(Login user);
  Future<bool> isLoggedIn();
  Future<DataState> getSavedCredentials();
  Future<DataState<List<FieldResponse>>> getListOfFields(String companyId);
}
