import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@CopyWith()
@JsonSerializable()
class PreProfile extends Equatable {
  const PreProfile({
    required this.email,
    required this.id,
  });

  factory PreProfile.fromJson(Map<String, dynamic> json) {
    if (json['isDetailed'] == true) {
      return _$ProfileFromJson(json);
    } else {
      return _$PreProfileFromJson(json);
    }
  }

  final String email;
  final String id;

  Map<String, dynamic> toJson() => _$PreProfileToJson(this);

  bool get isDetailed => false;
  // will always throw
  Profile asDetailed() => this as Profile;

  @override
  List<Object?> get props => [email];
}

@CopyWith()
@JsonSerializable(constructor: '_')
class Profile extends Equatable implements PreProfile {
  const Profile({
    required this.email,
    required this.firstName,
    required this.lastName,
  })  :
        // id can only be set using [fromJson] (server)
        id = 'Fake-ID',
        isDetailed = true;

  const Profile._({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isDetailed,
  });

  factory Profile.fromJson(Map json) => _$ProfileFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  @override
  Profile asDetailed() => this;

  @override
  final bool isDetailed;
  @override
  final String id;
  final String firstName;
  final String lastName;

  @override
  final String email;

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        isDetailed,
      ];
}
