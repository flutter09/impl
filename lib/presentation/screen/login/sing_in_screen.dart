import 'package:chat_application/config/route/route_manager.dart';
import 'package:chat_application/presentation/screen/component/custom_image_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/base_state.dart';
import '../../../config/theme/app_theme.dart';
import '../../../injection_conatainer.dart' as di;
import '../../../utils/utils.dart';
import '../component/component.dart';
import '../component/custom_textfield.dart';
import 'bloc/singin_cubit.dart';
import 'bloc/singin_state.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _controller = TextEditingController();

  final _passwordController = TextEditingController();
  final loginCubit = di.di<SignInCubit>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // loginCubit.checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => loginCubit,
        child: BlocConsumer<SignInCubit, BaseState>(
          bloc: loginCubit,
          listener: (context, state) {
            if (state is SignInState) {
              Navigator.pushNamedAndRemoveUntil(context, Routes.dashboardScreen, (Route<dynamic> route) => false);
            } else if (state is ErrorState) {
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
                    key: formKey,
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
                          'Sign-In',
                          style: theme.textTheme.headlineLarge,
                        ).tr(),
                        const SizedBox(
                          height: 30,
                        ),
                        LabelTextField(
                            controller: _controller,
                            label: "Username",
                            hintText: "Enter your email or username or phone",
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              return validateEmailPhone(value);
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        LabelTextField(
                          controller: _passwordController,
                          label: "Password",
                          hintText: "Enter your password",
                          isPassword: true,
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            // return validatePassword(value); // todo : password validation
                          },
                          onFieldSubmitted: (value) {
                            // if (_formKey.currentState!.validate()) {}
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: defaultTextButton(
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.colorGray),
                              function: () {
                                Navigator.pushNamed(
                                    context, Routes.forgotPasswordRoute);
                              },
                              text: 'Forgot Password'.tr(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        BlocBuilder<SignInCubit, BaseState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Navigator.pushNamedAndRemoveUntil(context, Routes.chatListRoute, (route) => false);//todo remove this navigation
                                  if (formKey.currentState!.validate()) {
                                    loginCubit.login(
                                      _controller.text,
                                      _passwordController.text,
                                    );
                                  }
                                },
                                child: const Text(
                                  'Sign in',
                                  /*style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),*/
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
                              'New on our platform?',
                              style: theme.textTheme.bodyMedium,
                            ),
                            defaultTextButton(
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.colorPrimary),
                              function: () {
                                Navigator.pushNamed(
                                    context, Routes.signUpRoute);
                              },
                              text: 'Create an account',
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.0 , vertical: 8),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Divider(
                                  color: AppColor.colorGray,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  'OR',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColor.colorGray,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: AppColor.colorGray,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomImageButton(assetPath: 'assets/images/ic_google.png', onPressed: (){} , iconColor: Colors.black54 ),
                            SizedBox(width: 10),
                            CustomImageButton(assetPath: 'assets/images/ic_linkedin.png', onPressed: (){}, iconColor: Colors.black54),
                          ]
                        ),
                        SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            defaultTextButton(
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.colorPrimary),
                              function: () {
                                Navigator.pushNamed(
                                    context, Routes.signUpRoute);
                              },
                              text: 'Terms & Conditions',
                            ),
                            defaultTextButton(
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.colorPrimary),
                              function: () {
                                Navigator.pushNamed(
                                    context, Routes.signUpRoute);
                              },
                              text: 'Privacy policies',
                            ),
                            defaultTextButton(
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.colorPrimary),
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
