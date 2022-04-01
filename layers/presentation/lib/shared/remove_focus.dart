import 'package:flutter/material.dart';

class RemoveFocus extends StatelessWidget {
  const RemoveFocus({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: ColoredBox(
        color: Colors.transparent,
        child: child,
      ),
    );
  }
}
