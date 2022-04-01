// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:application/application.dart';
import 'package:domain/domain.dart' as domain;
import 'package:eleeos/util/nav_logger.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:presentation/presentation.dart';

class App extends StatefulWidget {
  const App({
    Key? key,
    required this.getIt,
    required this.logger,
  }) : super(key: key);

  final GetIt getIt;
  final Logger logger;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final ProfileBloc profileBloc;
  late final AuthBloc authBloc;
  late final ThemeBloc themeBloc;
  late GoRouter router;

  @override
  void initState() {
    super.initState();

    profileBloc = widget.getIt<ProfileBloc>();
    authBloc = widget.getIt<AuthBloc>();
    themeBloc = widget.getIt<ThemeBloc>();

    router = appRoutes(
      navigatorObservers: [NavLogger(logger: widget.logger)],
      authBloc: authBloc,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: profileBloc),
        BlocProvider.value(value: authBloc),
        BlocProvider.value(value: themeBloc),
      ],
      child: BlocListener<ProfileBloc, ProfileState>(
        listenWhen: (p, c) =>
            // when the pin needs to be created/reset
            c.isPinNeeded ||
            // when states change completely
            (p.runtimeType != c.runtimeType) ||
            // when profile is set to null
            c.profile == null ||
            // when profile was null, but is now set
            // (i.e. user just logged in)
            (p.profile == null && c.profile != null),
        listener: (context, state) {
          if (state.profile == null) {
            authBloc.removeAuthentication();
            return;
          }

          if (state.isOnboardingNeeded) {
            authBloc.authenticate(needsOnboarding: true);
            // needs onboarding if profile is not detailed
          } else if (state.isPinNeeded) {
            authBloc.resetPin();
          } else {
            authBloc.authenticate(
              needsOnboarding: state.profile?.isDetailed == false,
            );
          }
        },
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'Eleeos',
              key: const Key('__app__'),
              restorationScopeId: '__app__',
              debugShowCheckedModeBanner: false,
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate,
              theme: FlexThemeData.light(
                scheme: FlexScheme.blue,
                surfaceMode: FlexSurfaceMode.highScaffoldLowSurfaces,
                blendLevel: 4,
                appBarStyle: FlexAppBarStyle.material,
                appBarOpacity: 0.98,
                tooltipsMatchBackground: true,
                useSubThemes: true,
                visualDensity: FlexColorScheme.comfortablePlatformDensity,
                fontFamily: GoogleFonts.roboto().fontFamily,
                subThemesData: const FlexSubThemesData(
                  bottomNavigationBarOpacity: 0.98,
                  navigationBarOpacity: 0.98,
                  navigationBarMutedUnselectedText: true,
                  navigationBarMutedUnselectedIcon: true,
                  inputDecoratorUnfocusedHasBorder: false,
                  popupMenuOpacity: 0.95,
                ),
              ),
              darkTheme: FlexThemeData.dark(
                scheme: FlexScheme.blue,
                surfaceMode: FlexSurfaceMode.highScaffoldLowSurfaces,
                blendLevel: 4,
                appBarStyle: FlexAppBarStyle.background,
                appBarOpacity: 0.98,
                tooltipsMatchBackground: true,
                useSubThemes: true,
                visualDensity: FlexColorScheme.comfortablePlatformDensity,
                fontFamily: GoogleFonts.roboto().fontFamily,
                subThemesData: const FlexSubThemesData(
                  bottomNavigationBarOpacity: 0.98,
                  navigationBarOpacity: 0.98,
                  navigationBarMutedUnselectedText: true,
                  navigationBarMutedUnselectedIcon: true,
                  inputDecoratorUnfocusedHasBorder: false,
                  popupMenuOpacity: 0.95,
                ),
              ),
              themeMode: state.themeMode.toThemeMode(),
            );
          },
        ),
      ),
    );
  }
}

extension on domain.ThemeMode {
  ThemeMode toThemeMode() {
    switch (this) {
      case domain.ThemeMode.light:
        return ThemeMode.light;
      case domain.ThemeMode.dark:
        return ThemeMode.dark;
      case domain.ThemeMode.system:
        return ThemeMode.system;
    }
  }
}
