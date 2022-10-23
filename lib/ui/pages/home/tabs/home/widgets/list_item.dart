import 'package:flutter/material.dart';
import 'package:testproject/utils/size_config.dart';

import '../../../../../../models/partner_analytic_signal.dart';

class ListItem extends StatelessWidget {
  final PartnerAnalyticSignal signal;

  const ListItem({super.key, required this.signal});

  static final smallTextStyle = TextStyle(fontSize: getAdaptiveFontSize(12.0));
  static final bigTextStyle = TextStyle(fontSize: getAdaptiveFontSize(14.0));

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6.0,
      margin: EdgeInsets.only(bottom: getPropScreenWidth(22.0)),
      color: Colors.grey[300],
      shadowColor: Colors.grey[300],
      child: Padding(
        padding: EdgeInsets.all(getAdaptiveFontSize(6.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      signal.id.toString(),
                      style: smallTextStyle,
                    ),
                    sizedBoxWidth(8.0),
                    Text(
                      'cmd: ${signal.cmd}',
                      style: smallTextStyle,
                    ),
                  ],
                ),
                Text(
                  signal.pair.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            sizedBoxHeight(6.0),
            Text(
              '${DateTime.fromMillisecondsSinceEpoch(signal.actualTime * 1000)}',
              style: bigTextStyle,
            ),
            sizedBoxHeight(4.0),
            Text(
              'Price ${signal.price}',
              style: bigTextStyle,
            ),
            sizedBoxHeight(18.0),
            Text(
              signal.comment,
              style: bigTextStyle.copyWith(
                fontSize: getAdaptiveFontSize(20.0),
              ),
            ),
            sizedBoxHeight(18.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stop Loss ${signal.sl}',
                      style: smallTextStyle,
                    ),
                    Text(
                      'Take Profit ${signal.tp}',
                      style: smallTextStyle,
                    ),
                  ],
                ),
                Text(
                  'Trading System ${signal.tradingSystem}',
                  style: smallTextStyle,
                ),
              ],
            ),

            // Text('comment: ${signal.comment}'), //
            // Text('pair: ${signal.pair}'),
            // Text('actualTime: ${signal.actualTime}'),
            // Text('cmd: ${signal.cmd}'),
            // Text('id: ${signal.id}'),
            // Text('price: ${signal.price}'),
            // Text('sl: ${signal.sl}'),
            // Text('tp: ${signal.tp}'),
            // Text('tradingSystem: ${signal.tradingSystem}'),
            // sizedBoxHeight(40.0),
          ],
        ),
      ),
    );
  }
}
