import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/data/repositories/peanut_repository.dart';
import 'routes.dart';
import 'view/pages/auth/peanut/bloc/peanut_auth_bloc.dart';
import 'view/pages/profile/bloc/profile_info_bloc.dart';
import 'view/pages/profile/profile_info_repository.dart';
import 'view/widgets/disable_glow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ProfileInfoRepository(),
        ),
        RepositoryProvider(
          create: (context) => PeanutRepository(),
        ),
      ],
      child: Builder(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<ProfileInfoBloc>(
              create: (_) => ProfileInfoBloc(
                context.read<ProfileInfoRepository>(),
              ),
            ),
            BlocProvider<PeanutAuthBloc>(
              create: (_) => PeanutAuthBloc(
                context.read<PeanutRepository>(),
              )..add(PeanutInitialRequestAuthEvent()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              splashFactory: InkRipple.splashFactory,
            ),
            scrollBehavior: DisableGlowScrollBehavior(),
            initialRoute: Routes.homeLink,
            onGenerateRoute: Routes.onGenerateRoute,
          ),
        );
      }),
    );
  }
}
