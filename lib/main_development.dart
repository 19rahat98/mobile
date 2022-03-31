// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:application/util/injection.dart';
import 'package:domain/domain.dart';
import 'package:eleeos/app.dart';
import 'package:eleeos/bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:presentation/presentation.dart';

Future<void> main() async {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  await bootstrap(
    () async {
      final getIt = await prepareApplication(env: Env.DEV, logger: logger);
      preparePresentation(getit: getIt, logger: logger);

      return App(
        key: const Key('dev_app'),
        getIt: getIt,
        logger: logger,
      );
    },
  );
}
