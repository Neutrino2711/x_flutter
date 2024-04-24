import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x/business_logic/blocs/bloc/post_list_bloc.dart';
import 'package:x/business_logic/blocs/cubit/auth_cubit.dart';
import 'package:x/data/repos/auth_repo.dart';
import 'package:x/presentation/screens/postscreen.dart';
import 'package:x/presentation/widgets/custom_button.dart';
import 'package:x/presentation/widgets/custom_textfield.dart';
import 'package:x/presentation/widgets/custom_passwordfield.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final String? error;

  LoginScreen({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    var dimensions = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) => current is AuthFailedLogin,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error!),
            ));
          },
          child: SafeArea(
              child: SingleChildScrollView(
                  child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 50),
                            Text('Welcome Back!',
                                style:
                                    Theme.of(context).textTheme.titleLarge),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text('Please fill in the form to continue'),
                            const SizedBox(height: 70),
                            CustomTextFormField(
                              label: 'Email',
                              iconData: Icons.person,
                              textEditingController: _emailController,
                              validator: (p0) => p0!.isEmpty
                                  ? 'Email cannot be empty'
                                  : null,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomPasswordFormField(
                              label: 'Password',
                              iconData: Icons.lock,
                              textEditingController: _passwordController,
                              validator: (p0) => p0!.isEmpty
                                  ? 'Password cannot be empty'
                                  : null,
                            ),
                            const SizedBox(
                              height: 70,
                            ),
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                return CustomButton(
                                    dimensions: dimensions,
                                    action: state is AuthLoadingLogin
                                        ? null
                                        : () {
                                            FocusScope.of(context).unfocus();
                                            if (_formKey.currentState!
                                                .validate()) {
                                              context.read<AuthCubit>().login(
                                                  _emailController.text,
                                                  _passwordController.text);
                                            }
                                            BlocProvider(
              create: (context) => PostListBloc(
                authToken: context.read<AuthCubit>().state.authToken!,
                dio: Dio(),
              ),
              child: const PostScreen(),
            );
                                          },
                                    child: state is AuthLoadingLogin
                                        ? const CircularProgressIndicator()
                                        : Text(
                                            'Sign In',
                                            style: TextStyle(
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .fontSize,
                                            ),
                                          ));
                              },
                            ),
                              const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "New User? ",
                        style: TextStyle(),
                      ),
                      TextButton(
                        onPressed: () {
                          context.read<AuthCubit>().navigateToRegister();
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .fontSize,
                          ),
                        ),
                      ),],)
                          ],
                          ),
                          ),
                          )
                          ,),
                          ),

    );
  }
}
