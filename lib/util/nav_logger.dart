import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class NavLogger extends NavigatorObserver {
  NavLogger({Logger? logger})
      : logger = logger ?? Logger(printer: PrettyPrinter());

  final Logger logger;

  @override
  void didPop(Route route, Route? previousRoute) {
    logger.d(
      '[NAV] | POP: ${route.settings.name} '
      'from: ${previousRoute?.settings.name}',
    );
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    logger.d(
      '[NAV] | PUSH: ${route.settings.name} '
      'from: ${previousRoute?.settings.name}',
    );
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    logger.d(
      '[NAV] | REPLACE: ${newRoute?.settings.name} '
      'from: ${oldRoute?.settings.name}',
    );
  }
}
