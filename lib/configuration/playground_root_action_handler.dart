import 'dart:async';
import 'package:divkit/divkit.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const _openScreen = 'open_screen';
const _schemeDivAction = 'div-action';
const _activityDemo = 'demo';
const _activitySamples = 'samples';
const _activityRegression = 'regression';
const _activitySettings = 'settings';
const _paramActivity = 'activity';


class PlaygroundAppRootActionHandler implements DivActionHandler {
  final _typedHandler = DefaultDivActionHandlerTyped();

  PlaygroundAppRootActionHandler({
    required GlobalKey<NavigatorState> navigator,
  });

  @override
  bool canHandle(DivContext context, DivActionModel action) {
    if (_typedHandler.canHandle(context, action)) {
      return true;
    }
    print("nima gap");
    final uri = action.url;
    if (uri != null) {
      print(uri.scheme);
      print(uri.host);
      if (uri.scheme == _schemeDivAction &&
          uri.host == _openScreen &&
          [
            _activityDemo,
            _activitySamples,
            _activityRegression,
            _activitySettings,
          ].contains(uri.queryParameters[_paramActivity])) {
        return true;
      } else {
        return handleUrlAction(context, uri);

      }
    }
    return false;
  }

  @override
  FutureOr<bool> handleAction(
      DivContext context,
      DivActionModel action,
      ) async {
    if (_typedHandler.canHandle(context, action)) {
      return _typedHandler.handleAction(context, action);
    }

    final uri = action.url;
    if (uri == null) {
      return false;
    }

    return handleUrlAction(context, uri);
  }

  bool handleUrlAction(DivContext context, Uri uri) {
    print("salomat");
    if (uri.queryParameters[_paramActivity] == "visit") {
      _launchURL("https://t.me/shahriyor_abduraxmon_projects"); // Telegram URL
      return true;
    }
    return true;
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
