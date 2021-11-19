import 'dart:async';
import 'package:crud_viacep/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  static const Color primaryColor = Color(0xFFc94949);
  bool _setImage = false;
  bool _setVisibility = false;

  @override
  Widget build(BuildContext context) {
    final maxWidth = Utils().maxWidth(context);
    final maxHeight = Utils().maxHeight(context);

    Timer(const Duration(milliseconds: 3200),
        () => setState(() {
          _setImage = true;
          _setVisibility = true;
        }));

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        systemNavigationBarColor: primaryColor,
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: primaryColor,
          body: Column(
            children: [
              SizedBox(
                width: maxWidth,
                height: maxHeight / 2,
                child: (!_setImage)
                    ? Lottie.asset('assets/location_start_view.json')
                    : Lottie.asset('assets/location_static.json'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Visibility(
                  visible: _setVisibility,
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.pushNamed(context, '/signup'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          minimumSize: Size(maxWidth * 0.6, maxHeight * 0.07),
                        ),
                        child: const Text(
                          'SIGN UP',
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // OutlinedButton(
                      //   onPressed: () =>  setState(() {
                      //     _setImage = false;
                      //   }),
                      //   style: OutlinedButton.styleFrom(
                      //     minimumSize: Size(maxWidth * 0.6, maxHeight * 0.07),
                      //     side: const BorderSide(width: 2, color: Colors.white),
                      //   ),
                      //   child: const Text(
                      //     'LOGIN',
                      //     style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 22,
                      //         fontFamily: 'BebasNeue'),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
