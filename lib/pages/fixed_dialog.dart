import 'dart:convert';
import 'package:divkit_project/assets/divkit/app_divkit.dart';
import 'package:divkit_project/configuration/playground_custom_handler.dart';
import 'package:divkit_project/configuration/playground_root_action_handler.dart';
import 'package:divkit_project/configuration/variable.dart';
import 'package:divkit/divkit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FixedDialog extends StatelessWidget {
  const FixedDialog({super.key});

  Future<DivKitData> load() async {
    try {
      final String str = await rootBundle.loadString(
        AppDivkit.fixed,
      );
      final Map<String, dynamic> jsonData = jsonDecode(str);
      final DivKitData? divKitData = await DefaultDivKitData.fromJson(jsonData).build();
      if (divKitData == null) {
        throw Exception("DivKitData could not be created from the JSON data.");
      }

      return divKitData;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: OrientationBuilder(builder: (context, orientation) {
          return FutureBuilder<DivKitData>(
            future: load(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return DivKitView(
                  data: snapshot.requireData,
                  customHandler: PlaygroundAppCustomHandler(),
                  actionHandler: PlaygroundAppRootActionHandler(
                    navigator: navigatorKey,
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        }),
      ),
    );
  }
}