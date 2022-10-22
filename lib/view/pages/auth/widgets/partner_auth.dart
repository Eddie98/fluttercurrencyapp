import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../utils/size_config.dart';
import 'title.dart';

class PartnerAuthPage extends StatefulWidget {
  final void Function({
    required int login,
    required String password,
  }) onSubmit;

  const PartnerAuthPage({super.key, required this.onSubmit});

  @override
  State<PartnerAuthPage> createState() => _PartnerAuthPageState();
}

class _PartnerAuthPageState extends State<PartnerAuthPage> {
  final formKey = GlobalKey<FormState>();

  late int login;
  late String password;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        const TitleWidget(text: 'Sign in to Partner'),
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
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          formKey.currentState!.save();
                          widget.onSubmit(login: login, password: password);
                        },
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
    );
  }
}
