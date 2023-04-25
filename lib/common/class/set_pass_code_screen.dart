import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

abstract class SetPassCodeScreen {
  void setPassCode(
    BuildContext context, {
    required InputController inputController,
    String correctString = '',
    Widget title = const Text('Create your PassCode'),
    Widget confirmTitle = const Text('Enter your confirm PassCode'),
    bool useLandscape = false,
    void Function(String)? didConfirmed,
    Widget? footer,
  }) {
    screenLock(
      context: context,
      correctString: correctString,
      title: title,
      confirmTitle: confirmTitle,
      digits: 6,
      confirmation: true,
      useLandscape: useLandscape,
      inputController: inputController,
      didConfirmed: didConfirmed,
      footer: footer,
    );
  }
}
