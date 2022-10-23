import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/constants/constants.dart';

import '../../../../../constants/colors.dart';
import '../../../../../utils/size_config.dart';
import 'bloc/home_bloc.dart';

class HomeTab extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return RefreshIndicator(
        color: Colors.white,
        backgroundColor: Colours.themeColor,
        onRefresh: () async {
          context.read<HomeBloc>().add(
                HomeLoadInitialDataEvent(
                  currencyPairs: testDefaultCurrencyPairs,
                  fromToMap: testDefaultFromToMap,
                  goAuth: goAuth,
                  showSnackbar: snackbar,
                ),
              );
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: getPropScreenWidth(defaultHorPadding),
          ),
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
