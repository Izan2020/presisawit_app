import 'package:presisawit_app/common/utils/data_response.dart';

DataError authErrors(String code) {
  switch (code) {
    case "user-not-found":
      return const DataError('Pengguna tidak Terdaftar');
    case "wrong-password":
      return const DataError('Password salah!');
    case "invalid-email":
      return const DataError('Isi Format Email dengan Benar!');
    case 'weak-password':
      throw const DataError('Password terlalu Lemah');
    case 'email-already-in-use':
      throw const DataError('Email telah terdaftar');
    default:
      return const DataError('Unknown Error Occured');
  }
}
