// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:application/util/injection.dart';
import 'package:eleeos/app.dart';
import 'package:eleeos/bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:presentation/presentation.dart';

Future<void> main() async {
  final logger = Logger(
    printer: PrettyPrinter(),
  );

  final getIt = await prepareApplication();
  preparePresentation(getit: getIt);

  await bootstrap(
    () => App(
      key: const Key('production_app'),
      getIt: getIt,
      logger: logger,
    ),
  );
}
