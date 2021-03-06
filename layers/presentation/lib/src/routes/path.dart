import 'package:flutter/material.dart';

class Path {
  Path(this._name, [String? path]) : _path = path != null ? '$path/' : '';
  static PathWithParam param(
    String name,
    String param, {
    String? path,
  }) =>
      PathWithParam(name, param, path: path);

  final String _name;
  final String _path;

  String get path {
    final initialSep = _path.startsWith('/') ? '' : '/';

    return '$initialSep$_path$_name';
  }

  String get goPath => _isTopLevel(path, _path) ? '/$_name' : _name;
}

class PathWithParam {
  PathWithParam(
    String name,
    this.param, {
    String? path,
  })  : _name = name,
        _path = path != null ? '$path/' : '',
        assert(
          !param.startsWith(':'),
          'Parameter name cannot start with ":"',
        );

  final String _path, _name;
  final String param;

  String get pathWithoutParam {
    final initialSep = _path.startsWith('/') ? '' : '/';

    return '$initialSep$_path$_name';
  }

  String path(String param) {
    final initialSep = _path.startsWith('/') ? '' : '/';

    return '$initialSep$_path$_name/$param';
  }

  String get _paramName => ':$param';

  String get goPath {
    final initialSep = _isTopLevel(path(_paramName), _path) ? '/' : '';

    return '$initialSep$_name/$_paramName';
  }
}

bool _isTopLevel(String path, String ogPath) {
  if (ogPath.isNotEmpty) {
    return false;
  }

  final segments = path.split('/');

  if (segments.length <= 2) {
    return true;
  } else if (segments.last.startsWith(':')) {
    return true;
  } else {
    return false;
  }
}

class ScreenTab {
  const ScreenTab({
    required this.name,
    required this.builder,
    this.icon,
  });

  final String name;
  final Widget Function(BuildContext context) builder;
  final Widget Function(BuildContext context)? icon;
}
