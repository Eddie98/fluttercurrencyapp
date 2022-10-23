import 'package:flutter/material.dart';

import '../../../../utils/size_config.dart';

class TitleWidget extends StatelessWidget {
  final String text;

  const TitleWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(
        left: getPropScreenWidth(35.0),
        right: getPropScreenWidth(35.0),
        top: size.height * 0.15,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey[300],
          fontWeight: FontWeight.bold,
          fontSize: getAdaptiveFontSize(35.0),
        ),
      ),
    );
  }
}
