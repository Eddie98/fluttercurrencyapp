import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testproject/utils/size_config.dart';
import 'package:testproject/view/pages/auth/peanut/bloc/peanut_auth_bloc.dart';

import '../../../../constants/asset_paths.dart';
import '../../../../routes.dart';
import '../../../widgets/snackbar.dart';
import '../../../widgets/unfocusable.dart';

class PeanutAuthPage extends StatefulWidget {
  const PeanutAuthPage({Key? key}) : super(key: key);

  @override
  State<PeanutAuthPage> createState() => _PeanutAuthPageState();
}

class _PeanutAuthPageState extends State<PeanutAuthPage> {
  final formKey = GlobalKey<FormState>();

  late int login;
  late String password;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
          body: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                  left: getPropScreenWidth(35.0),
                  top: size.height * 0.2,
                ),
                child: Text(
                  'Welcome',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: getAdaptiveFontSize(35.0),
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: size.height * 0.4,
                  left: getPropScreenWidth(35.0),
                  right: getPropScreenWidth(35.0),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        // TODO:
                        initialValue: '20234561',
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Login',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onSaved: (value) {
                          if (value != null) login = int.parse(value);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field must not be empty';
                          }
                          return null;
                        },
                      ),
                      sizedBoxHeight(30.0),
                      TextFormField(
                        // TODO:
                        initialValue: 'ladevi31',
                        style: const TextStyle(color: Colors.black),
                        obscureText: true,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onSaved: (value) => password = value ?? '',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field must not be empty';
                          }
                          return null;
                        },
                      ),
                      sizedBoxHeight(40.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: getAdaptiveFontSize(27.0),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          CircleAvatar(
                            radius: getPropScreenWidth(26.0),
                            backgroundColor: const Color(0xff4c505b),
                            child: IconButton(
                              color: Colors.white,
                              onPressed: onSumbit,
                              icon: const Icon(Icons.arrow_forward),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSumbit() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    context.read<PeanutAuthBloc>().add(
          PeanutSignInEvent(login, password, snackbar, goHome),
        );
  }

  void snackbar(String text) => showSnackBar(context, text);
  void goHome() => Navigator.of(context).pushReplacementNamed(Routes.homeLink);
}
