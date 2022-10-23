import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/constants/colors.dart';
import 'package:testproject/utils/size_config.dart';

import '../../../../../constants/constants.dart';
import 'bloc/profile_bloc.dart';
import 'widgets/row_block.dart';
import 'widgets/upper_info_bloc.dart';

class ProfileTab extends StatelessWidget {
  final void Function({
    bool? isShowPeanutAuthPage,
    bool? isShowPartnerAuthPage,
  }) goAuth;

  final void Function(String text) snackbar;

  const ProfileTab({
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
          context.read<ProfileBloc>().add(
                ProfileLoadInitialDataEvent(
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
            child: BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ProfileErrorState) {
                  return const Center(child: Text(someWentWrong));
                }
                if (state is ProfileLoadedState) {
                  final info = state.peanutAccountInfo;

                  final rowBlockItemWidth =
                      (constraints.maxWidth / 2) - defaultHorPadding * 2;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sizedBoxHeight(22.0),
                      UpperInfoBlock(
                        info: info,
                        hiddenPhoneNumber: state.peanutLastFourNumbersPhone,
                      ),
                      sizedBoxHeight(52.0),
                      RowBlock(
                        info: info,
                        leftWidget: RowBlockItem(
                          title: 'Address: ',
                          value: info.address,
                          width: rowBlockItemWidth,
                        ),
                        rightWidget: RowBlockItem(
                          title: 'Currency: ',
                          value: info.currency.toString(),
                          width: rowBlockItemWidth,
                        ),
                      ),
                      RowBlock(
                        info: info,
                        leftWidget: RowBlockItem(
                          title: 'Trades count: ',
                          value: info.currentTradesCount.toString(),
                          width: rowBlockItemWidth,
                        ),
                        rightWidget: RowBlockItem(
                          title: 'Trades volume: ',
                          value: info.currentTradesVolume.toString(),
                          width: rowBlockItemWidth,
                        ),
                      ),
                      RowBlock(
                        info: info,
                        leftWidget: RowBlockItem(
                          title: 'Equity: ',
                          value: info.equity.toString(),
                          width: rowBlockItemWidth,
                        ),
                        rightWidget: RowBlockItem(
                          title: 'Free margin: ',
                          value: info.freeMargin.toString(),
                          width: rowBlockItemWidth,
                        ),
                      ),
                      RowBlock(
                        info: info,
                        leftWidget: RowBlockItem(
                          title: 'Is any trades open: ',
                          value: info.isAnyOpenTrades.toString(),
                          width: rowBlockItemWidth,
                        ),
                        rightWidget: RowBlockItem(
                          title: 'Is swap free: ',
                          value: info.isSwapFree.toString(),
                          width: rowBlockItemWidth,
                        ),
                      ),
                      RowBlock(
                        info: info,
                        leftWidget: RowBlockItem(
                          title: 'Leverage: ',
                          value: info.leverage.toString(),
                          width: rowBlockItemWidth,
                        ),
                        rightWidget: RowBlockItem(
                          title: 'Phone hash: ',
                          value: info.phone.toString(),
                          width: rowBlockItemWidth,
                        ),
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
