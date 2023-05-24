import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({
    Key? key,
    required this.empty,
    this.title,
    this.leading,
    this.titleStyle,
    this.margin,
  }) : super(key: key);

  final bool empty;
  final String? title;
  final EdgeInsets? margin;
  final Widget? leading;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: empty,
      child: Container(
        margin: margin ??
            const EdgeInsets.only(
              top: 15,
            ),
        child: Row(
          children: [
            leading ??
                Icon(
                  Icons.list_alt_outlined,
                  color: Colors.grey[600],
                  size: 20,
                ),
            const SizedBox(
              width: 5,
            ),
            Text(
              title ?? "Nenhum registro encontrado.",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
