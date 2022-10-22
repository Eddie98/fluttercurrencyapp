import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes.dart';
import '../../../utils/size_config.dart';
import '../auth/peanut/bloc/peanut_auth_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return BlocListener<PeanutAuthBloc, PeanutAuthInitialState>(
      listenWhen: (_, state) => state.isShowAuthPage,
      listener: (_, state) =>
          Navigator.of(context).pushReplacementNamed(Routes.peanutAuthLink),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          // TODO:
          actions: [
            IconButton(
              onPressed: () {
                SharedPreferences.getInstance().then((value) => value.clear());
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        body: Container(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTabIndex,
          selectedItemColor: Colors.amber,
          onTap: _changeTab,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
              backgroundColor: Colors.purple,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.pink,
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
  }
}
