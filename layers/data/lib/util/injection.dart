// ignore_for_file: cascade_invocations

import 'package:data/data.dart';
import 'package:data/util/request_logger.dart';
import 'package:dio/dio.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

late Dio dio;

Future<void> prepareData(GetIt sl, {Env env = Env.PROD, Logger? logger}) async {
  final loggr = logger ?? Logger(printer: PrettyPrinter());
  loggr.d('Initializing data layer');

  await Hive.initFlutter();

  dio = Dio();

  dio.interceptors.add(RequestLogger());

  sl.registerRepo<IAuthCache>(AuthCache.new);
  sl.registerRepo<IProfileRemote>(ProfileRemote.new);
  sl.registerRepo<IProfileCache>(ProfileCache.new);
  sl.registerRepo<IThemeCache>(ThemeCache.new);
}

extension on GetIt {
  void registerRepo<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    bool singleton = true,
  }) {
    final valueType = '$factoryFunc'.split(' => ').last.split(' ').first;

    final getFromInstanceName = valueType != '$T';

    final instanceName = getFromInstanceName ? valueType : null;
    if (singleton) {
      registerSingleton<T>(factoryFunc(), instanceName: instanceName);
    } else {
      registerFactory<T>(factoryFunc, instanceName: instanceName);
    }
  }
}
