import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'one_step_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => OneStepPage()));
    });
  }

  @override
  void dispose() {
    // SystemChrome.setEnabledSystemUIMode(
    //     SystemUiMode.manual, SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.red, Colors.blue])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(
              //   Icons.edit,
              //   size: 80,
              //   color: Colors.white,
              // ),
              Image(image: AssetImage('lib/images/wtsda_logo.png')),
              SizedBox(
                height: 20,
              ),
              Text('WTSDA', style: TextStyle(fontSize: 32, color: Colors.white))
            ],
          )),
    );
  }
}
