import 'package:data/src/util/util.dart';
import 'package:domain/domain.dart';

abstract class IAuthCache {
  Future<void> save(AuthStatus saveState);
  Future<RequestResult<AuthStatus>> load();
}
