import 'package:diabetes_tracker/variants/variants.dart';

class VariantConfiguration {
  String appName;
  String packageName;
  bool isWire;
  VariantTypes variantType;
  VariantConfiguration({required this.appName, required this.packageName, this.isWire = true,required this.variantType});
}
