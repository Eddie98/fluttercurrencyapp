import 'package:flutter/material.dart';

import '../../../../../../models/peanut_accout_info.dart';
import '../../../../../../utils/size_config.dart';

class UpperInfoBlock extends StatelessWidget {
  final PeanutAccountInfo info;
  final String hiddenPhoneNumber;

  const UpperInfoBlock({
    super.key,
    required this.info,
    required this.hiddenPhoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Balance:\n${info.balance}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getAdaptiveFontSize(24.0),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        sizedBoxHeight(16.0),
        Text(
          info.name,
          style: TextStyle(
            fontSize: getAdaptiveFontSize(24.0),
          ),
        ),
        sizedBoxHeight(5.0),
        Text(
          hiddenPhoneNumber,
          style: TextStyle(
            fontSize: getAdaptiveFontSize(20.0),
          ),
        ),
        sizedBoxHeight(5.0),
        Text(
          '${info.country} / ${info.city}',
          style: TextStyle(
            fontSize: getAdaptiveFontSize(14.0),
          ),
        ),
      ],
    );
  }
}
