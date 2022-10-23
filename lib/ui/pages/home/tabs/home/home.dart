import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/constants/constants.dart';
import 'package:testproject/ui/pages/home/tabs/home/widgets/currencies_list.dart';
import 'package:testproject/ui/pages/home/tabs/home/widgets/periods_list.dart';

import '../../../../../constants/colors.dart';
import '../../../../../utils/size_config.dart';
import 'bloc/home_bloc.dart';
import 'widgets/list_item.dart';

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
  final DateTime now = DateTime.now();
  final selectedCurrencies = <String>[];
  late MapEntry<String, Duration> selectedPeriod;

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
      return SizedBox(
        height: constraints.maxHeight,
        child: RefreshIndicator(
          color: Colors.white,
          backgroundColor: Colours.themeColor,
          onRefresh: () async => fetchData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
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
                    fetchData();
                  },
                ),
                sizedBoxHeight(16.0),
                PeriodsList(
                  selectedPeriod: selectedPeriod,
                  callback: (period) {
                    setState(() {
                      selectedPeriod = period;
                    });
                    fetchData();
                  },
                ),
                sizedBoxHeight(22.0),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is HomeErrorState) {
                      return const Center(child: Text(someWentWrong));
                    }
                    if (state is HomeLoadedState) {
                      final signals = state.partnerAnalyticSignals;

                      if (signals.isEmpty) {
                        return const Center(child: Text('No Data'));
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: signals.length,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: defaultHorPadding,
                        ),
                        itemBuilder: (_, index) {
                          return ListItem(signal: signals.elementAt(index));
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void fetchData() {
    context.read<HomeBloc>().add(
          HomeLoadInitialDataEvent(
            currencyPairs: selectedCurrencies.isNotEmpty
                ? selectedCurrencies
                    .reduce((value, element) => '$value,$element')
                : '',
            fromToMap: {
              'from': now.subtract(selectedPeriod.value).second,
              'to': now.second,
            },
            goAuth: widget.goAuth,
            showSnackbar: widget.snackbar,
          ),
        );
  }
}
