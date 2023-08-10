import 'package:diabetes_tracker/main.dart';
import 'package:diabetes_tracker/variants/variants.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Variant().configure(VariantTypes.wire);
  runApp(const MyApp());
}
