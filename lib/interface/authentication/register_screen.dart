import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:presisawit_app/interface/constants/app_colors.dart';
import 'package:presisawit_app/interface/widgets/buttons.dart';
import 'package:presisawit_app/interface/widgets/textfields.dart';

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
  int registerSteps = 0;

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

  @override
  Widget build(BuildContext context) {
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
        body: registerSteps == 0
            ? CompanyPage(
                companyIdController: _companyIdController,
                onTapNext: () {
                  if (_companyIdController.text != "") {
                    _nextStep();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Isi ID Perusahaan Anda.')));
                  }
                })
            : registerSteps == 1
                ? ProfilePage(
                    usernameController: _usernameController,
                    addressController: _addressController,
                    onTapNext: () {
                      if (_usernameController.text != "") {
                        _nextStep();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Isi Username')));
                      }
                    },
                  )
                : registerSteps == 2
                    ? KtpPage(
                        ktpController: _ktpController,
                        onTapNext: () {
                          if (_ktpController.text != "") {
                            _nextStep();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Isi Nomor KTP anda ')));
                          }
                        },
                      )
                    : registerSteps == 3
                        ? EmailPhoneNumberPage(
                            emailController: _emailController,
                            phoneNumberController: _phoneNumberController,
                            onTapNext: () {
                              if (_emailController.text != "") {
                                _nextStep();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Isi Email anda!')));
                              }
                            },
                          )
                        : registerSteps == 4
                            ? PasswordPage(
                                passwordController: _passwordController,
                                onTapNext: () {
                                  if (_ktpController.text != "") {
                                    _nextStep();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Isi Password Anda')));
                                  }
                                },
                              )
                            : null);
  }
}

class CompanyPage extends HookWidget {
  final TextEditingController companyIdController;
  final Function onTapNext;
  const CompanyPage(
      {super.key, required this.companyIdController, required this.onTapNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryTextField(
            controller: companyIdController,
            hintText: 'Isi ID Perusahaan Anda'),
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
            controller: usernameController, hintText: 'Isi nama Anda'),
        PrimaryTextField(
            controller: usernameController, hintText: 'Isi alamat Anda'),
        PrimaryButton(text: 'Selanjutnya', onTap: () => onTapNext())
      ],
    );
  }
}

class EmailPhoneNumberPage extends HookWidget {
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final Function onTapNext;
  const EmailPhoneNumberPage(
      {required this.emailController,
      required this.phoneNumberController,
      required this.onTapNext,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryTextField(controller: emailController, hintText: 'Email'),
        PrimaryTextField(
            controller: phoneNumberController, hintText: 'Phone Number'),
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
        PrimaryTextField(controller: ktpController, hintText: 'Nomor Ktp'),
        PrimaryButton(text: 'Selanjutnya', onTap: () => onTapNext())
      ],
    );
  }
}

class PasswordPage extends HookWidget {
  final TextEditingController passwordController;
  final Function onTapNext;
  const PasswordPage(
      {super.key, required this.passwordController, required this.onTapNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryTextField(controller: passwordController, hintText: 'Password'),
        PrimaryButton(text: 'Selanjutnya', onTap: () => onTapNext())
      ],
    );
  }
}
