import 'package:flutter/material.dart';
import 'package:my_dividends/widgets/export.dart' show BaseCard;

class RowCardTile extends StatelessWidget {
  const RowCardTile({
    Key? key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.internalPadding,
    this.margin,
    this.backgroundColor,
  }) : super(key: key);

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final EdgeInsets? internalPadding;
  final EdgeInsets? margin;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      margin: margin,
      internalPadding: internalPadding,
      backgroundColor: backgroundColor ?? Colors.grey[300],
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        leading: leading,
        title: title,
        subtitle: subtitle,
        trailing: trailing,
      ),
    );
  }
}
