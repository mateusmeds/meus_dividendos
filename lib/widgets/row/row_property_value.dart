import 'package:flutter/material.dart';

class RowPropertyValue extends StatelessWidget {
  const RowPropertyValue({
    Key? key,
    required this.property,
    required this.value,
    this.propertyFontSize = 12,
    this.valueFontSize = 12,
    this.margin,
  }) : super(key: key);

  final String property;
  final String value;
  final double? propertyFontSize;
  final double? valueFontSize;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            property,
            style: TextStyle(fontSize: propertyFontSize),
          ),
          Text(
            value,
            style: TextStyle(fontSize: valueFontSize),
          ),
        ],
      ),
    );
  }
}
