enum Flavor {
  dev,
  qa,
  uat,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'EcommApp';
      case Flavor.qa:
        return 'EcommApp';
      case Flavor.uat:
        return 'EcommApp';
      case Flavor.prod:
        return 'EcommApp';
      default:
        return 'title';
    }
  }

}
