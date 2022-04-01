// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin_verification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PinVerification _$PinVerificationFromJson(Map json) => PinVerification._fail(
      retryCount: json['retryCount'] as int,
      lastAttempt: DateTime.parse(json['lastAttempt'] as String),
      canRetryAfter: DateTime.parse(json['canRetryAfter'] as String),
    );

Map<String, dynamic> _$PinVerificationToJson(PinVerification instance) =>
    <String, dynamic>{
      'retryCount': instance.retryCount,
      'lastAttempt': instance.lastAttempt.toIso8601String(),
      'canRetryAfter': instance.canRetryAfter.toIso8601String(),
    };
