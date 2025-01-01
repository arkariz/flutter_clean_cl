late ExampleFlavor _flavor;

void setExampleFlavor(ExampleFlavor flavor) {
  _flavor = flavor;
}

ExampleFlavor get exampleFlavorValue {
  return _flavor;
}

abstract class ExampleFlavor {
  String get environtment;
  String get baseUrl;
  String get apikey;
}
