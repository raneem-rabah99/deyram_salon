import 'package:flutter/material.dart';
import 'package:deyram_salon/core/theme/app_style.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    required this.onSeeAllTAp,
  });

  final String title;
  final Function() onSeeAllTAp;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Textstyle.text16boldGabarito),
            InkWell(
              onTap: onSeeAllTAp,
              child: Row(
                children: [
                  Text('See All', style: Textstyle.text16c),
                  Icon(Icons.arrow_upward, size: 20),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
