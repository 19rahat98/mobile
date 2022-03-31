// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:application/application.dart';
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
  late GoRouter router;

  @override
  void initState() {
    super.initState();

    profileBloc = widget.getIt<ProfileBloc>();
    authBloc = widget.getIt<AuthBloc>();

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
      ],
      child: Builder(
        builder: (context) {
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
            // themeMode: appConfig.themeMode.toThemeMode(),
            themeMode: ThemeMode.light,
            // themeMode: ThemeMode.dark,
          );
        },
      ),
    );
  }
}
