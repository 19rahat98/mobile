import 'package:application/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/shared/shared.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({Key? key}) : super(key: key);

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController,
      passwordController,
      confirmPasswordController;

  late FocusNode? emailFocusNode, passwordFocusNode, confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
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
              nextFocusNode: confirmPasswordFocusNode,
            ),
            PasswordTextFormField(
              controller: confirmPasswordController,
              focusNode: confirmPasswordFocusNode,
              label: 'Confirm Password',
              validator: (value) {
                if (value != passwordController.text) {
                  return 'Passwords do not match';
                }

                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() == false) {
                  return;
                }

                context.read<ProfileBloc>().createAccount(
                      emailController.text.trim(),
                      passwordController.text,
                    );
              },
              child: const Text('Create an Account'),
            )
          ],
        ),
      ),
    );
  }
}
