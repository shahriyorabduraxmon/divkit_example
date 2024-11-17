import 'package:divkit_project/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:divkit/divkit.dart';

void main() {
  logger
    ..keepLog = kDebugMode
    ..onLog = print;

  debugPrintDivKitViewLifecycle = true;
  debugPrintDivExpressionResolve = true;
  debugPrintDivPerformLayout = false;

  runApp(const MyApp());
}