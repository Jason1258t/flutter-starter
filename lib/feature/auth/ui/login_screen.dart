import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter/feature/auth/bloc/auth/auth_cubit.dart';
import 'package:starter/utils/utils.dart';
import 'package:starter/widgets/buttons/custom_button.dart';
import 'package:starter/widgets/text_fields/base_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool hidePassword = true;
  bool emailError = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Войти',
                      style: AppTypography.font32w600,
                    ),
                    const Spacer()
                  ],
                ),
                const SizedBox(
                  height: 48,
                ),
                BaseTextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'yourmail@gmail.com',
                  error: emailError,
                  onChange: (v) {
                    setState(() {
                      emailError =
                          !RegExp(AppStrings.emailRegExp).hasMatch(v ?? '');
                    });
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                BaseTextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: 'password',
                  obscureText: hidePassword,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.remove_red_eye_outlined,
                      color: AppColors.border,
                    ),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    text: 'Войти', onTap: () {}, width: double.infinity),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Spacer(),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Нет аккаунта? ',
                            style: AppTypography.fon12w400
                                .copyWith(color: Colors.black),
                          ),
                          TextSpan(
                              text: 'Регистрация',
                              style: AppTypography.fon12w400.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => print('Tap Here onTap')),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
