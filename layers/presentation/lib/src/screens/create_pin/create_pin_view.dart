import 'package:application/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/src/routes/paths.dart';

class CreatePinView extends StatefulWidget {
  const CreatePinView({Key? key}) : super(key: key);

  @override
  State<CreatePinView> createState() => _CreatePinViewState();
}

class _CreatePinViewState extends State<CreatePinView> {
  late final TextEditingController pinController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();

    pinController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    const pinLength = 6;

    return Center(
      child: Column(
        children: <Widget>[
          Form(
            key: formKey,
            child: TextFormField(
              controller: pinController,
              decoration: const InputDecoration(
                labelText: 'Pin',
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              maxLength: pinLength,
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              autofocus: true,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your pin';
                }

                if (value.length != pinLength) {
                  return 'Please enter a valid pin';
                }

                return null;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() == false) {
                return;
              }

              context.read<ProfileBloc>().createPin(pinController.text);

              context.push(Paths.onboarding.allowNotification.path);
            },
            child: const Text('Create, Next!'),
          )
        ],
      ),
    );
  }
}
