import 'package:application/application.dart';
import 'package:domain/domain.dart' as d show ThemeMode, ThemeModeX;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFILE'),
        actions: [
          BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  context.read<ThemeBloc>().cycleThemeMode();
                },
                icon: Icon(state.themeMode.icon),
              );
            },
          )
        ],
      ),
      body: const ProfileView(),
    );
  }
}

extension on d.ThemeMode {
  IconData get icon {
    if (isLight) {
      return Icons.brightness_7;
    } else if (isDark) {
      return Icons.brightness_3;
    } else {
      return Icons.brightness_auto;
    }
  }
}
