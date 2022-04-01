import 'package:application/application.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/shared/shared.dart';
import 'package:presentation/src/presentation.dart';

import 'pin_view.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({Key? key}) : super(key: key);

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  late final PinBloc pinBloc;

  @override
  void initState() {
    super.initState();
    final profile = context.read<ProfileBloc>().state.profile;

    pinBloc = getIt<PinBloc>();

    if (profile == null) {
      pinBloc.fail();
    } else {
      pinBloc.init(profile.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return RemoveFocus(
      child: BlocProvider(
        create: (context) => pinBloc,
        child: BlocListener<PinBloc, PinState>(
          listener: (context, state) {
            if (state.isFailed) {
              print('Pin failed');
            } else if (state.isVerified) {
              print('Pin verified');
              context.pop();
            } else if (state.isError) {
              print('Pin error: ${state.asError.message}');
            }
          },
          child: WillPopScope(
            child: Scaffold(
              appBar: AppBar(
                title: const Text('PIN'),
                leading: const SizedBox.shrink(),
              ),
              body: const PinView(),
            ),
            onWillPop: () async => false,
          ),
        ),
      ),
    );
  }
}
