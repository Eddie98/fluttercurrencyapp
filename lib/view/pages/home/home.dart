import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testproject/view/pages/home/tabs/home/home.dart';
import 'package:testproject/view/pages/home/tabs/profile/profile.dart';

import '../../../constants/constants.dart';
import '../../../routes.dart';
import '../../../utils/size_config.dart';
import '../auth/bloc/auth_bloc.dart';
import 'tabs/home/bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final PageController controller;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController();
    asyncmethod();
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
          // TODO: other requests
          context.read<HomeBloc>().add(
                const HomeLoadInitialDataEvent(
                  currencyPairs: testDefaultCurrencyPairs,
                  fromToMap: testDefaultFromToMap,
                ),
              );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_selectedTabIndex == 0 ? 'Home' : 'Profile'),
          // TODO: remove
          actions: [
            IconButton(
              onPressed: () {
                SharedPreferences.getInstance().then((value) => value.clear());
                Navigator.of(context).pushReplacementNamed(Routes.homeLink);
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        // TODO: Pull to refresh
        body: PageView(
          controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeTab(),
            ProfileTab(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTabIndex,
          selectedItemColor: Colors.white,
          onTap: _changeTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
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

  void _changeTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
