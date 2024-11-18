import 'dart:async';
import 'package:divkit/divkit.dart';
import 'package:divkit_project/pages/fixed_dialog.dart';
import 'package:divkit_project/pages/input_bottom_sheet.dart';
import 'package:divkit_project/pages/payment_types_page.dart';
import 'package:flutter/material.dart';

const _openScreen = 'open_screen';
const _schemeDivAction = 'div-action';
const _activityTypes = 'payment_types';
const _activityInput = 'inputs';
const _activityDialog = 'dialog';
const _paramActivity = 'activity';


class PlaygroundAppRootActionHandler implements DivActionHandler {
  final _typedHandler = DefaultDivActionHandlerTyped();
  final GlobalKey<NavigatorState> _navigator;

  NavigatorState get _navigationManager =>
      Navigator.of(_navigator.currentContext!);

  PlaygroundAppRootActionHandler({
    required GlobalKey<NavigatorState> navigator,
  }) : _navigator = navigator;

  @override
  bool canHandle(DivContext context, DivActionModel action) {
    if (_typedHandler.canHandle(context, action)) {
      return true;
    }
    final uri = action.url;
    if (uri != null) {
      if (uri.scheme == _schemeDivAction &&
          uri.host == _openScreen &&
          [
            _activityTypes,
            _activityInput,
            _activityDialog,
          ].contains(uri.queryParameters[_paramActivity])) {
        return true;
      } else {
        return false;
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
    if (uri.scheme != _schemeDivAction || uri.host != _openScreen) {
      return false;
    }
    switch (uri.queryParameters[_paramActivity]) {
      case _activityTypes:
        _navigationManager.push(
          MaterialPageRoute(
            builder: (_) => const PaymentTypesPage(),
          ),
        );
        break;
      case _activityInput:
        showCustomBottomSheet(context.buildContext);
        break;
      case _activityDialog:
        _navigationManager.pop();
        showCustomDialog(context.buildContext);
        break;
      default:
        return false;
    }

    return true;
  }
}

void showCustomBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    backgroundColor: Colors.white,
    isScrollControlled: false,
    builder: (context) {
      return const InputBottomSheet();
    },
  );
}

void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: FixedDialog(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      );
    },
  );
}


