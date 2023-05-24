import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_dividends/widgets/export.dart' show BaseCard, RowCardTile;

class DenseCardTile extends StatelessWidget {
  const DenseCardTile({
    Key? key,
    required this.title,
    required this.children,
    this.subtitle,
    this.leading,
    this.trailing,
    this.margin,
    this.internalPadding,
    this.backgroundColor,
    this.childrenMargin,
    this.showDivider = true,
    this.spacingBetweenTitleAndSubtitle,
    this.onTap,
  }) : super(key: key);

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final List<Widget> children;
  final EdgeInsets? margin;
  final EdgeInsets? internalPadding;
  final Color? backgroundColor;
  final EdgeInsets? childrenMargin;
  final bool showDivider;
  final double? spacingBetweenTitleAndSubtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      onTap: onTap,
      margin: margin ??
          const EdgeInsets.symmetric(
            vertical: 6,
          ),
      backgroundColor: backgroundColor ?? Colors.grey[100],
      internalPadding: internalPadding ?? const EdgeInsets.all(12),
      activeShadow: true,
      child: Column(
        children: [
          RowCardTile(
            title: title,
            subtitle: Container(
              margin: EdgeInsets.only(
                top: spacingBetweenTitleAndSubtitle ?? 5,
              ),
              child: subtitle,
            ),
            leading: leading,
            trailing: trailing,
            margin: EdgeInsets.zero,
            internalPadding: EdgeInsets.zero,
            backgroundColor: backgroundColor ?? Colors.grey[100],
          ),
          Visibility(
            visible: showDivider,
            child: Container(
              margin: const EdgeInsets.only(
                top: 5,
              ),
              child: Divider(
                color: Colors.grey[300],
                height: 1,
              ),
            ),
          ),
          Container(
            margin: childrenMargin ?? const EdgeInsets.only(top: 10),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}
