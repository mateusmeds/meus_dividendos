import 'package:flutter/material.dart';

class BaseCard extends StatelessWidget {
  const BaseCard({
    Key? key,
    this.margin,
    this.backgroundColor,
    this.internalPadding,
    this.activeShadow = false,
    this.child,
    this.onTap,
  }) : super(key: key);

  final EdgeInsets? margin;
  final Color? backgroundColor;
  final EdgeInsets? internalPadding;
  final bool activeShadow;
  final Widget? child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final boxShadow = activeShadow
        ? [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ]
        : null;
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: onTap,
        child: Ink(
          padding: internalPadding ?? const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            boxShadow: boxShadow,
          ),
          child: child,
        ),
      ),
    );
  }
}
