import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class AppBlocObserver extends BlocObserver {
  AppBlocObserver({Logger? logger})
      : logger = logger ?? Logger(printer: PrettyPrinter());

  final Logger logger;

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    logger.d('[BLOC] | CHANGE: ${bloc.runtimeType} = $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.e('[BLOC] | ERROR: ${bloc.runtimeType}', error, stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    logger.d('[BLOC] | EVENT: ${bloc.runtimeType} = $event');
    super.onEvent(bloc, event);
  }
}
