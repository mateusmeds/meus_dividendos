import 'package:flutter/material.dart';
import 'package:my_dividends/widgets/export.dart' show BaseCard;

class ExpansionCardTile extends StatelessWidget {
  ExpansionCardTile({
    Key? key,
    required this.title,
    this.children,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.internalPadding,
    this.margin,
    this.backgroundColor,
    this.spacingBetweenTitleAndSubtitle,
    this.childrenPadding,
  }) : super(key: key);

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  EdgeInsets? internalPadding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final List<Widget>? children;
  final double? spacingBetweenTitleAndSubtitle;
  EdgeInsets? childrenPadding;

  @override
  Widget build(BuildContext context) {
    internalPadding ??= const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 5,
    );
    childrenPadding ??= const EdgeInsets.all(
      12,
    );
    return BaseCard(
      activeShadow: true,
      margin: margin,
      internalPadding: EdgeInsets.zero,
      backgroundColor: backgroundColor ?? Colors.grey[100],
      child: ExpansionTile(
        tilePadding: internalPadding,
        leading: leading,
        title: title,
        subtitle: Container(
          margin: EdgeInsets.only(
            top: spacingBetweenTitleAndSubtitle ?? 5,
          ),
          child: subtitle,
        ),
        trailing: trailing,
        children: children ?? const [],
        childrenPadding: childrenPadding,
      ),
    );
  }
}
