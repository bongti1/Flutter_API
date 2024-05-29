import 'package:flutter/material.dart';

class Mybutton extends StatelessWidget {
  const Mybutton ({super.key, required this.text});
  final text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 55,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 6, 67, 121),
        borderRadius: BorderRadius.all(Radius.circular(26))
      ),
      child: Center(
        child: Text(text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        )
      ),
    );
  }
}