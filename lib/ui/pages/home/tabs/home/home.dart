import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/constants/constants.dart';
import 'package:testproject/ui/pages/home/tabs/home/widgets/currencies_list.dart';
import 'package:testproject/ui/pages/home/tabs/home/widgets/periods_list.dart';

import '../../../../../constants/colors.dart';
import '../../../../../utils/size_config.dart';
import 'bloc/home_bloc.dart';

class HomeTab extends StatefulWidget {
  final void Function({
    bool? isShowPeanutAuthPage,
    bool? isShowPartnerAuthPage,
  }) goAuth;

  final void Function(String text) snackbar;

  const HomeTab({
    super.key,
    required this.goAuth,
    required this.snackbar,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final selectedCurrencies = <String>[];
  String selectedPeriod = '';

  @override
  void initState() {
    super.initState();
    selectedCurrencies.clear();
    selectedCurrencies.addAll(testDefaultCurrencyPairs);

    selectedPeriod = testDefaultPeriod;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colours.themeColor,
        onRefresh: () async {
          context.read<HomeBloc>().add(
                HomeLoadInitialDataEvent(
                  currencyPairs:
                      testDefaultCurrencyPairs.map((e) => '$e, ').toString(),
                  fromToMap: testDefaultFromToMap,
                  goAuth: widget.goAuth,
                  showSnackbar: widget.snackbar,
                ),
              );
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: constraints.maxHeight,
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is HomeErrorState) {
                  return const Center(child: Text(someWentWrong));
                }
                if (state is HomeLoadedState) {
                  final signals = state.partnerAnalyticSignals;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBoxHeight(22.0),
                      CurrenciesList(
                        selectedCurrencies: selectedCurrencies,
                        callback: (currency) {
                          setState(() {
                            if (selectedCurrencies.contains(currency)) {
                              selectedCurrencies.remove(currency);
                            } else {
                              selectedCurrencies.add(currency);
                            }
                          });
                        },
                      ),
                      sizedBoxHeight(22.0),
                      PeriodsList(
                        selectedPeriod: selectedPeriod,
                        callback: (period) {
                          setState(() {
                            selectedPeriod = period;
                          });
                        },
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      );
    });
  }
}
