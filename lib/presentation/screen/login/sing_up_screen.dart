import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/base_state.dart';
import '../../../config/theme/app_theme.dart';
import '../../../injection_conatainer.dart' as di;
import '../../../utils/utils.dart';
import 'bloc/signup_cubit.dart';
import 'bloc/singin_state.dart';
import '../component/component.dart';
import '../component/custom_textfield.dart';

class SignUpScreen extends StatelessWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signUpCubit = di.di<SignUpCubit>();
    var theme = Theme.of(context);
    var formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => signUpCubit,
        child: BlocConsumer<SignUpCubit, BaseState>(
          bloc: signUpCubit,
          listener: (context, state) {
            if (state is SignUpState) {
              print("Login is success");
            } else if (state is ErrorState) {
              print(state.errorMessage);
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
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(alignment: Alignment.center , child: Image.asset("assets/images/impm_logo.png",width: 200 , height: 100 , fit: BoxFit.fill,),),
                        const SizedBox(height: 50,),
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
                            if (formKey.currentState!.validate()) {}
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
                            if (formKey.currentState!.validate()) {}
                          },
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<SignUpCubit, BaseState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  //register a user
                                  if (formKey.currentState!.validate()) {}
                                },
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ).tr(),
                              ),
                            );
                          },
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
