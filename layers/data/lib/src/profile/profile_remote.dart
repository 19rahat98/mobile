import 'package:data/src/profile/i_profile_repos.dart';
import 'package:data/src/util/request_result.dart';
import 'package:domain/domain.dart';

class ProfileRemote extends IProfileRemote {
  @override
  Future<RequestResult<PreProfile>> login(String email, String password) async {
    return RequestResult.success(
      Profile(
        id: 'id',
        email: email,
        firstName: 'firstName',
        lastName: 'lastName',
        phoneNumber: const PhoneNumber(
          phoneNumber: 'phoneNumber',
          id: 'id',
        ),
      ),
    );
  }

  @override
  Future<RequestResult<void>> logout() async {
    return const RequestResult.success(null);
  }

  @override
  Future<RequestResult<PreProfile?>> profile(String id) async {
    return const RequestResult.success(null);
  }

  @override
  Future<RequestResult<Profile>> update(Profile profile) async {
    return RequestResult.success(profile);
  }

  @override
  Future<RequestResult<PreProfile>> create(
    String email,
    String password,
  ) async {
    return RequestResult.success(PreProfile(email: email, id: 'id'));
  }
}
