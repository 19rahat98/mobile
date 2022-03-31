import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phone_number.g.dart';

@CopyWith()
@JsonSerializable()
class PhoneNumber extends Equatable {
  const PhoneNumber({
    required this.phoneNumber,
    required this.id,
    required this.createdAt,
    this.isPrimary = false,
    this.isVerified = false,
    this.isActive = true,
  });

  factory PhoneNumber.fromJson(Map srcJson) => _$PhoneNumberFromJson(srcJson);

  final String phoneNumber;
  final String id;
  final bool isPrimary;
  final bool isVerified;
  final bool isActive;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => _$PhoneNumberToJson(this);

  @override
  List<Object> get props => [
        id,
        phoneNumber,
        isPrimary,
        isVerified,
        isActive,
        createdAt,
      ];
}
