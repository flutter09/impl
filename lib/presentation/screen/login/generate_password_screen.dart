import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../component/custom_textfield.dart';

class GeneratePasswordScreen extends StatelessWidget {
  GeneratePasswordScreen({super.key});

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
    var formKey = GlobalKey<FormState>();

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
                  const SizedBox(height: 70,),
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
                      if (value.isEmpty) {
                        return 'password is too short !!';
                      }
                    },
                    onFieldSubmitted: (value) {
                      if (formKey.currentState!.validate()) {}
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
                      if (value.isEmpty) {
                        return 'password is too short !!';
                      }
                    },
                    onFieldSubmitted: (value) {
                      if (formKey.currentState!.validate()) {}
                    },
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {

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
  }
}