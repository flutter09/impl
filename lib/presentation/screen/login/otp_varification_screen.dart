import 'package:chat_application/config/route/route_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../config/theme/app_theme.dart';
import '../component/component.dart';
import '../component/custom_textfield.dart';

class OtpVerificationScreen extends StatelessWidget {
  OtpVerificationScreen({super.key});
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final formKey = GlobalKey<FormState>();

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
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
                        controller: _controller,
                        label: "OTP",
                        type: TextInputType.emailAddress,
                        validate: (value) {

                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.generatePasswordScreen);
                          if (formKey.currentState!.validate()) {
                            // to call api to verify email and send otp
                          }
                        },
                        child: const Text(
                          'Verify OTP',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ).tr(),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.center,
                        child: defaultTextButton(
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, color: colorPrimary),
                          function: () {
                            Navigator.pushNamedAndRemoveUntil(context, Routes.signInRoute, (route) => false);
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
        )
    );
  }
}
