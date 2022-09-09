import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoButton extends StatelessWidget {
  const CustomCupertinoButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: double.maxFinite,
      color: Colors.lightBlue,
      onPressed: onTap,
      child: const Text('Add'),
    );
  }
}
