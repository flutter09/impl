import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../base/base_state.dart';
import '../../injection_conatainer.dart' as di;
import '../bloc/singin_cubit.dart';

class SignInScreen extends StatelessWidget {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = di.di<SignInCubit>();

    return Scaffold(backgroundColor: Colors.white,
      body: BlocProvider(create: (context)=>loginCubit,
        child: BlocConsumer<SignInCubit, BaseState>(
          bloc: loginCubit,
          listener: (context, state) {
            if (state is SignInState) {

              print("Login is sucess");
            } else if (state is ErrorState) {
              print(state.errorMessage);

            }
          },
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<SignInCubit, BaseState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () {
                        loginCubit.login(
                          _usernameController.text,
                          _passwordController.text,
                        );
                      },
                      child: const Text('Login', style: TextStyle(color: Colors.black),),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
