// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PreProfileCWProxy {
  PreProfile email(String email);

  PreProfile id(String id);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PreProfile(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PreProfile(...).copyWith(id: 12, name: "My name")
  /// ````
  PreProfile call({
    String? email,
    String? id,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPreProfile.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPreProfile.copyWith.fieldName(...)`
class _$PreProfileCWProxyImpl implements _$PreProfileCWProxy {
  final PreProfile _value;

  const _$PreProfileCWProxyImpl(this._value);

  @override
  PreProfile email(String email) => this(email: email);

  @override
  PreProfile id(String id) => this(id: id);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PreProfile(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PreProfile(...).copyWith(id: 12, name: "My name")
  /// ````
  PreProfile call({
    Object? email = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
  }) {
    return PreProfile(
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
    );
  }
}

extension $PreProfileCopyWith on PreProfile {
  /// Returns a callable class that can be used as follows: `instanceOfclass PreProfile extends Equatable.name.copyWith(...)` or like so:`instanceOfclass PreProfile extends Equatable.name.copyWith.fieldName(...)`.
  _$PreProfileCWProxy get copyWith => _$PreProfileCWProxyImpl(this);
}

abstract class _$ProfileCWProxy {
  Profile email(String email);

  Profile firstName(String firstName);

  Profile lastName(String lastName);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Profile(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Profile(...).copyWith(id: 12, name: "My name")
  /// ````
  Profile call({
    String? email,
    String? firstName,
    String? lastName,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfProfile.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfProfile.copyWith.fieldName(...)`
class _$ProfileCWProxyImpl implements _$ProfileCWProxy {
  final Profile _value;

  const _$ProfileCWProxyImpl(this._value);

  @override
  Profile email(String email) => this(email: email);

  @override
  Profile firstName(String firstName) => this(firstName: firstName);

  @override
  Profile lastName(String lastName) => this(lastName: lastName);

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
    Object? lastName = const $CopyWithPlaceholder(),
  }) {
    return Profile(
      email: email == const $CopyWithPlaceholder() || email == null
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String,
      firstName: firstName == const $CopyWithPlaceholder() || firstName == null
          ? _value.firstName
          // ignore: cast_nullable_to_non_nullable
          : firstName as String,
      lastName: lastName == const $CopyWithPlaceholder() || lastName == null
          ? _value.lastName
          // ignore: cast_nullable_to_non_nullable
          : lastName as String,
    );
  }
}

extension $ProfileCopyWith on Profile {
  /// Returns a callable class that can be used as follows: `instanceOfclass Profile extends Equatable implements PreProfile.name.copyWith(...)` or like so:`instanceOfclass Profile extends Equatable implements PreProfile.name.copyWith.fieldName(...)`.
  _$ProfileCWProxy get copyWith => _$ProfileCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreProfile _$PreProfileFromJson(Map json) => PreProfile(
      email: json['email'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$PreProfileToJson(PreProfile instance) =>
    <String, dynamic>{
      'email': instance.email,
      'id': instance.id,
    };

Profile _$ProfileFromJson(Map json) => Profile._(
      id: json['id'] as String,
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      isDetailed: json['isDetailed'] as bool,
    );

Map<String, dynamic> _$ProfileToJson(Profile instance) => <String, dynamic>{
      'isDetailed': instance.isDetailed,
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
    };
