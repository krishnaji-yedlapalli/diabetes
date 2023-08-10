import 'package:diabetes_tracker/utils/helper_methods.dart';
import 'package:diabetes_tracker/variants/variant_config.dart';

enum VariantTypes { wire, simpsons }

class Variant {
  static final Variant _singleton = Variant._internal();

  factory Variant() {
    return _singleton;
  }

  Variant._internal();

  VariantConfiguration? varConfig;

  configure(VariantTypes type) {
    switch (type) {
      case VariantTypes.wire:
        varConfig = wireCharConfigDetails;
        break;
      case VariantTypes.simpsons:
        varConfig = simpsonsCharConfigDetails;
        break;
      default:
        varConfig = wireCharConfigDetails;
    }
  }

  get wireCharConfigDetails => VariantConfiguration(
      appName: 'Wire Character',
      packageName: 'com.sample.wireviewer',
      variantType: VariantTypes.wire);

  get simpsonsCharConfigDetails => VariantConfiguration(
      appName: 'Simpsons Character',
      packageName: 'com.sample.simpsonsviewer',
      variantType: VariantTypes.simpsons,
      isWire: false);
}
