import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynote_pro/view/homepage.dart';
import 'package:mynote_pro/view/login.dart';
class MyInitState extends StatefulWidget {
  const MyInitState({super.key});
  @override
  State<MyInitState> createState() => _MyInitStateState();
}

class _MyInitStateState extends State<MyInitState> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 2),
      () {
        ChangeState();
      },
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
            child: Column(
              children: [
                // ignore: prefer_const_constructors
                SizedBox(
                  height: 300,
                ),
                FlutterLogo(
                  style: FlutterLogoStyle.stacked,
                  size: 150,
                  duration: Duration(milliseconds: 3000),
                  textColor: Colors.amberAccent,
                ),
              ],
            ),
          ),
    );
  }
  // ignore: non_constant_identifier_names
  Future<void> ChangeState()async{
    FirebaseAuth.instance.userChanges().listen((User? user) { 
      if(user == null)
      {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => const MyloginState(),
          ),
        );
      }
      else 
      {
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => HomePage(),
          ),
        );
      }
    }
    );
  }
}