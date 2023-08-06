class LoginCredentials {
  String email = "";
  String password = "";

  LoginCredentials({
    required this.email,
    required this.password,
  });

  String? validateCredentials() {
    if (email == "") {
      return "Isi Email anda";
    }
    if (password == "") {
      return "Isi password anda";
    }
    return null;
  }
}
