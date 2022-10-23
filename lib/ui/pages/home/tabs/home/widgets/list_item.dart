import 'package:flutter/cupertino.dart';

import '../../../../../../models/partner_analytic_signal.dart';

class ListItem extends StatelessWidget {
  final PartnerAnalyticSignal signal;

  const ListItem({super.key, required this.signal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(signal.comment),
        Text(signal.pair),
        Text(signal.period),
        Text(signal.actualTime.toString()),
        Text(signal.cmd.toString()),
        Text(signal.id.toString()),
        Text(signal.price.toString()),
        Text(signal.sl.toString()),
        Text(signal.tp.toString()),
        Text(signal.tradingSystem.toString()),
      ],
    );
  }
}
