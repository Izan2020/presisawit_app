import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:presisawit_app/core/constants/enum.dart';
import 'package:presisawit_app/core/classes/register_credentials.dart';
import 'package:presisawit_app/core/providers/auth_provider.dart';
import 'package:presisawit_app/interface/theme/app_colors.dart';
import 'package:presisawit_app/interface/widgets/buttons.dart';
import 'package:presisawit_app/interface/widgets/textfields.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  final Function onPop;
  final Function onRegister;
  const RegisterScreen(
      {super.key, required this.onPop, required this.onRegister});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _ktpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyIdController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String companyResult = "";
  String emailValidity = "";
  bool isObsecurePassword = true;
  bool isObsecureConfirmPassword = true;
  int registerSteps = 0;

  @override
  void dispose() {
    _usernameController.dispose();
    _ktpController.dispose();
    _emailController.dispose();
    _companyIdController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final userCredentials = RegisterCredentials(
        name: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        role: 'karyawan',
        phoneNumber: _phoneNumberController.text,
        profilePicture: '',
        address: _addressController.text,
        aboutMe: '',
        createdAt: '',
        ktpNumber: _ktpController.text,
        companyId: _companyIdController.text);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.loginUserState == ServiceState.loading) return;

    final isSuccess = await authProvider.registerUser(userCredentials);

    if (isSuccess) {
      authProvider.clearAllAuthState();
      widget.onRegister();
    } else {
      scaffoldMessenger.showSnackBar(
          SnackBar(content: Text(authProvider.message ?? "Unknown Error")));
    }
  }

  Future<void> _validateCompanyID(String companyId) async {
    final firebaseProvider = Provider.of<AuthProvider>(context, listen: false);
    bool isAvailable = await firebaseProvider.validateCompanyID(companyId);
    if (isAvailable) {
      final companyName = firebaseProvider.message;
      setState(() {
        companyResult = companyName.toString();
      });
    } else {
      final companyName = firebaseProvider.message;
      setState(() {
        companyResult = companyName.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final validateCompanyState = authProvider.validateCompanyState;
    final registerState = authProvider.registerUserState;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                if (registerSteps == 0) {
                  widget.onPop();
                  return;
                }
                _previousStep();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.black,
              )),
          elevation: 0,
          backgroundColor: AppColors.backgroundColor,
          title: Text(
            _appBarTitle(registerSteps),
            style: const TextStyle(color: AppColors.black),
          ),
        ),
        body: Column(
          children: [
            if (registerSteps == 0)
              CompanyPage(
                  companyResult: validateCompanyState == ServiceState.loading
                      ? 'Validating...'
                      : validateCompanyState == ServiceState.init ||
                              _companyIdController.text == ""
                          ? ""
                          : companyResult,
                  onChangeCompany: (value) => _validateCompanyID(value),
                  companyIdController: _companyIdController,
                  onTapNext: () {
                    final messenger = ScaffoldMessenger.of(context);

                    // Validate if It's Empty
                    if (_companyIdController.text == "") {
                      messenger.showSnackBar(const SnackBar(
                          content: Text('Isi ID Perusahaan Anda.')));
                      return;
                    }
                    // Validate if It's Available in Database
                    if (validateCompanyState == ServiceState.loading) return;
                    if (validateCompanyState == ServiceState.error) {
                      messenger.showSnackBar(SnackBar(
                          content: Text(
                              'Perusahaan dengan ID "${_companyIdController.text}" tidak di temukan')));
                      return;
                    }
                    _nextStep();
                  }),
            if (registerSteps == 1)
              ProfilePage(
                usernameController: _usernameController,
                addressController: _addressController,
                onTapNext: () {
                  // Validate if It's Empty
                  if (_usernameController.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Isi Username')));
                    return;
                  }
                  _nextStep();
                },
              ),
            if (registerSteps == 2)
              KtpPage(
                ktpController: _ktpController,
                onTapNext: () {
                  // Validate if It's Empty
                  if (_ktpController.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Isi Nomor KTP anda ')));
                    return;
                  }
                  _nextStep();
                },
              ),
            if (registerSteps == 3)
              EmailPhoneNumberPage(
                emailResult: emailValidity,
                onChangeEmail: (value) => {},
                emailController: _emailController,
                phoneNumberController: _phoneNumberController,
                onTapNext: () {
                  // Validate if It's Empty
                  if (_emailController.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Isi Email anda!')));
                    return;
                  }
                  if (_phoneNumberController.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Isi Nomor Telfon anda!')));
                    return;
                  }
                  // Validate if It's Valid Email
                  if (!EmailValidator.validate(_emailController.text)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Email tidak valid!')));
                    return;
                  }

                  _nextStep();
                },
              ),
            if (registerSteps == 4)
              PasswordPage(
                registerText: registerState == ServiceState.loading
                    ? "Loading..."
                    : registerState == ServiceState.error
                        ? "Try Again"
                        : "Daftar",
                onTapObsecureConfirmPassword: () =>
                    _toggleObsecureConfirmPassword(),
                onTapObsecurePassword: () => _toggleObsecurePassword(),
                obsecureConfirmPassword: isObsecureConfirmPassword,
                obsecurePassword: isObsecurePassword,
                confirmPasswordController: _confirmPasswordController,
                passwordController: _passwordController,
                onTapNext: () {
                  // Validate if It's Empty
                  if (_passwordController.text == "") {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Isi Password Anda')));
                    return;
                  }
                  // Confirms Password
                  if (_passwordController.text !=
                      _confirmPasswordController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Konfirmasi Password Anda')));
                    return;
                  }

                  _registerUser();
                },
              )
          ],
        ));
  }

  _toggleObsecurePassword() {
    setState(() {
      isObsecurePassword = !isObsecurePassword;
    });
  }

  _toggleObsecureConfirmPassword() {
    setState(() {
      isObsecureConfirmPassword = !isObsecureConfirmPassword;
    });
  }

  _nextStep() {
    setState(() {
      registerSteps = registerSteps + 1;
    });
  }

  _previousStep() {
    setState(() {
      registerSteps = registerSteps - 1;
    });
  }

  String _appBarTitle(int value) {
    switch (value) {
      case 0:
        return "Company ID";
      case 1:
        return "Profile";
      case 2:
        return "NIK";
      case 3:
        return "Email & Phone Number";
      case 4:
        return "Password";
      default:
        return "";
    }
  }
}

