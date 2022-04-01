// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_number.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PhoneNumberCWProxy {
  PhoneNumber id(String id);

  PhoneNumber isVerified(bool isVerified);

  PhoneNumber phoneNumber(String phoneNumber);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PhoneNumber(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PhoneNumber(...).copyWith(id: 12, name: "My name")
  /// ````
  PhoneNumber call({
    String? id,
    bool? isVerified,
    String? phoneNumber,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPhoneNumber.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPhoneNumber.copyWith.fieldName(...)`
class _$PhoneNumberCWProxyImpl implements _$PhoneNumberCWProxy {
  final PhoneNumber _value;

  const _$PhoneNumberCWProxyImpl(this._value);

  @override
  PhoneNumber id(String id) => this(id: id);

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
    Object? id = const $CopyWithPlaceholder(),
    Object? isVerified = const $CopyWithPlaceholder(),
    Object? phoneNumber = const $CopyWithPlaceholder(),
  }) {
    return PhoneNumber(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
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
      isVerified: json['isVerified'] as bool? ?? false,
    );

Map<String, dynamic> _$PhoneNumberToJson(PhoneNumber instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'id': instance.id,
      'isVerified': instance.isVerified,
    };
