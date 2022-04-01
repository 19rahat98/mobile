import 'dart:async';

import 'package:data/src/profile/i_profile_repos.dart';
import 'package:data/src/util/hive_cache.dart';
import 'package:data/src/util/request_result.dart';
import 'package:domain/domain.dart';

class ProfileCache extends HiveCache<Map> implements IProfileCache {
  ProfileCache() : super('profile');

  @override
  Future<RequestResult<Profile?>> profile() async {
    await cacheInit();

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
    await cacheInit();

    try {
      await cache.put('profile', profile.toJson());

      return const RequestResult.success(null);
    } catch (e, stack) {
      return RequestResult.error(e, stack);
    }
  }

  @override
  Future<RequestResult<void>> clear() async {
    await cacheInit();

    try {
      await cache.delete('profile');

      return const RequestResult.success(null);
    } catch (e, stack) {
      return RequestResult.error(e, stack);
    }
  }
}
