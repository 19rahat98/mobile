import 'package:flutter/material.dart';
import 'package:presentation/src/presentation.dart';

class Shadows {
  const Shadows(this._context);

  final BuildContext _context;

  List<BoxShadow> get small => [
        BoxShadow(
          color: _context.theme.colorScheme.onSurface.withOpacity(0.12),
          blurRadius: 20,
          spreadRadius: -5,
        ),
      ];

  List<BoxShadow> get medium => [
        BoxShadow(
          color: _context.theme.colorScheme.onSurface.withOpacity(0.12),
          blurRadius: 20,
        ),
      ];

  List<BoxShadow> get large => [
        BoxShadow(
          color: _context.theme.colorScheme.onSurface.withOpacity(0.2),
          blurRadius: 20,
        ),
      ];
}

extension ShadowsExt on BuildContext {
  Shadows get shadows => Shadows(this);
}
