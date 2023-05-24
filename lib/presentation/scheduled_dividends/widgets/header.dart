import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  Header({
    Key? key,
    required this.dividendCount,
  }) : super(key: key);

  int dividendCount;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Icon(
            Icons.calendar_month,
            color: Colors.grey[800],
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            'Dividendos programados ($dividendCount)',
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      ),
    ]);
  }
}
