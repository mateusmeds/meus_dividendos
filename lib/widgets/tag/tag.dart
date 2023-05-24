import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  const Tag(
    this.tag, {
    Key? key,
    this.textStyle,
    this.textColor,
    this.tagColor,
    this.padding,
    this.fontSize,
    this.borderRadius,
  }) : super(key: key);

  final String tag;
  final TextStyle? textStyle;
  final Color? textColor;
  final Color? tagColor;
  final EdgeInsets? padding;
  final double? fontSize;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: tagColor ?? Colors.green[100],
        borderRadius: BorderRadius.circular(borderRadius ?? 50),
      ),
      child: Text(
        tag,
        style: textStyle ??
            TextStyle(
              color: textColor,
              fontSize: fontSize,
            ),
      ),
    );
  }
}