class CompanyPage extends HookWidget {
  final TextEditingController companyIdController;
  final Function onTapNext;
  final Function(String) onChangeCompany;
  final String companyResult;
  const CompanyPage({
    super.key,
    required this.companyIdController,
    required this.onTapNext,
    required this.onChangeCompany,
    required this.companyResult,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryTextField(
          onChange: (value) => onChangeCompany(value),
          controller: companyIdController,
          hintText: 'Isi ID Perusahaan Anda',
          size: TextFieldSize.medium,
        ),
        Container(
            margin: const EdgeInsets.only(left: 12, top: 12, bottom: 18),
            child: Text(companyResult)),
        PrimaryButton(text: 'Selanjutnya', onTap: () => onTapNext())
      ],
    );
  }
}

class ProfilePage extends HookWidget {
  final TextEditingController usernameController;
  final TextEditingController addressController;
  final Function onTapNext;
  const ProfilePage(
      {super.key,
      required this.usernameController,
      required this.onTapNext,
      required this.addressController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryTextField(
          controller: usernameController,
          hintText: 'Isi nama Anda',
          size: TextFieldSize.medium,
        ),
        PrimaryTextField(
          controller: addressController,
          hintText: 'Isi alamat Anda',
          size: TextFieldSize.large,
        ),
        PrimaryButton(text: 'Selanjutnya', onTap: () => onTapNext())
      ],
    );
  }
}

class EmailPhoneNumberPage extends HookWidget {
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final String emailResult;
  final Function(String) onChangeEmail;
  final Function onTapNext;
  const EmailPhoneNumberPage(
      {required this.emailController,
      required this.phoneNumberController,
      required this.onTapNext,
      required this.onChangeEmail,
      required this.emailResult,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryTextField(
          onChange: (value) {},
          controller: emailController,
          hintText: 'Email',
          size: TextFieldSize.medium,
        ),
        Container(
            margin: const EdgeInsets.only(left: 12), child: Text(emailResult)),
        PrimaryTextField(
          controller: phoneNumberController,
          hintText: 'Phone Number',
          size: TextFieldSize.medium,
        ),
        PrimaryButton(text: 'Selanjutnya', onTap: () => onTapNext())
      ],
    );
  }
}

class KtpPage extends HookWidget {
  final TextEditingController ktpController;
  final Function onTapNext;
  const KtpPage(
      {required this.ktpController, super.key, required this.onTapNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryTextField(
          controller: ktpController,
          hintText: 'Nomor Ktp',
          size: TextFieldSize.medium,
        ),
        PrimaryButton(text: 'Selanjutnya', onTap: () => onTapNext())
      ],
    );
  }
}

class PasswordPage extends HookWidget {
  final String registerText;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final Function onTapNext;
  final Function onTapObsecurePassword;
  final Function onTapObsecureConfirmPassword;
  final bool obsecurePassword;
  final bool obsecureConfirmPassword;
  const PasswordPage(
      {super.key,
      required this.registerText,
      required this.passwordController,
      required this.onTapNext,
      required this.onTapObsecurePassword,
      required this.onTapObsecureConfirmPassword,
      required this.confirmPasswordController,
      required this.obsecurePassword,
      required this.obsecureConfirmPassword});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryTextField(
          onTapSuffixIcon: () => onTapObsecurePassword(),
          controller: passwordController,
          hintText: 'Password',
          size: TextFieldSize.medium,
          obsecureText: obsecurePassword,
        ),
        PrimaryTextField(
          onTapSuffixIcon: () => onTapObsecureConfirmPassword(),
          controller: confirmPasswordController,
          hintText: 'Confirm Password',
          size: TextFieldSize.medium,
          obsecureText: obsecureConfirmPassword,
        ),
        PrimaryButton(text: registerText, onTap: () => onTapNext())
      ],
    );
  }
}
