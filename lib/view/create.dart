import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynote_pro/view/homepage.dart';
import 'package:mynote_pro/view/login.dart';
import 'package:mynote_pro/widget/button.dart';
import 'package:mynote_pro/widget/textfield.dart';

// ignore: must_be_immutable
class CreaeteAccountState extends StatefulWidget {
  const CreaeteAccountState({super.key});
  @override
  State<CreaeteAccountState> createState() => CreaeteAccountStateState();
}

class CreaeteAccountStateState extends State<CreaeteAccountState> {
  RxBool checkvalue = true.obs;
  final EmailController = TextEditingController();
  final PasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus)
          {
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
                            TextController:EmailController ,
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
                          onTap: () async{
                           try {
                              // ignore: unused_local_variable
                              UserCredential credentail = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: EmailController.text.trim(), 
                              password: PasswordController.text.trim(),
                            );
                            if (credentail.user != null)
                            {
                              showDialog(
                                // ignore: use_build_context_synchronously
                                context: context, 
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Firebase Authentication',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: const Text('Create account successful'),
                                    actions: [
                                       TextButton(onPressed: () {
                                        //Get.to(() => const HomePage());
                                        Get.offAll(() => const HomePage());
                                       }, child: const Text('Ok'),
                                      )
                                    ],
                                  );
                                },
                               );
                               EmailController.clear();
                               PasswordController.clear();
                            }
                           } on FirebaseAuthException catch (e) {
                             if(e.code == "email-already-in-use")
                             {
                               showDialog(
                                // ignore: use_build_context_synchronously
                                context: context, 
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Firebase Authentication',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Text('This Email ${EmailController.text} is already exist.'),
                                    actions: [
                                       TextButton(onPressed: () {
                                         Navigator.of(context).pop();
                                       }, child: const Text('Ok'),
                                      )
                                    ],
                                  );
                                },
                               );
                             }
                            else if(e.code == "weak-password")
                            {
                               showDialog(
                                // ignore: use_build_context_synchronously
                                context: context, 
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Firebase Authentication',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: const Text('Please choose a stronger password.'),
                                    actions: [
                                       TextButton(onPressed: () {
                                         Navigator.of(context).pop();
                                       }, child: const Text('Ok'),
                                      )
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
                                    title: const Text('Firebase Authentication',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    content: Text(e.toString()),
                                    actions: [
                                       TextButton(onPressed: () {
                                         Navigator.of(context).pop();
                                       }, child: const Text('Ok'),
                                      )
                                    ],
                                  );
                                },
                               );
                           }
                          },
                          child: const Mybutton(
                            text: 'Sign up',
                          ),
                        ),
                        const SizedBox(height: 20,),
                        const Text('I already have an account.',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        GestureDetector(
                          onTap: () => Get.to(()=>const MyloginState(),),
                          child: const Text('Sign in',
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
              ),
            ]
          ),
        ),
      ),
    );
  }
}