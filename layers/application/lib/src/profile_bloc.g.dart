// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Ready _$ReadyFromJson(Map json) => _Ready(
      json['profile'] == null ? null : Profile.fromJson(json['profile'] as Map),
    );

Map<String, dynamic> _$ReadyToJson(_Ready instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('profile', instance.profile?.toJson());
  return val;
}
