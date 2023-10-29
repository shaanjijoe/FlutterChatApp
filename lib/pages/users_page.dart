import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projects/components/my_message_tile.dart';
import 'package:projects/helper/help_functions.dart';

import '../components/my_back_button.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("U S E R S"),
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   elevation: 2,
      // ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (context, snapshot) {

          if(snapshot.hasError){
            displayErrorToUser("Something went wrong", context);
          }


          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: LinearProgressIndicator(),
            );
          }

          if(snapshot.data==null){
            return const Text("No Data");
          }

        //   All users
          final users = snapshot.data!.docs;

          return Column(
            children: [
              // Space
              const Padding(
                padding: EdgeInsets.only(
                  top: 50,
                  left: 25,
                ),
                child: Row(
                  children: [
                    BaskButton(),
                  ],
                ),
              ),

              const SizedBox(height: 25,),

              Expanded(
                child: ListView.builder(
                    itemCount: users.length,
                    padding: const EdgeInsets.all(1),
                    itemBuilder: (context, index) {
                    //   For each user
                      final user= users[index];

                      return MyMessageTile(
                        message: user['username'],
                        subTitle: user['email'],
                      );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}
