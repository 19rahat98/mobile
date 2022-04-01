import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pin_verification.g.dart';

@JsonSerializable(constructor: '_fail')
class PinVerification extends Equatable {
  const PinVerification._fail({
    required this.retryCount,
    required this.lastAttempt,
    required this.canRetryAfter,
  }) : wasVerified = false;

  const PinVerification._private({
    required this.retryCount,
    required this.lastAttempt,
    required this.canRetryAfter,
    required this.wasVerified,
  });

  PinVerification.success()
      : this._private(
          retryCount: 0,
          lastAttempt: DateTime.now(),
          canRetryAfter: DateTime.now(),
          wasVerified: true,
        );
  PinVerification.fail()
      : this._private(
          retryCount: 0,
          lastAttempt: DateTime.now(),
          canRetryAfter: DateTime.now(),
          wasVerified: false,
        );

  factory PinVerification.fromJson(Map json) => _$PinVerificationFromJson(json);

  PinVerification failedAgain() {
    final attempt = retryCount + 1;

    var canRetryAfter = DateTime.now();

    if (attempt >= allowedAttempts - 1) {
      canRetryAfter = DateTime.now().add(
        Duration(minutes: (attempt - allowedAttempts + 1) * retryDelay),
      );
    }

    return PinVerification._fail(
      retryCount: attempt,
      lastAttempt: DateTime.now(),
      canRetryAfter: canRetryAfter,
    );
  }

  /// resets to 0 when pin is verified
  final int retryCount;

  /// last time a pin was attempted
  final DateTime lastAttempt;

  /// when the pin can be attempted again
  final DateTime canRetryAfter;

  /// returns true if the pin was successfully verified
  /// within the last X minutes
  final bool wasVerified;

  int get allowedAttempts => 5;

  int get retryDelay => 30;

  bool get mustWait => retryCount > 0 && DateTime.now().isBefore(canRetryAfter);

  int get attemptsLeft => max(allowedAttempts - retryCount, 0);

  PinVerification succeed() => PinVerification._private(
        retryCount: 0,
        lastAttempt: DateTime.now(),
        canRetryAfter: DateTime.now(),
        wasVerified: true,
      );

  bool canAttemptNow() {
    if (retryCount >= allowedAttempts) {
      return DateTime.now().isAfter(canRetryAfter);
    }

    return true;
  }

  Map<String, dynamic> toJson() => _$PinVerificationToJson(this);

  @override
  List<Object?> get props => [
        retryCount,
        lastAttempt,
        canRetryAfter,
      ];
}
