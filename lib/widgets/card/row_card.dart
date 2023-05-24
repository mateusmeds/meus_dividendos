import 'package:flutter/material.dart';
import 'package:my_dividends/widgets/export.dart' show BaseCard;

class RowCard extends StatelessWidget {
  const RowCard(
    this.title, {
    Key? key,
    this.margin,
    this.backgroundColor,
    this.internalPadding,
    this.trailing,
    this.leading,
    this.titleStyle,
    this.spacingLeadingAndTitle,
    this.onTap,
  }) : super(key: key);

  final EdgeInsets? margin;
  final Color? backgroundColor;
  final EdgeInsets? internalPadding;
  final String title;
  final Widget? trailing;
  final Widget? leading;
  final TextStyle? titleStyle;
  final double? spacingLeadingAndTitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      onTap: onTap,
      margin: margin,
      backgroundColor: backgroundColor,
      internalPadding: internalPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
            ],
          ),
          Visibility(
            visible: trailing != null,
            child: Container(
              child: trailing,
            ),
          )
        ],
      ),
    );
  }
}
