import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/my_back_button.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  // Current User
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Get user details
  Future<DocumentSnapshot<Map<String,dynamic>>>getUserDetails() async{
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("P R O F I L E"),
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   elevation: 2,
      // ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
        future: getUserDetails(),
        builder: (context,snapshot){

        //   Currently Loading
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return const Center(
                child: LinearProgressIndicator(),
              );
            }

        //   Error
          else if(snapshot.hasError)
            {
              return Text('Error: ${snapshot.error}');
            }

        //   Got data
          else if(snapshot.hasData){
            Map<String,dynamic>? user = snapshot.data!.data();
            return Center(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
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


                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(25)
                      
                    ),
                    padding: const EdgeInsets.all(20),
                    child: const Icon(Icons.person_2, size: 64,),
                  ),

                  // Spacing
                  const SizedBox(height: 24,),


                  Text(user!['username'],
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      )
                    ,),

                  const SizedBox(height: 10,),

                  Text(user['email'],
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),),

                ],
              ),
            );
          }

          else{
            return const Text("No Data");
          }
        },
      ),
    );
  }
}
