import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:presisawit_app/common/utils/data_response.dart';
import 'package:presisawit_app/data/datasources/remote_datasource.dart';
import 'package:presisawit_app/data/models/company_detail_response.dart';
import 'package:presisawit_app/data/models/company_validate.dart';
import 'package:presisawit_app/data/models/field_response.dart';
import 'package:presisawit_app/domain/entities/login.dart';
import 'package:presisawit_app/domain/entities/register.dart';
import 'package:presisawit_app/domain/repository/repository.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final RemoteDataSource remoteDataSource;
  FirebaseRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DataState<CompanyDetailResponse>> getCompanyDetails(
      String companyId) async {
    try {
      final result = await remoteDataSource.getCompanyDetails(companyId);
      return DataSuccess(result);
    } on FirebaseException {
      return const DataError('Terjadi Kesalahan Server');
    } on SocketException {
      return const DataError('Periksa Internet Anda');
    }
  }

  @override
  Future<DataState<List<FieldResponse>>> getListOfFields(
      String companyId) async {
    try {
      final result = await remoteDataSource.getListOfFields(companyId);
      return DataSuccess(result);
    } on FirebaseException {
      return const DataError('Terjadi Kesalahan Server');
    } on SocketException {
      return const DataError('Periksa Internet Anda');
    }
  }

  @override
  Future<DataState> getSavedCredentials() {
    // TODO: implement getSavedCredentials
    throw UnimplementedError();
  }

  @override
  Future<bool> isLoggedIn() async {
    final result = await remoteDataSource.isLoggedIn();
    return result;
  }

  @override
  Future<DataState> loginUser(Login user) async {
    try {
      final result = await remoteDataSource.loginUser(user);
      return DataSuccess(result);
    } on FirebaseAuthException catch (e) {
      return DataError(e.message);
    } on SocketException {
      return const DataError('Periksa Internet Anda');
    }
  }

  @override
  Future<DataState> registerUser(Register user) async {
    try {
      final result = await remoteDataSource.registerUser(user);
      return DataSuccess(result);
    } on FirebaseException {
      return const DataError('Terjadi Kesalahan Server');
    } on SocketException {
      return const DataError('Periksa Internet Anda');
    }
  }

  @override
  Future<DataState<CompanyValidateResponse?>> validateCompanyData(
      String companyId) {
    // TODO: implement validateCompanyData
    throw UnimplementedError();
  }
}
