import 'package:presentation/src/routes/path.dart';

class Paths {
  const Paths._();

  static WelcomePath get welcome => WelcomePath();
  static OnboardingPath get onboarding => OnboardingPath();
  static HomePath get home => HomePath();
  Path get pin => Path('pin');
}

class WelcomePath extends Path {
  WelcomePath() : super('welcome');

  Path get login => Path('login', path);
  Path get forgotPassword => Path('forgot_password', path);
  Path get resetPassword => Path('reset_password', path);
  Path get createAccount => Path('create_account', path);
}

class OnboardingPath extends Path {
  OnboardingPath() : super('onboarding');

  Path get pin => Path('pin', path);
  Path get account => Path('account', path);
  Path get allowNotification => Path('allow_notification', path);
}

class HomePath extends PathWithParam {
  HomePath() : super('home', 'homeTab');

  Path get profile => Path('profile', pathWithoutParam);
  Path get feed => Path('feed', pathWithoutParam);
  SplittersPath get splitters => SplittersPath(this);
}

class SplittersPath extends Path {
  SplittersPath(HomePath home) : super('splitters', home.pathWithoutParam);

  Path get create => Path('create', path);
}
