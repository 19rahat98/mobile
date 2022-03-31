import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

late GetIt getIt;
late Logger log;

void preparePresentation({required GetIt getit, Logger? logger}) {
  log = logger ?? Logger(printer: PrettyPrinter());
  log.d('Initializing presentation layer');

  getIt = getit;
}

extension ThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);
}
