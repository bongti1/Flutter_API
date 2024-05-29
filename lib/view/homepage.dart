import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mynote_pro/view/login.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 62, 107),
        title: const Text('E-Cambodia',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            try {
              showDialog(
                context: context, 
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Firebase Authentication'),
                    content: const Text('Are You Sure that you want to Log out?'),
                    actions: [
                      TextButton(onPressed: () {
                        Navigator.of(context).pop();
                      }, child: const Text('Cancel'),
                      ),
                      TextButton(onPressed: () async{
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const MyloginState(),)
                        );
                      }, child: const Text('Log Out'),
                      ),
                    ],
                  );
                },
              );
            } catch (e) {
              showDialog(
                context: context, 
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Firebase Authentication'),
                    content: Text(e.toString()),
                    actions: [
                      TextButton(onPressed: () {
                        Navigator.of(context).pop();
                      }, child: const Text('Ok'),
                      ),
                    ],
                  );
                },
              );
            }
          }, icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: FectData(), 
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
          {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
                strokeWidth: 5,
              ),
            );
          }
          if(snapshot.hasError)
          {
            return const Center(
              child: Text("Crash an Error while fecting the data from the internet.")
            );
          }
          return GridView.builder(
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
            ), 
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 3,color: Colors.black12),
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(image:NetworkImage(snapshot.data![index]['image']),fit: BoxFit.fill,),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
  Future<List> FectData()async{
    final responce = await http.get(Uri.parse('https://fakestoreapi.com/products'),);
    final data = jsonDecode(responce.body);
    return data;
  }
}