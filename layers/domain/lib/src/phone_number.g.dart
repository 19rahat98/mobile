// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_number.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PhoneNumberCWProxy {
  PhoneNumber createdAt(DateTime createdAt);

  PhoneNumber id(String id);

  PhoneNumber isActive(bool isActive);

  PhoneNumber isPrimary(bool isPrimary);

  PhoneNumber isVerified(bool isVerified);

  PhoneNumber phoneNumber(String phoneNumber);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PhoneNumber(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PhoneNumber(...).copyWith(id: 12, name: "My name")
  /// ````
  PhoneNumber call({
    DateTime? createdAt,
    String? id,
    bool? isActive,
    bool? isPrimary,
    bool? isVerified,
    String? phoneNumber,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPhoneNumber.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPhoneNumber.copyWith.fieldName(...)`
class _$PhoneNumberCWProxyImpl implements _$PhoneNumberCWProxy {
  final PhoneNumber _value;

  const _$PhoneNumberCWProxyImpl(this._value);

  @override
  PhoneNumber createdAt(DateTime createdAt) => this(createdAt: createdAt);

  @override
  PhoneNumber id(String id) => this(id: id);

  @override
  PhoneNumber isActive(bool isActive) => this(isActive: isActive);

  @override
  PhoneNumber isPrimary(bool isPrimary) => this(isPrimary: isPrimary);

  @override
  PhoneNumber isVerified(bool isVerified) => this(isVerified: isVerified);

  @override
  PhoneNumber phoneNumber(String phoneNumber) => this(phoneNumber: phoneNumber);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PhoneNumber(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PhoneNumber(...).copyWith(id: 12, name: "My name")
  /// ````
  PhoneNumber call({
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? isActive = const $CopyWithPlaceholder(),
    Object? isPrimary = const $CopyWithPlaceholder(),
    Object? isVerified = const $CopyWithPlaceholder(),
    Object? phoneNumber = const $CopyWithPlaceholder(),
  }) {
    return PhoneNumber(
      createdAt: createdAt == const $CopyWithPlaceholder() || createdAt == null
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      isActive: isActive == const $CopyWithPlaceholder() || isActive == null
          ? _value.isActive
          // ignore: cast_nullable_to_non_nullable
          : isActive as bool,
      isPrimary: isPrimary == const $CopyWithPlaceholder() || isPrimary == null
          ? _value.isPrimary
          // ignore: cast_nullable_to_non_nullable
          : isPrimary as bool,
      isVerified:
          isVerified == const $CopyWithPlaceholder() || isVerified == null
              ? _value.isVerified
              // ignore: cast_nullable_to_non_nullable
              : isVerified as bool,
      phoneNumber:
          phoneNumber == const $CopyWithPlaceholder() || phoneNumber == null
              ? _value.phoneNumber
              // ignore: cast_nullable_to_non_nullable
              : phoneNumber as String,
    );
  }
}

extension $PhoneNumberCopyWith on PhoneNumber {
  /// Returns a callable class that can be used as follows: `instanceOfclass PhoneNumber extends Equatable.name.copyWith(...)` or like so:`instanceOfclass PhoneNumber extends Equatable.name.copyWith.fieldName(...)`.
  _$PhoneNumberCWProxy get copyWith => _$PhoneNumberCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneNumber _$PhoneNumberFromJson(Map json) => PhoneNumber(
      phoneNumber: json['phoneNumber'] as String,
      id: json['id'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isPrimary: json['isPrimary'] as bool? ?? false,
      isVerified: json['isVerified'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
    );

Map<String, dynamic> _$PhoneNumberToJson(PhoneNumber instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'id': instance.id,
      'isPrimary': instance.isPrimary,
      'isVerified': instance.isVerified,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt.toIso8601String(),
    };
