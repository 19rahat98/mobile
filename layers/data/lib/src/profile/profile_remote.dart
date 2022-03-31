// ignore_for_file: avoid_print

import 'package:data/src/profile/i_profile_repos.dart';
import 'package:data/src/util/request_result.dart';
import 'package:domain/domain.dart';

class ProfileRemote extends IProfileRemote {
  @override
  Future<RequestResult<Profile>> login(String email) {
    throw UnimplementedError();
  }

  @override
  Future<RequestResult<void>> logout() {
    throw UnimplementedError();
  }

  @override
  Future<RequestResult<Profile?>> profile(String id) {
    throw UnimplementedError();
  }

  @override
  Future<RequestResult<Profile>> update(Profile profile) {
    throw UnimplementedError();
  }
}
