import 'package:flutter/material.dart';
import 'package:testproject/constants/constants.dart';
import 'package:testproject/utils/size_config.dart';

class CurrenciesList extends StatelessWidget {
  final List<String> selectedCurrencies;
  final void Function(String) callback;

  const CurrenciesList({
    super.key,
    required this.selectedCurrencies,
    required this.callback,
  });

  static const height = 40.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: defaultHorPadding,
          ),
          child: Text(
            'Select currency pairs',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: getAdaptiveFontSize(20.0),
                ),
          ),
        ),
        sizedBoxHeight(4.0),
        SizedBox(
          width: size.width,
          height: height,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: allCurrenciesList.length,
            padding: const EdgeInsets.symmetric(
              horizontal: defaultHorPadding,
            ),
            itemBuilder: (_, index) {
              final currency = allCurrenciesList.elementAt(index);

              return Container(
                width: 100.0,
                height: height,
                margin: const EdgeInsets.symmetric(horizontal: 0.5),
                decoration: BoxDecoration(
                  color: selectedCurrencies.contains(currency)
                      ? const Color(0xff2d0404)
                      : Colors.grey,
                  borderRadius: BorderRadius.horizontal(
                    left:
                        index == 0 ? const Radius.circular(10.0) : Radius.zero,
                    right: index == allCurrenciesList.length - 1
                        ? const Radius.circular(10.0)
                        : Radius.zero,
                  ),
                ),
                alignment: Alignment.center,
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: getPropScreenWidth(6.0),
                  ),
                  minLeadingWidth: 0.0,
                  horizontalTitleGap: 0.0,
                  minVerticalPadding: 0.0,
                  dense: true,
                  onTap: () => callback(currency),
                  title: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        currency,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 0.8,
                              fontSize: getAdaptiveFontSize(15.0),
                            ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
