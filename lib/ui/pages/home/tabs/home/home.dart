import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/constants/constants.dart';

import 'bloc/home_bloc.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is HomeErrorState) {
          return const Center(child: Text(someWentWrong));
        }
        if (state is HomeLoadedState) {
          return Center(
              child: Text(state.partnerAnalyticSignals.last.pair.toString()));
        }
        return Container();
      },
    );
  }
}