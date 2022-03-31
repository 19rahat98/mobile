// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:eleeos/util/app_bloc_observer.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

Future<void> bootstrap(
  FutureOr<Widget> Function() builder, {
  Logger? logger,
}) async {
  final loggr = logger ??
      Logger(
        printer: PrettyPrinter(),
      );

  FlutterError.onError = (details) {
    loggr.e('Flutter Error', details.exceptionAsString(), details.stack);
  };

  await runZonedGuarded(
    () async {
      await BlocOverrides.runZoned(
        () async => runApp(await builder()),
        blocObserver: AppBlocObserver(logger: loggr),
      );
    },
    (error, stackTrace) => loggr.e('Zoned Error', error, stackTrace),
  );
}
