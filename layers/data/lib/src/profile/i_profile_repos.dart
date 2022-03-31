import 'package:data/src/util/request_result.dart';
import 'package:domain/domain.dart';

abstract class IProfileRemote {
  Future<RequestResult<Profile>> login(String email);
  Future<RequestResult<PreProfile>> create(String email);
  Future<RequestResult<PreProfile?>> profile(String id);
  Future<RequestResult<void>> logout();
  Future<RequestResult<Profile>> update(Profile profile);
}

abstract class IProfileCache {
  Future<RequestResult<PreProfile?>> profile();
  Future<RequestResult<void>> save(PreProfile profile);
  Future<RequestResult<void>> clear();
}
