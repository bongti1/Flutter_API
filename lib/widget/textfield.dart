import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  const Mytextfield(
      {super.key, 
      this.hinttext, 
      this.suffixicon, 
      this.obscuretext,
      required this.TextController,
      }
    );
    // ignore: prefer_typing_uninitialized_variables
    final hinttext;
    // ignore: prefer_typing_uninitialized_variables
    final suffixicon ;
    // ignore: prefer_typing_uninitialized_variables
    final obscuretext;
    // ignore: prefer_typing_uninitialized_variables, non_constant_identifier_names
    final TextController;
  @override
  Widget build(BuildContext context) {
    return  TextField(
      style: const TextStyle(
        fontSize:18,
        color: Colors.white
      ),
      obscureText:obscuretext ,
      controller: TextController,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide:BorderSide(
            width: 2,
            color: Colors.black,
          ),
          borderRadius: BorderRadius.all(Radius.circular(26))
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.all(Radius.circular(26))
        ),
        hintText: hinttext,
        hintStyle: const TextStyle(color: Colors.white),
        suffixIcon: suffixicon,
      ),
    );
  }
}