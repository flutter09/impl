import 'dart:io';

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
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
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
              print('error at sign up');
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
                  padding: const EdgeInsets.all(8.0),
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
                          height: 50,
                        ),
                        Text(
                          'Register',
                          style: theme.textTheme.headlineLarge,
                        ).tr(),
                        Text(
                          'Create new IMPL account',
                          style: theme.textTheme.bodyMedium,
                        ).tr(),
                        const SizedBox(
                          height: 40,
                        ),
                        LabelTextField(
                          controller: _nameController,
                          label: "Name",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LabelTextField(
                            controller: _emailController,
                            label: "Email or Username",
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              return validateEmail(value);
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        LabelTextField(
                          controller: _passwordController,
                          label: "Password",
                          isPassword: true,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            return validatePassword(value);
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
                          type: TextInputType.phone,
                          validate: (value) {
                            return validateMobileNumber(value);
                          },
                          onFieldSubmitted: (value) {
                            // if (_formKey.currentState!.validate()) {}
                          },
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
                                    _nameController.text,
                                    _emailController.text,
                                    _mobileController.text,
                                    _passwordController.text,
                                    file);
                              }
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
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
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: colorPrimary),
                              function: () {
                                Navigator.pop(context);
                              },
                              text: 'Sign in instead',
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
