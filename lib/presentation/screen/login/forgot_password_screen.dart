import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/config/route/route_manager.dart';
import 'package:chat_application/presentation/screen/login/bloc/singin_state.dart';
import 'package:chat_application/presentation/screen/login/otp_varification_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/theme/app_theme.dart';
import '../../../injection_conatainer.dart' as di;
import '../../../utils/utils.dart';
import '../component/component.dart';
import '../component/custom_textfield.dart';
import 'bloc/forgot_password_cubit.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final _forgotPasswordCubit = di.di<ForgotPasswordCubit>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return BlocConsumer<ForgotPasswordCubit, BaseState>(
      bloc: _forgotPasswordCubit,
      listener: (context, state) {
        if (state is ForgotPasswordState) {
          Navigator.pushNamed(context, Routes.otpVerificationRoute, arguments: {
            ArgConstant.eMail: _forgotPasswordCubit.mailController.text,
            ArgConstant.otpType: OtpType.forgotPassword
          });
        } else if (state is ErrorState &&
            (state.errorMessage ?? "").isNotEmpty) {
          final snackBar = SnackBar(
            content: Text(state.errorMessage ?? "error invalid"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {

        return (state is LoadingState)
            ? const Center(child: CircularProgressIndicator()) : Scaffold(
            backgroundColor: Colors.white,
            body: Center(
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
                          'Forgot Password',
                          style: theme.textTheme.headlineLarge,
                        ).tr(),
                        Text(
                          'If you forgot your password, well, then we\'ll email you instructions to reset password.'
                              .tr(),
                          style: theme.textTheme.bodyMedium,
                        ).tr(),
                        const SizedBox(
                          height: 40,
                        ),
                        LabelTextField(
                            controller: _forgotPasswordCubit.mailController,
                            label: "Email",
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              return validateEmail(value);
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // to call api to verify email and send otp
                                _forgotPasswordCubit.sendOtp(_forgotPasswordCubit.mailController.text);
                              }
                            },
                            child: const Text(
                              'Send OTP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ).tr(),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Align(
                            alignment: Alignment.center,
                            child: defaultTextButton(
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.colorPrimary),
                              function: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    Routes.signInRoute, (route) => false);
                              },
                              text: 'Return to login',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
