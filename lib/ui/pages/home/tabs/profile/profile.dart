import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/constants.dart';
import 'bloc/profile_bloc.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ProfileErrorState) {
          return const Center(child: Text(someWentWrong));
        }
        if (state is ProfileLoadedState) {
          return Center(
              child: Text(state.peanutLastFourNumbersPhone.toString()));
        }
        return Container();
      },
    );
  }
}
