import 'package:chat_application/presentation/screen/login/bloc/generate_password_cubit.dart';
import 'package:chat_application/presentation/screen/login/bloc/singin_state.dart';
import 'package:chat_application/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/base_state.dart';
import '../../../config/route/route_manager.dart';
import '../../../injection_conatainer.dart' as di;
import '../component/custom_textfield.dart';

class GeneratePasswordScreen extends StatelessWidget {
  final String email;

  GeneratePasswordScreen({super.key, required this.email});

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final GeneratePasswordCubit generatePasswordCubit = di.di<GeneratePasswordCubit>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return BlocConsumer<GeneratePasswordCubit, BaseState>(
      bloc: generatePasswordCubit,
      listener: (context, state) {
        if (state is GeneratePasswordState) {
          ScaffoldMessenger.of(context).showSnackBar(getSnackBar(state.message));
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.dashboardScreen, (route) => false,
              arguments: {});
        } else if (state is ErrorState &&
            (state.errorMessage ?? "").isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(getSnackBar(state.errorMessage ?? "error invalid"));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body:(state is LoadingState)
              ? const Center(child: CircularProgressIndicator()) : Center(
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
                        height: 70,
                      ),
                      Text(
                        'Generate Password',
                        style: theme.textTheme.headlineLarge,
                      ).tr(),
                      Text(
                        'Generate new password',
                        style: theme.textTheme.bodyMedium,
                      ).tr(),
                      const SizedBox(
                        height: 40,
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
                        controller: _confirmPasswordController,
                        label: "Confirm Password",
                        isPassword: true,
                        type: TextInputType.visiblePassword,
                        validate: (value) {
                          return validateConfirmPassword(
                              _passwordController.text, value);
                        },
                        onFieldSubmitted: (value) {
                          // if (_formKey.currentState!.validate()) {}
                        },
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              generatePasswordCubit.generatePassword(
                                  email, _passwordController.text);
                            }
                          },
                          child: const Text(
                            'Generate Password',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ).tr(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
