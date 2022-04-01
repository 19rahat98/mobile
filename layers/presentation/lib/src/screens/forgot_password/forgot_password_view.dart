import 'package:application/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/shared/text_form_fields.dart';
import 'package:presentation/src/routes/paths.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController;
  late final FocusNode emailFocusNode;

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    emailFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Form(
            key: formKey,
            child: EmailTextFormField(
              controller: emailController,
              focusNode: emailFocusNode,
              textInputAction: TextInputAction.done,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() == false) {
                return;
              }

              context
                  .read<ProfileBloc>()
                  .forgotPassword(emailController.text.trim());
              context.go(Paths.welcome.path);
            },
            child: const Text('Send Email'),
          ),
        ],
      ),
    );
  }
}
