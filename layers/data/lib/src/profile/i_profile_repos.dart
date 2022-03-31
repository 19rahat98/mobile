import 'package:data/src/util/request_result.dart';
import 'package:domain/domain.dart';

abstract class IProfileRemote {
  Future<RequestResult<Profile>> login(String email);
  Future<RequestResult<Profile?>> profile(String id);
  Future<RequestResult<void>> logout();
  Future<RequestResult<Profile>> update(Profile profile);
}

abstract class IProfileCache {
  Future<RequestResult<Profile?>> profile();
  Future<RequestResult<void>> save(Profile profile);
  Future<RequestResult<void>> clear();
}
