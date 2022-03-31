// ignore_for_file: constant_identifier_names

enum Env { DEV, STG, PROD }

extension EnvX on Env {
  bool get isDev => this == Env.DEV;
  bool get isStg => this == Env.STG;
  bool get isProd => this == Env.PROD;
}
