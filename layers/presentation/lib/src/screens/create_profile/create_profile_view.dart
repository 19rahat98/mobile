import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/shared/text_form_fields.dart';
import 'package:presentation/src/routes/paths.dart';

class CreateProfileView extends StatefulWidget {
  const CreateProfileView({Key? key}) : super(key: key);

  @override
  State<CreateProfileView> createState() => _CreateProfileViewState();
}

class _CreateProfileViewState extends State<CreateProfileView> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController firstNameController, lastNameController;
  late final FocusNode firstNameFocusNode, lastNameFocusNode;

  @override
  void initState() {
    super.initState();

    formKey = GlobalKey<FormState>();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();

    firstNameFocusNode = FocusNode();
    lastNameFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                NameTextFormField.first(
                  controller: firstNameController,
                  focusNode: firstNameFocusNode,
                  nextFocusNode: lastNameFocusNode,
                  textInputAction: TextInputAction.next,
                ),
                NameTextFormField.last(
                  controller: lastNameController,
                  focusNode: lastNameFocusNode,
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final profileBloc = context.read<ProfileBloc>();

              // profile should already exist, we are just adding
              // the "detailed" information
              final profile = profileBloc.state.profile!;

              profileBloc.updateProfile(
                Profile(
                  firstName: firstNameController.text.trim(),
                  lastName: lastNameController.text.trim(),
                  // should NOT be updated here
                  email: profile.email,
                ),
              );
              context.push(Paths.onboarding.pin.path);
            },
            child: const Text('Create Profile, Next!'),
          )
        ],
      ),
    );
  }
}
