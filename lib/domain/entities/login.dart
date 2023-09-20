class Login {
  String email = "";
  String password = "";

  Login({
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
