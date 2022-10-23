import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/constants/constants.dart';

import '../../../../../constants/colors.dart';
import '../../../../../utils/size_config.dart';
import 'bloc/promotions_bloc.dart';

class PromotionsTab extends StatelessWidget {
  final void Function({
    bool? isShowPeanutAuthPage,
    bool? isShowPartnerAuthPage,
  }) goAuth;

  final void Function(String text) snackbar;

  const PromotionsTab({
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
          context.read<PromotionsBloc>().add(
                PromotionsLoadInitialDataEvent(
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
            child: BlocBuilder<PromotionsBloc, PromotionsState>(
              builder: (context, state) {
                if (state is PromotionsLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is PromotionsErrorState) {
                  return const Center(child: Text(someWentWrong));
                }
                if (state is PromotionsLoadedState) {
                  // final signals = state.partnerAnalyticSignals;

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
