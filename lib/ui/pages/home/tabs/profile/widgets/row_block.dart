import 'package:flutter/material.dart';

import '../../../../../../models/peanut_accout_info.dart';

class RowBlock extends StatelessWidget {
  final PeanutAccountInfo info;
  final Widget leftWidget;
  final Widget rightWidget;

  const RowBlock({
    super.key,
    required this.info,
    required this.leftWidget,
    required this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [leftWidget, rightWidget],
      ),
    );
  }
}

class RowBlockItem extends StatelessWidget {
  final String title;
  final String value;
  final double width;

  const RowBlockItem({
    super.key,
    required this.title,
    required this.value,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.bodyMedium;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: textTheme,
          )
        ],
      ),
    );
  }
}
