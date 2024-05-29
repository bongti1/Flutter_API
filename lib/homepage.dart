import 'package:flutter/material.dart';
import 'package:mynote_pro/view/initState.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: MyInitState(),
    );
  }
}