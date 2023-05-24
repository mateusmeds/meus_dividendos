import 'package:flutter/material.dart';
import 'package:my_dividends/widgets/export.dart' show DividendCard;

class DividendInformation extends StatelessWidget {
  DividendInformation({
    Key? key,
    this.dividendsReceived,
    this.dividendsToReceive,
    this.margin,
    this.showTitle = true,
  }) : super(key: key);

  final double? dividendsReceived;
  final double? dividendsToReceive;
  EdgeInsets? margin;
  bool showTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        children: [
          Visibility(
            visible: showTitle,
            child: const Text(
              'Dividendos',
              textAlign: TextAlign.center,
            ),
          ),
          DividendCard(
            value: dividendsReceived,
          ),
          DividendCard(
            value: dividendsToReceive,
            received: false,
          ),
        ],
      ),
    );
  }
}
