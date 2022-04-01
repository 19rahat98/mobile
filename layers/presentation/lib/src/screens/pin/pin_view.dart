import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PinView extends StatefulWidget {
  const PinView({Key? key}) : super(key: key);

  @override
  State<PinView> createState() => _PinViewState();
}

class _PinViewState extends State<PinView> {
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
    return BlocConsumer<PinBloc, PinState>(
      listener: (p, c) {
        pinController.clear();
      },
      builder: (context, state) {
        bool canAttempt() {
          PinVerification pinVerification;

          if (state.isFailed) {
            pinVerification = state.asFailed.pinVerification;
          } else if (state.isReady) {
            pinVerification = state.asReady.pinVerification;
          } else {
            return false;
          }

          if (pinVerification.canAttemptNow()) {
            return true;
          } else {
            return false;
          }
        }

        return Center(
          child: Column(
            children: <Widget>[
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: pinController,
                      decoration: const InputDecoration(
                        labelText: 'Pin',
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      autofocus: true,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your pin';
                        }

                        return null;
                      },
                    ),
                    BlocBuilder<PinBloc, PinState>(
                      builder: (context, state) {
                        if (!(state.isFailed || state.isReady)) {
                          return const SizedBox.shrink();
                        }

                        PinVerification pinVerification;

                        if (state.isFailed) {
                          pinVerification = state.asFailed.pinVerification;
                        } else {
                          pinVerification = state.asReady.pinVerification;
                        }

                        return Column(
                          children: <Widget>[
                            const SizedBox(height: 8),
                            Text(
                              'Last Try: '
                              '${pinVerification.lastAttempt.format()}',
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Attempts: ${pinVerification.retryCount}'
                              '/${pinVerification.allowedAttempts}',
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Attempts Left: ${pinVerification.attemptsLeft}',
                            ),
                            const SizedBox(height: 8),
                            if (pinVerification.mustWait)
                              Text(
                                'Can retry after: '
                                '${pinVerification.canRetryAfter.format()}',
                              ),
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: canAttempt()
                    ? () {
                        if (formKey.currentState?.validate() == false) {
                          return;
                        }

                        context.read<PinBloc>().verify(pinController.text);
                      }
                    : null,
                child: const Text('Verify'),
              )
            ],
          ),
        );
      },
    );
  }
}

extension on DateTime {
  String format() {
    final hour = this.hour > 12 ? this.hour - 12 : this.hour;
    return '${monthNames[month - 1]} $day,  '
        '$hour:$minute:$second${this.hour > 12 ? ' PM' : ' AM'}';
  }
}

const monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];
