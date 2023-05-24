import 'package:flutter/material.dart';

class RedirectBaseDTO {
  RedirectBaseDTO({
    required this.context,
    this.replace = false,
    this.removeUntil = false,
  });

  BuildContext context;
  bool replace = false;
  bool removeUntil = false;
}
