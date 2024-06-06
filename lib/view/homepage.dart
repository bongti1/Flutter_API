import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mynote_pro/Model/data_modeling.dart';
import 'package:mynote_pro/view/login.dart';
// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RxBool checker = false.obs;
  Future<List<Product>>? fectdata;
  @override
  void initState() {
    fectdata = fectData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          // ignore: use_build_context_synchronously
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
              future: fectdata,
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
              childAspectRatio: 0.6,
            ), 
            itemBuilder: (context, index) {
              final getindex = snapshot.data![index];
              return Card(
                shadowColor: const Color.fromARGB(255, 0, 0, 0),
                surfaceTintColor: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(image: NetworkImage(getindex.image),
                      height: 200,
                      width: 100,
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(getindex.title,
                        maxLines: 2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('\$${getindex.price.toString()}'),
                          Obx(() => IconButton(onPressed: () {
                              checker.value = !checker.value;
                          }, icon:Icon(checker.value == true?Icons.favorite_rounded:Icons.favorite_border_rounded),),),
                          IconButton(onPressed: () {
                          }, icon: const Icon(Icons.local_grocery_store_outlined))
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}