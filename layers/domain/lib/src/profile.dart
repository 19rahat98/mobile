import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:domain/src/phone_number.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@CopyWith()
@JsonSerializable()
class Profile extends Equatable {
  const Profile({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.phoneNumber,
  });

  factory Profile.fromJson(Map json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  final String id;
  final String? firstName;
  final String? lastName;
  final String email;
  final PhoneNumber? phoneNumber;

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        lastName,
        phoneNumber,
      ];
}
