import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproject/ui/pages/auth/widgets/peanut_auth.dart';
import 'package:testproject/utils/size_config.dart';

import '../../../constants/asset_paths.dart';
import '../../../constants/constants.dart';
import '../../../routes.dart';
import '../../widgets/snackbar.dart';
import '../../widgets/unfocusable.dart';
import 'bloc/auth_bloc.dart';
import 'widgets/partner_auth.dart';

class AuthPage extends StatefulWidget {
  final bool isShowPeanutAuthPage;
  final bool isShowPartnerAuthPage;

  const AuthPage({
    Key? key,
    required this.isShowPeanutAuthPage,
    required this.isShowPartnerAuthPage,
  }) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final Connectivity connectivity = Connectivity();

  late StreamSubscription<ConnectivityResult> connectivitySubscription;
  late final PageController controller;
  final pages = <Widget>[];

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController();

    asyncmethod();

    initConnectivity();
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen(updateConnectionStatus);

    if (widget.isShowPeanutAuthPage) {
      pages.add(PeanutAuthPage(onSubmit: onSumbit));
    }
    if (widget.isShowPartnerAuthPage) {
      pages.add(PartnerAuthPage(onSubmit: onSumbit));
    }
  }

  void asyncmethod() async {
    final navigator = Navigator.of(context);
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

    if (peanutLogin != null &&
        peanutToken != null &&
        partnerLogin != null &&
        partnerToken != null) {
      navigator.pushReplacementNamed(Routes.homeLink);
    }
  }

  @override
  dispose() {
    super.dispose();
    connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return UnFocusable(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(loginBackgroundImg),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: PageView(
            controller: controller,
            onPageChanged: (page) => setState(() => currentPage = page),
            children: pages,
          ),
        ),
      ),
    );
  }

  void nextPage() => controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

  void onSumbit({
    required int login,
    required String password,
  }) async {
    final bloc = context.read<AuthBloc>();

    if (pages.length == 1) {
      if (widget.isShowPeanutAuthPage) {
        bloc.add(PeanutSignInEvent(login, password, snackbar, goHome));
      } else {
        bloc.add(PartnerSignInEvent(login, password, snackbar, goHome));
      }
    } else {
      if (currentPage == 0) {
        bloc.add(PeanutSignInEvent(login, password, snackbar));
        nextPage();
      } else {
        bloc.add(PartnerSignInEvent(login, password, snackbar, goHome));
      }
    }
  }

  void snackbar(String text) => showSnackBar(context, text);
  void goHome() => Navigator.of(context).pushReplacementNamed(Routes.homeLink);

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
