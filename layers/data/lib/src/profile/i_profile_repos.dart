import 'package:data/src/util/request_result.dart';
import 'package:domain/domain.dart';

abstract class IProfileRemote {
  Future<RequestResult<PreProfile>> login(String email, String password);
  Future<RequestResult<PreProfile>> create(String email, String password);
  Future<RequestResult<void>> forgotPassword(String email);
  Future<RequestResult<PreProfile?>> profile(String id);
  Future<RequestResult<void>> logout();
  Future<RequestResult<Profile>> update(Profile profile);
}

abstract class IProfileCache {
  Future<RequestResult<PreProfile?>> profile();
  Future<RequestResult<void>> save(PreProfile? profile);
  Future<RequestResult<void>> clear();
  Future<RequestResult<void>> createPin(String profileId, String pin);
  Future<RequestResult<bool>> hasPin(String profileId);
  Future<RequestResult<PinVerification>> lastPinVerification();
  Future<RequestResult<PinVerification>> verifyPin(
    String profileId,
    String pin,
  );
}
