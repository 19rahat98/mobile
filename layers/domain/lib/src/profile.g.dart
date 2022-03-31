// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ProfileCWProxy {
  Profile email(String email);

  Profile firstName(String? firstName);

  Profile id(String id);

  Profile lastName(String? lastName);

  Profile phoneNumber(PhoneNumber? phoneNumber);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Profile(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Profile(...).copyWith(id: 12, name: "My name")
  /// ````
  Profile call({
    String? email,
    String? firstName,
    String? id,
    String? lastName,
    PhoneNumber? phoneNumber,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProfile.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProfile.copyWith.fieldName(...)`
class _$ProfileCWProxyImpl implements _$ProfileCWProxy {
  final Profile _value;

  const _$ProfileCWProxyImpl(this._value);

  @override
  Profile email(String email) => this(email: email);

  @override
  Profile firstName(String? firstName) => this(firstName: firstName);

  @override
  Profile id(String id) => this(id: id);

  @override
  Profile lastName(String? lastName) => this(lastName: lastName);

  @override
  Profile phoneNumber(PhoneNumber? phoneNumber) =>
      this(phoneNumber: phoneNumber);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Profile(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Profile(...).copyWith(id: 12, name: "My name")
  /// ````
  Profile call({
    Object? email = const $CopyWithPlaceholder(),
    Object? firstName = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? lastName = const $CopyWithPlaceholder(),
    Object? phoneNumber = const $CopyWithPlaceholder(),
  }) {
    return Profile(
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      firstName: firstName == const $CopyWithPlaceholder()
          ? _value.firstName
          // ignore: cast_nullable_to_non_nullable
          : firstName as String?,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      lastName: lastName == const $CopyWithPlaceholder()
          ? _value.lastName
          // ignore: cast_nullable_to_non_nullable
          : lastName as String?,
      phoneNumber: phoneNumber == const $CopyWithPlaceholder()
          ? _value.phoneNumber
          // ignore: cast_nullable_to_non_nullable
          : phoneNumber as PhoneNumber?,
    );
  }
}

extension $ProfileCopyWith on Profile {
  /// Returns a callable class that can be used as follows: `instanceOfclass Profile extends Equatable.name.copyWith(...)` or like so:`instanceOfclass Profile extends Equatable.name.copyWith.fieldName(...)`.
  _$ProfileCWProxy get copyWith => _$ProfileCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Profile _$ProfileFromJson(Map json) => Profile(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      phoneNumber: json['phoneNumber'] == null
          ? null
          : PhoneNumber.fromJson(json['phoneNumber'] as Map),
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) {
  final val = <String, dynamic>{
    'id': instance.id,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('firstName', instance.firstName);
  writeNotNull('lastName', instance.lastName);
  val['email'] = instance.email;
  writeNotNull('phoneNumber', instance.phoneNumber?.toJson());
  return val;
}
