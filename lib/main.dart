import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/constants/colors.dart';
import 'package:testproject/ui/pages/auth/auth_repository.dart';
import 'routes.dart';
import 'ui/pages/auth/bloc/auth_bloc.dart';
import 'ui/pages/home/home_repository.dart';
import 'ui/pages/home/tabs/home/bloc/home_bloc.dart';
import 'ui/pages/home/tabs/profile/bloc/profile_bloc.dart';
import 'ui/widgets/disable_glow.dart';

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
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => HomeRepository(),
        ),
      ],
      child: Builder(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
              create: (_) => AuthBloc(context.read<AuthRepository>()),
            ),
            BlocProvider<HomeBloc>(
              create: (_) => HomeBloc(context.read<HomeRepository>()),
            ),
            BlocProvider<ProfileBloc>(
              create: (_) => ProfileBloc(context.read<HomeRepository>()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              splashFactory: InkRipple.splashFactory,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                backgroundColor: Colours.themeColor,
                elevation: 2,
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colours.themeColor,
              ),
              progressIndicatorTheme: ProgressIndicatorThemeData(
                color: Colours.themeColor,
              ),
              textTheme: const TextTheme(
                bodyMedium: TextStyle(fontSize: 18.0),
              ),
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
