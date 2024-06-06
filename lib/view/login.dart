import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynote_pro/view/create.dart';
import 'package:mynote_pro/view/homepage.dart';
import 'package:mynote_pro/widget/button.dart';
import 'package:mynote_pro/widget/textfield.dart';

class MyloginState extends StatefulWidget {
  const MyloginState({super.key});

  @override
  State<MyloginState> createState() => _MyloginStateState();
}

class _MyloginStateState extends State<MyloginState> {
  RxBool checkvalue = true.obs;
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight:Radius.circular(244),
                        bottomLeft: Radius.circular(244),
                      ),
                      color: Color.fromARGB(255, 242, 6, 84),
                    ),
                  ),
                  const SizedBox(height: 50,),
                  Container(
                    height: 581,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(214),
                      ),
                      color: Color.fromARGB(255, 242, 5, 84),
                    ),
                     child: Column(
                          children: [
                            const SizedBox(height: 100,),
                            Padding(
                              padding: const EdgeInsets.all(26.0),
                              child: Mytextfield(
                                TextController: EmailController,
                                obscuretext: false,
                                hinttext: 'Email',
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(26.0),
                                child: Obx( () => Mytextfield(
                                    TextController: PasswordController,
                                    obscuretext: checkvalue.value,
                                    hinttext: 'Password',
                                    suffixicon: IconButton(onPressed: () {
                                      checkvalue.value = !checkvalue.value;
                                    }, icon: Icon(checkvalue.value == true?Icons.visibility_off:Icons.visibility,
                                      color: Colors.white,),
                                    ),
                                ), 
                              ),
                            ),
                            const SizedBox(height: 20,),
                            GestureDetector(
                              onTap: ()async {
                                try {
                                  UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: EmailController.text.trim(), 
                                  password: PasswordController.text.trim()
                                );
                                if (credential.user != null )
                                {
                                  showDialog(
                                    // ignore: use_build_context_synchronously
                                    context: context, 
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Firebase Authentication'),
                                        content: const Text('Sign in Successful'),
                                        actions: [
                                          TextButton(onPressed: () {
                                            Get.offAll(() => HomePage());
                                          }, child: const Text('Ok'),),
                                        ],
                                      );
                                    },
                                  );
                                  EmailController.clear();
                                  PasswordController.clear();
                                }
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found')
                                  {
                                    showDialog(
                                    // ignore: use_build_context_synchronously
                                    context: context, 
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Firebase Authentication'),
                                        content: const Text('User not found.'),
                                        actions: [
                                          TextButton(onPressed: () {
                                            Navigator.of(context).pop();
                                          }, child: const Text('Ok'),),
                                        ],
                                      );
                                    },
                                  );
                                  }
                                  else if(e.code == 'wrong-password')
                                  {
                                    showDialog(
                                    // ignore: use_build_context_synchronously
                                    context: context, 
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Firebase Authentication'),
                                        content: const Text('Your password is incorrect.'),
                                        actions: [
                                          TextButton(onPressed: () {
                                            Navigator.of(context).pop();
                                          }, child: const Text('Ok'),),
                                        ],
                                      );
                                    },
                                  );
                                  }
                                } catch(e){
                                  showDialog(
                                    // ignore: use_build_context_synchronously
                                    context: context, 
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Firebase Authentication'),
                                        content:Text(e.toString()),
                                        actions: [
                                          TextButton(onPressed: () {
                                            Navigator.of(context).pop();
                                          }, child: const Text('Ok'),),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Mybutton(
                                text: 'Sign in',
                              ),
                            ),
                            const SizedBox(height: 20,),
                            const Text('I have no an account yet.',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10,),
                            GestureDetector(
                              onTap: () {
                                Get.to(()=>const CreaeteAccountState(),);
                              },
                              child: const Text('Sign up',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16
                                ),
                              ),
                            )
                          ],
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}