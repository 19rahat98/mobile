import 'dart:async';

import 'package:data/src/profile/i_profile_repos.dart';
import 'package:data/src/util/hive_cache.dart';
import 'package:data/src/util/request_result.dart';
import 'package:domain/domain.dart';
import 'package:hive/hive.dart';

class ProfileCache extends HiveCache implements IProfileCache {
  ProfileCache({Box? box}) : super('profile', box: box);

  @override
  Future<RequestResult<Profile?>> profile() async {
    try {
      final result = cache.get('profile');

      if (result == null) {
        return const RequestResult.success(null);
      }

      final profile = Profile.fromJson(
        Map<String, dynamic>.from(result),
      );

      return RequestResult.success(profile);
    } catch (e, stack) {
      return RequestResult.error(e, stack);
    }
  }

  @override
  Future<RequestResult<void>> save(PreProfile profile) async {
    try {
      await cache.put('profile', profile.toJson());

      return const RequestResult.success(null);
    } catch (e, stack) {
      return RequestResult.error(e, stack);
    }
  }

  @override
  Future<RequestResult<void>> clear() async {
    try {
      await cache.delete('profile');

      return const RequestResult.success(null);
    } catch (e, stack) {
      return RequestResult.error(e, stack);
    }
  }
}
