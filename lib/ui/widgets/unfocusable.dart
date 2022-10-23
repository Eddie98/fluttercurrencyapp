import 'package:flutter/material.dart';

class UnFocusable extends StatelessWidget {
  final Widget child;

  const UnFocusable({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: child,
      // behavior: HitTestBehavior.opaque,
      // onTap: FocusScope.of(context).unfocus,
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
    );
  }
}
