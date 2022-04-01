// ignore_for_file: cascade_invocations

import 'package:application/application.dart';
import 'package:application/util/bloc_storage.dart';
import 'package:application/util/cache_bloc.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

Future<GetIt> prepareApplication({Env env = Env.PROD, Logger? logger}) async {
  final loggr = logger ?? Logger(printer: PrettyPrinter());
  loggr.d('Initializing application layer');

  final sl = GetIt.asNewInstance();

  await prepareData(sl, env: env);

  final hydratedStorage = await Hive.openBox<Map>('hydrated_storage');

  CacheBloc.storage = LocalStorage(hydratedStorage, logger: logger);

  sl.registerFactory(
    () => ProfileBloc(
      profileRepo: sl.getRepo<IProfileRemote, ProfileRemote>(),
      profileCache: sl.getRepo<IProfileCache, ProfileCache>(),
    ),
  );

  sl.registerFactory(AuthBloc.new);

  sl.registerFactory(
    () => ThemeBloc(cache: sl.getRepo<IThemeCache, ThemeCache>()),
  );

  return sl;
}

extension on GetIt {
  T getRepo<T extends Object, I extends T>() => get<T>(instanceName: '$I');
}
