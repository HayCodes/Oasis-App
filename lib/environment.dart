import 'dart:io' as io;

typedef AppConfig = ({
  Environment env,
  String baseUrl,
  String stripePublishableKey,
  String publicProxy,
});

AppConfig get appConfig {
  return switch (environment) {
    Environment.prod => (
      env: environment,
      baseUrl: const String.fromEnvironment('BASE_URL'),
      publicProxy: const String.fromEnvironment('PUBLIC_PROXY'),
      stripePublishableKey: const String.fromEnvironment(
        'STRIPE_PUBLISHABLE_KEY_DEV',
      ),
    ),
    Environment.staging => (
      env: environment,
      baseUrl: const String.fromEnvironment('BASE_URL_STAGING'),
      publicProxy: const String.fromEnvironment('PUBLIC_PROXY'),
      stripePublishableKey: const String.fromEnvironment(
        'STRIPE_PUBLISHABLE_KEY_DEV',
      ),
    ),
    _ => (
      env: environment,
      baseUrl: const String.fromEnvironment('BASE_URL_DEV'),
      publicProxy: const String.fromEnvironment('PUBLIC_PROXY'),
      stripePublishableKey: const String.fromEnvironment(
        'STRIPE_PUBLISHABLE_KEY_DEV',
      ),
    ),
  };
}

enum Environment {
  prod,
  dev,
  staging,
  testing;

  static const String _envMode = String.fromEnvironment(
    'ENV_MODE',
    defaultValue: 'dev',
  );

  static Environment _derive() {
    if (io.Platform.environment.containsKey('FLUTTER_TEST')) {
      return testing;
    }

    try {
      return Environment.values.byName(_envMode);
    } catch (e) {
      throw Exception(
        "Invalid runtime environment: '$_envMode'. Available environments: ${values.join(', ')}",
      );
    }
  }

  bool get isDev => this == dev;

  bool get isStaging => this == staging;

  bool get isProd => this == prod;

  bool get isTesting => this == testing;

  bool get isBeta => this == staging;

  bool get isDebugging {
    var condition = false;
    assert(() {
      return condition = true;
    }(), 'Condition must be true');
    return condition;
  }
}

Environment? _environment;

Environment get environment => _environment ??= Environment._derive();
