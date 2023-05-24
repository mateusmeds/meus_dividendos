import 'package:flutter/material.dart';
import 'package:my_dividends/widgets/export.dart' show BaseCard;

class ColumnCard extends StatelessWidget {
  const ColumnCard(
    this.title, {
    Key? key,
    this.margin,
    this.backgroundColor,
    this.internalPadding,
    this.leading,
    this.titleStyle,
    this.spacingLeadingAndTitle,
    this.onTap,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.trailing,
  }) : super(key: key);

  final EdgeInsets? margin;
  final Color? backgroundColor;
  final EdgeInsets? internalPadding;
  final String title;
  final Widget? leading;
  final TextStyle? titleStyle;
  final double? spacingLeadingAndTitle;
  final VoidCallback? onTap;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      onTap: onTap,
      margin: margin,
      backgroundColor: backgroundColor,
      internalPadding: internalPadding,
      child: Column(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: [
          Visibility(
            visible: leading != null,
            child: Container(
              margin: EdgeInsets.only(right: spacingLeadingAndTitle ?? 8),
              child: leading,
            ),
          ),
          Text(
            title,
            style: titleStyle,
          ),
          Visibility(
            visible: trailing != null,
            child: Container(
              child: trailing,
            ),
          ),
        ],
      ),
    );
  }
}
