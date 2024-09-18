import 'package:flutter/material.dart';

import '../constants/colors.dart';

class DividerFactory {
  static Widget createDivider(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Divider(thickness: 2, color: paletteYellow),
    );
  }

  static Widget createLabeledDivider(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const Expanded(child: Divider(thickness: 2, color: paletteYellow)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          const Expanded(child: Divider(thickness: 2, color: paletteYellow)),
        ],
      ),
    );
  }
}
