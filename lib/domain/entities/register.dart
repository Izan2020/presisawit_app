class Register {
  String? name;
  String email = "";
  String password = "";
  String? role;
  String? phoneNumber;
  String? profilePicture;
  String? address;
  String? aboutMe;
  String? createdAt;
  String? ktpNumber;
  String? fieldId;
  String? companyId;
  Register({
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    required this.phoneNumber,
    required this.profilePicture,
    required this.address,
    required this.aboutMe,
    required this.createdAt,
    required this.ktpNumber,
    this.fieldId,
    required this.companyId,
  });
}
