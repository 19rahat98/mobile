import 'package:application/application.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:presentation/src/routes/paths.dart';
import 'package:presentation/src/screens/create_account/create_account_screen.dart';
import 'package:presentation/src/screens/create_splitter/create_splitter_screen.dart';
import 'package:presentation/src/screens/forgot_password/forgot_password_screen.dart';
import 'package:presentation/src/screens/home/home_screen.dart';
import 'package:presentation/src/screens/login/login_screen.dart';
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
        path: Paths.home.goPath,
        builder: (_, state) {
          final tab = state.params[Paths.home.param]!;

          return HomeScreen(tab);
        },
        routes: [
          GoRoute(
            path: Paths.home.splitters.create.goPath,
            builder: (_, state) => const CreateSplitterScreen(),
          ),
          GoRoute(
            path: Paths.home.profile.goPath,
            builder: (_, state) => const ProfileScreen(),
          )
        ],
      ),
    ],
    redirect: (state) {
      final subLocation = state.subloc;
      final loggingIn = subLocation.startsWith(Paths.welcome.path);

      // if not logged in, redirect to welcome screen
      // if not there already
      if (!authBloc.state.isAuthenticated) {
        if (loggingIn) {
          return null;
        }

        final from = subLocation != '/' ? '?next=$subLocation' : '';

        return '${Paths.welcome.path}$from';
      }

      // if logged in (and signed in),
      // redirect to home screen
      if (loggingIn) {
        final fromParam = state.queryParams['next'];
        if (fromParam != null) {
          return fromParam;
        } else {
          return '/';
        }
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
