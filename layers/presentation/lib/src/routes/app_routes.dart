import 'dart:math';

import 'package:application/application.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/src/routes/paths.dart';
import 'package:presentation/src/screens/allow_notifications/allow_notifications_screen.dart';
import 'package:presentation/src/screens/create_account/create_account_screen.dart';
import 'package:presentation/src/screens/create_pin/create_pin_screen.dart';
import 'package:presentation/src/screens/create_profile/create_profile_screen.dart';
import 'package:presentation/src/screens/create_splitter/create_splitter_screen.dart';
import 'package:presentation/src/screens/forgot_password/forgot_password_screen.dart';
import 'package:presentation/src/screens/home/home_screen.dart';
import 'package:presentation/src/screens/lock/lock_screen.dart';
import 'package:presentation/src/screens/login/login_screen.dart';
import 'package:presentation/src/screens/onboarding/onboarding_screen.dart';
import 'package:presentation/src/screens/pin/pin_screen.dart';
import 'package:presentation/src/screens/profile/profile_screen.dart';
import 'package:presentation/src/screens/reset_password/reset_password_screen.dart';
import 'package:presentation/src/screens/welcome/welcome_screen.dart';

GoRouter appRoutes({
  required AuthBloc authBloc,
  List<NavigatorObserver>? navigatorObservers,
}) {
  return GoRouter(
    observers: navigatorObservers,
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    routes: [
      GoRoute(
        path: '/',
        redirect: (_) => HomeScreen.tabs.keys.first,
      ),
      GoRoute(
        path: Paths.pin.path,
        builder: (_, state) => const PinScreen(),
      ),
      GoRoute(
        path: Paths.lock.path,
        builder: (_, state) => const LockScreen(),
      ),
      GoRoute(
        path: Paths.welcome.goPath,
        builder: (_, state) => const WelcomeScreen(),
        routes: [
          GoRoute(
            path: Paths.welcome.login.goPath,
            builder: (_, state) => const LoginScreen(),
          ),
          GoRoute(
            path: Paths.welcome.forgotPassword.goPath,
            builder: (_, state) => const ForgotPasswordScreen(),
          ),
          GoRoute(
            path: Paths.welcome.resetPassword.goPath,
            builder: (_, state) => const ResetPasswordScreen(),
          ),
          GoRoute(
            path: Paths.welcome.createAccount.goPath,
            builder: (_, state) => const CreateAccountScreen(),
          ),
        ],
      ),
      GoRoute(
        path: Paths.onboarding.goPath,
        builder: (_, state) => const OnboardingScreen(),
        routes: [
          GoRoute(
            path: Paths.onboarding.account.goPath,
            builder: (_, state) => const CreateProfileScreen(),
          ),
          GoRoute(
            path: Paths.onboarding.pin.goPath,
            builder: (_, state) => const CreatePinScreen(),
          ),
          GoRoute(
            path: Paths.onboarding.allowNotification.goPath,
            builder: (_, state) => const AllowNotificationsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: Paths.home.goPath,
        builder: (_, state) {
          final tab = state.params[Paths.home.param]!;
          final keys = HomeScreen.tabs.keys.toList();
          final tabIndex = keys.indexOf(Paths.home.path(tab));

          return HomeScreen(
            tabIndex: max(0, tabIndex),
            key: state.pageKey,
          );
        },
        routes: [
          GoRoute(
            path: Paths.home.splitters.create.goPath,
            builder: (_, state) => const CreateSplitterScreen(),
          ),
        ],
      ),
      GoRoute(
        path: Paths.profile.goPath,
        builder: (_, state) => const ProfileScreen(),
      ),
    ],
    redirect: (state) {
      final subLocation = state.subloc;
      final onWelcomeScreen = subLocation.startsWith(Paths.welcome.path);
      final onOnboardingScreen = subLocation.startsWith(Paths.onboarding.path);

      // if not logged in, redirect to welcome screen
      // if not there already
      if (!authBloc.state.isAuthenticated) {
        if (onWelcomeScreen || onOnboardingScreen) {
          return null;
        }

        return Paths.welcome.path;
      }

      final authenticatedState = authBloc.state;
      final onLockScreen = subLocation.startsWith(Paths.lock.path);

      if (authenticatedState.isLocked) {
        if (onLockScreen) {
          return null;
        }

        return Paths.lock.path;
      }

      // go to onboarding if needed
      if (authenticatedState.isNeedsOnboarding) {
        if (onOnboardingScreen) {
          return null;
        }

        return Paths.onboarding.path;
      }

      if (onWelcomeScreen || onOnboardingScreen || onLockScreen) {
        return Paths.home.feed.path;
      }

      // no need to redirect
      return null;
    },
    restorationScopeId: 'root',
    debugLogDiagnostics: true,
  );
}

extension GoRouterContextX on BuildContext {
  void pushAndMaintainQuery(String location, {Object? extra}) {
    final router = GoRouter.of(this);

    final routerLoc = router.location;
    if (!routerLoc.contains('?')) {
      return push(location, extra: extra);
    }

    final query = routerLoc.split('?').last;
    return push('$location?$query', extra: extra);
  }

  void goAndMaintainQuery(String location, {Object? extra}) {
    final routerLoc = GoRouter.of(this).location;
    if (!routerLoc.contains('?')) {
      return go(location, extra: extra);
    }

    final query = routerLoc.split('?').last;
    return go('$location?$query', extra: extra);
  }
}
