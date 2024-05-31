import 'package:flutter/material.dart';

import '../../../infrastructure/theme/themes.dart';

class OverviewMainChartBar extends StatelessWidget {
  const OverviewMainChartBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Overview", style: tsTitleSmallSemibold(darkBlue)),
            ],
          ),
        ],
      ),
    );
  }
}
