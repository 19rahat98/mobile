import 'package:data/src/auth/i_auth_repos.dart';
import 'package:data/src/util/util.dart';
import 'package:domain/enums/auth_status.dart';

class _Keys {
  const _Keys._();

  static const String auth = 'auth_state';
}

class AuthCache extends HiveCache<String> implements IAuthCache {
  AuthCache() : super('auth');

  @override
  Future<RequestResult<AuthStatus>> load() async {
    await cacheInit();

    try {
      final result = cache.get(_Keys.auth) ?? AuthStatus.notAuthenticated.name;

      return RequestResult.success(AuthStatus.values.fromString(result));
    } catch (e) {
      return const RequestResult.success(AuthStatus.notAuthenticated);
    }
  }

  @override
  Future<void> save(AuthStatus saveState) async {
    await cacheInit();

    await cache.put(_Keys.auth, saveState.name);
  }
}
