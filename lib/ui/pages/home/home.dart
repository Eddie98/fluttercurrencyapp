import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproject/ui/pages/home/tabs/home/home.dart';
import 'package:testproject/ui/pages/home/tabs/profile/bloc/profile_bloc.dart';
import 'package:testproject/ui/pages/home/tabs/profile/profile.dart';
import 'package:testproject/ui/pages/home/tabs/promotions/bloc/promotions_bloc.dart';
import 'package:testproject/ui/pages/home/tabs/promotions/promotions.dart';

import '../../../constants/constants.dart';
import '../../../routes.dart';
import '../../../utils/size_config.dart';
import '../../widgets/snackbar.dart';
import '../auth/bloc/auth_bloc.dart';
import 'tabs/home/bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Connectivity connectivity = Connectivity();

  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  late final PageController controller;

  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController();

    initConnectivity();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(updateConnectionStatus);
    asyncmethod();
  }

  @override
  dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }

  void asyncmethod() async {
    final bloc = context.read<AuthBloc>();
    final prefs = await SharedPreferences.getInstance();

    final peanutLogin = prefs.getInt(keyPeanutLogin);
    final peanutToken = prefs.getString(keyPeanutToken);
    final partnerLogin = prefs.getInt(keyPartnerLogin);
    final partnerToken = prefs.getString(keyPartnerToken);

    bloc.add(
      IsShowAuthPageEvent(
        isShowPeanutAuthPage: peanutLogin == null || peanutToken == null,
        isShowPartnerAuthPage: partnerLogin == null || partnerToken == null,
      ),
    );
  }

  void changeTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocListener<AuthBloc, AuthInitialState>(
      listener: (_, state) {
        if (state.isShowPeanutAuthPage || state.isShowPartnerAuthPage) {
          Navigator.of(context).pushReplacementNamed(
            Routes.authLink,
            arguments: {
              'isShowPeanutAuthPage': state.isShowPeanutAuthPage,
              'isShowPartnerAuthPage': state.isShowPartnerAuthPage,
            },
          );
        } else {
          context.read<HomeBloc>().add(
                HomeLoadInitialDataEvent(
                  currencyPairs: testDefaultCurrencyPairs
                      .reduce((value, element) => '$value,$element'),
                  fromToMap: testDefaultFromToMap,
                  goAuth: goAuth,
                  showSnackbar: snackbar,
                ),
              );

          context.read<ProfileBloc>().add(
                ProfileLoadInitialDataEvent(
                  goAuth: goAuth,
                  showSnackbar: snackbar,
                ),
              );

          context
              .read<PromotionsBloc>()
              .add(PromotionsLoadInitialDataEvent(showSnackbar: snackbar));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _selectedTabIndex == 0
                ? 'Home'
                : _selectedTabIndex == 1
                    ? 'Promotions'
                    : 'Profile',
          ),
          actions: [
            IconButton(
              onPressed: () {
                SharedPreferences.getInstance().then((value) => value.clear());
                Navigator.of(context).pushReplacementNamed(Routes.homeLink);
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            HomeTab(
              goAuth: goAuth,
              snackbar: snackbar,
            ),
            PromotionsTab(
              goAuth: goAuth,
              snackbar: snackbar,
            ),
            ProfileTab(
              goAuth: goAuth,
              snackbar: snackbar,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTabIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[500],
          onTap: changeTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.percent),
              label: 'Promotions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  void snackbar(String text) => showSnackBar(context, text);
  void goAuth({
    bool? isShowPeanutAuthPage,
    bool? isShowPartnerAuthPage,
  }) =>
      Navigator.of(context).pushReplacementNamed(
        Routes.authLink,
        arguments: {
          'isShowPeanutAuthPage': isShowPeanutAuthPage ?? false,
          'isShowPartnerAuthPage': isShowPartnerAuthPage ?? false,
        },
      );

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.none) {
      snackbar(noInternet);
    }
  }
}
