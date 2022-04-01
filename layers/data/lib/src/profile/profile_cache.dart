import 'dart:async';

import 'package:data/src/profile/i_profile_repos.dart';
import 'package:data/src/util/hive_cache.dart';
import 'package:data/src/util/request_result.dart';
import 'package:domain/domain.dart';

class _Keys {
  const _Keys._();

  static String get profile => 'my_profile';
  static String pin(String profileId) => 'pin_for_$profileId';
  static String get pinVerification => 'pin_verification';
}

class ProfileCache extends HiveCache implements IProfileCache {
  ProfileCache() : super('profile');

  @override
  Future<RequestResult<PreProfile?>> profile() async {
    await cacheInit();

    try {
      final result = cache.get(_Keys.profile);

      if (result == null) {
        return const RequestResult.success(null);
      }

      final profile = PreProfile.fromJson(
        Map<String, dynamic>.from(result as Map),
      );

      return RequestResult.success(profile);
    } catch (e, stack) {
      return RequestResult.error(e, stack);
    }
  }

  @override
  Future<RequestResult<void>> save(PreProfile? profile) async {
    await cacheInit();

    try {
      await cache.put(_Keys.profile, profile?.toJson());

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

  @override
  Future<RequestResult<PinVerification>> verifyPin(
    String profileId,
    String pin,
  ) async {
    await cacheInit();

    final lastVerification = await lastPinVerification();
    if (lastVerification.isSuccess && !lastVerification.value.canAttemptNow()) {
      return RequestResult.success(PinVerification.fail());
    }

    try {
      final result = cache.get(_Keys.pin(profileId));

      if (result == null) {
        return RequestResult.error('Pin not found');
      }

      final pinFromCache = result as String;
      final successfullyVerified = pinFromCache == pin;

      if (successfullyVerified) {
        final successVerification = PinVerification.success();
        await cache.put(_Keys.pinVerification, successVerification.toJson());

        return RequestResult.success(successVerification);
      }

      final lastVerificationJson =
          cache.get(_Keys.pinVerification) ?? PinVerification.fail().toJson();

      final failedVerification = PinVerification.fromJson(
        Map<String, dynamic>.from(lastVerificationJson as Map),
      ).failedAgain();

      await cache.put(
        _Keys.pinVerification,
        failedVerification.toJson(),
      );

      return RequestResult.success(failedVerification);
    } catch (e, stack) {
      return RequestResult.error(e, stack);
    }
  }

  @override
  Future<RequestResult<void>> createPin(String profileId, String pin) async {
    await cacheInit();

    try {
      await cache.put(_Keys.pin(profileId), pin);

      return const RequestResult.success(null);
    } catch (e, stack) {
      return RequestResult.error(e, stack);
    }
  }

  @override
  Future<RequestResult<bool>> hasPin(String profileId) async {
    await cacheInit();

    try {
      final result = cache.get(_Keys.pin(profileId));

      return RequestResult.success(result != null);
    } catch (e, stack) {
      return RequestResult.error(e, stack);
    }
  }

  @override
  Future<RequestResult<PinVerification>> lastPinVerification() async {
    await cacheInit();

    try {
      final lastVerificationJson =
          cache.get(_Keys.pinVerification) ?? PinVerification.fail().toJson();

      final lastVerification = PinVerification.fromJson(
        Map<String, dynamic>.from(lastVerificationJson as Map),
      );

      return RequestResult.success(lastVerification);
    } catch (e, stack) {
      return RequestResult.error(e, stack);
    }
  }
}
