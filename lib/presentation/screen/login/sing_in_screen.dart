import 'package:chat_application/config/route/route_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../base/base_state.dart';
import '../../../config/theme/app_theme.dart';
import '../../../injection_conatainer.dart' as di;
import '../../../utils/utils.dart';
import '../../bloc/singin_cubit.dart';
import '../component/component.dart';
import '../component/custom_textfield.dart';

class SignInScreen extends StatefulWidget {

  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _controller = TextEditingController();

  final _passwordController = TextEditingController();
  final loginCubit = di.di<SignInCubit>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginCubit.checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => loginCubit,
        child: BlocConsumer<SignInCubit, BaseState>(
          bloc: loginCubit,
          listener: (context, state) {
            if (state is SignInState) {
              Navigator.pushNamedAndRemoveUntil(context, Routes.chatListRoute,(Route<dynamic> route) => false);
            } else if (state is ErrorState && (state.errorMessage ?? "").isNotEmpty) {
              final snackBar = SnackBar(
                content: Text(state.errorMessage ?? "error invalid"),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                        const SizedBox(height: 70,),
                        Text(
                          'Sign-In',
                          style: theme.textTheme.headlineLarge,
                        ).tr(),
                        Text(
                          'Access IMPL using your mail and password',
                          style: theme.textTheme.bodyMedium,
                        ).tr(),
                        const SizedBox(
                          height: 40,
                        ),
                        LabelTextField(
                            controller: _controller,
                            label: "Email or Username",
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              return validateEmail(value);
                            }
                            ),
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
                        SizedBox(
                          width: double.infinity,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: defaultTextButton(
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: colorPrimary),
                              function: () {
                                Navigator.pushNamed(context, Routes.forgotPasswordRoute);
                              },
                              text: 'Forgot Password'.tr(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
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
                              'New on our platform?',
                              style: theme.textTheme.bodyMedium,
                            ),
                            defaultTextButton(
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: colorPrimary),
                              function: () {
                                Navigator.pushNamed(
                                    context, Routes.signUpRoute);
                              },
                              text: 'Create an account',
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
