import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/config/route/route_manager.dart';
import 'package:chat_application/presentation/screen/login/bloc/singin_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/theme/app_theme.dart';
import '../../../injection_conatainer.dart' as di;
import '../../../utils/utils.dart';
import '../component/component.dart';
import '../component/custom_textfield.dart';
import 'bloc/forgot_password_cubit.dart';

enum OtpType { registerUser, forgotPassword }

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  final OtpType type;

  OtpVerificationScreen({super.key, required this.email, required this.type});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _forgotPasswordCubit = di.di<ForgotPasswordCubit>();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.type == OtpType.registerUser) {
      _forgotPasswordCubit.sendOtp(widget.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return BlocConsumer<ForgotPasswordCubit, BaseState>(
      bloc: _forgotPasswordCubit,
      listener: (context, state) {
        if (state is OtpVerifiedState) {
          if (widget.type == OtpType.forgotPassword) {
            Navigator.pushNamed(context, Routes.generatePasswordScreen,
                arguments: {
                  ArgConstant.eMail: widget.email
                });
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.dashboardScreen, (route) => false);
          }
        } else if (state is ErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(getSnackBar(state.errorMessage ?? "error invalid"));
        }
      },
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
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
                          height: 50,
                        ),
                        Text(
                          'Verify OTP',
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
                            controller: _forgotPasswordCubit.otpController,
                            label: "OTP",
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value.toString().isEmpty) {
                                return "Otp must not be empty";
                              }
                              return null;
                            }),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _forgotPasswordCubit.verifyOtp(widget.email);
                              }
                            },
                            child: const Text(
                              'Verify OTP',
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
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: colorPrimary),
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
