import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynote_pro/view/homepage.dart';

class ItemProduct extends StatefulWidget {
  const ItemProduct({super.key});
  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  @override
  Widget build(BuildContext context) {
    Get.put(const HomePage());
    return Scaffold(
      body: FutureBuilder(
        future: const HomePage().FectData(), 
        builder: (context, snapshot) {
          return SafeArea(
            child: Column(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(snapshot.data![snapshot.data!.indexWhere((element) => true)]['image']))
                  ),
                ),
                const SizedBox(height: 30,),
                Text('ID : ${snapshot.data![snapshot.data!.indexWhere((element) => true)]['id'].toString()}',
                style: const TextStyle(fontSize: 12),
                ),
                Text('Title : ${snapshot.data![snapshot.data!.indexWhere((element) => true)]['title'].toString()}',
                style: const TextStyle(fontSize: 12),
                ),
                Text('Price : ${snapshot.data![snapshot.data!.indexWhere((element) => true)]['price'].toString()}',
                style: const TextStyle(fontSize: 2),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}