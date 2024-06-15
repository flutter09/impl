import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/base_state.dart';
import '../../../config/route/route_manager.dart';
import '../../../config/theme/app_theme.dart';
import '../../../injection_conatainer.dart' as di;
import '../../../utils/utils.dart';
import '../component/component.dart';
import '../component/custom_textfield.dart';
import 'bloc/signup_cubit.dart';
import 'bloc/singin_state.dart';
import 'otp_varification_screen.dart';

class SignUpScreen extends StatelessWidget {
  final _firstNameController = TextEditingController();

  final _lastNameController = TextEditingController();

  final _uniqueNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _mobileController = TextEditingController();
  final imageController = TextEditingController();
  final File? file = null;

  final _formKey = GlobalKey<FormState>();
  final signUpCubit = di.di<SignUpCubit>();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => signUpCubit,
        child: BlocConsumer<SignUpCubit, BaseState>(
          bloc: signUpCubit,
          listener: (context, state) {
            if (state is SignUpState) {
              // print("Login is success");
              Navigator.pushNamed(context, Routes.otpVerificationRoute,
                  arguments: {
                    ArgConstant.eMail: _emailController.text,
                    ArgConstant.otpType: OtpType.registerUser
                  });
            } else if (state is ErrorState) {
              // print(state.errorMessage);
              ScaffoldMessenger.of(context).showSnackBar(getSnackBar(state.errorMessage ?? "error invalid"));
            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/impm_logo.png",
                            width: 200,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Register',
                          style: theme.textTheme.headlineLarge,
                        ).tr(),
                        Text(
                          'Access IMPL using your email and password',
                          style: theme.textTheme.bodyMedium,
                        ).tr(),
                        const SizedBox(
                          height: 30,
                        ),
                        LabelTextField(
                          controller: _uniqueNameController,
                          label: "User name",
                          hintText: "Enter your Username",
                          isRequired: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LabelTextField(
                          controller: _firstNameController,
                          label: "First name",
                          hintText: "Enter your firstname",
                          isRequired: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LabelTextField(
                          controller: _lastNameController,
                          label: "Last name",
                          hintText: "Enter your lastname",
                          isRequired: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LabelTextField(
                            controller: _emailController,
                            label: "Email",
                            hintText: "Enter your email address",
                            type: TextInputType.emailAddress,
                            isRequired: true,
                            validate: (value) {
                              return validateEmail(value);
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        LabelTextField(
                          controller: _passwordController,
                          label: "Password",
                          hintText: "Enter your password",
                          isPassword: true,
                          isRequired: true,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            // return validatePassword(value); //todo password validation
                          },
                          onFieldSubmitted: (value) {
                            // if (_formKey.currentState!.validate()) {}
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LabelTextField(
                          controller: _confirmPasswordController,
                          label: "Confirm Password",
                          hintText: "Re-type your password",
                          isPassword: true,
                          isRequired: true,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            // return validateConfirmPassword(_passwordController.text , value); // todo confirm password validation
                          },
                          onFieldSubmitted: (value) {
                            // if (_formKey.currentState!.validate()) {}
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LabelTextField(
                          controller: _mobileController,
                          label: "Phone",
                          hintText: "Enter your phone number",
                          type: TextInputType.phone,
                          isRequired: true,
                          validate: (value) {
                            return validateMobileNumber(value);
                          },
                          onFieldSubmitted: (value) {
                            // if (_formKey.currentState!.validate()) {}
                          },
                          outsidePrefix:  Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColor.colorGray, width: 0.5),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            alignment: Alignment.center,
                            child: const CountryCodePicker(
                              onChanged: print,
                              initialSelection: 'IN',
                              favorite: ['+91','IN'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: false,
                              showFlag: false,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        /*LabelTextField(
                          label: 'Image',
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'Image must not be Empty !!';
                            }
                            return null;
                          },
                          hintText: "choose file".tr(),
                          onTap: () async {
                            file = await pickImageFromGallery(context);
                            imageController.text = file?.path.split('/').last ?? "No file chosen";
                          },
                          controller: imageController,
                          readOnly: true,
                        ),
                        const SizedBox(height: 20),*/
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              //register a user
                              if (_formKey.currentState!.validate()) {
                                signUpCubit.registerUser(
                                    _firstNameController.text,
                                    _lastNameController.text,
                                    _uniqueNameController.text,
                                    _emailController.text,
                                    _mobileController.text,
                                    _passwordController.text,
                                    file);
                              }
                            },
                            child: const Text(
                              'Sign up',
                            ).tr(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: theme.textTheme.bodyMedium,
                            ),
                            defaultTextButton(
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.colorPrimary),
                              function: () {
                                Navigator.pop(context);
                              },
                              text: 'Login',
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            defaultTextButton(
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w100,
                                  color: AppColor.txtPurple),
                              function: () {
                                Navigator.pushNamed(
                                    context, Routes.signUpRoute);
                              },
                              text: 'Terms & Conditions',
                            ),
                            defaultTextButton(
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w100,
                                  color: AppColor.txtPurple),
                              function: () {
                                Navigator.pushNamed(
                                    context, Routes.signUpRoute);
                              },
                              text: 'Privacy policies',
                            ),
                            defaultTextButton(
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w100,
                                  color: AppColor.txtPurple),
                              function: () {
                                Navigator.pushNamed(
                                    context, Routes.signUpRoute);
                              },
                              text: 'Help',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
