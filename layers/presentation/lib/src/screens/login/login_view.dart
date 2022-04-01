import 'package:application/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/shared/shared.dart';
import 'package:presentation/src/routes/paths.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController, passwordController;
  late final FocusNode emailFocusNode, passwordFocusNode;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return RemoveFocus(
      child: Center(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  EmailTextFormField(
                    controller: emailController,
                    focusNode: emailFocusNode,
                    nextFocusNode: passwordFocusNode,
                  ),
                  PasswordTextFormField(
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() == false) {
                  return;
                }

                context.read<ProfileBloc>().login(
                      emailController.text.trim(),
                      passwordController.text,
                    );
              },
              child: const Text('login'),
            ),
            ElevatedButton(
              onPressed: () {
                context.push(Paths.welcome.forgotPassword.path);
              },
              child: const Text('forgot password'),
            )
          ],
        ),
      ),
    );
  }
}
