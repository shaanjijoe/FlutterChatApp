import 'package:flutter/material.dart';
import 'package:projects/components/my_drawer.dart';
import 'package:projects/components/my_message_tile.dart';
import 'package:projects/components/my_post_button.dart';
import 'package:projects/components/text_field.dart';
import 'package:projects/database/myfirestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});


  final TextEditingController newPostController = TextEditingController();

  final FirestoreDatabase database = FirestoreDatabase();
  // void logout()
  // {
  //   FirebaseAuth.instance.signOut();
  // }

  void postMessage(){
    if(newPostController.text.isNotEmpty){
        String message = newPostController.text;
        database.addPost(message);
    }

    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('F R I E N D S'),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
        // actions: [
        //   IconButton(onPressed: logout,
        //       icon: const Icon(Icons.logout_rounded)),
        // ],
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                      controller: newPostController,
                      hideText: false,
                      hintText: "Text..."),
                ),
                
              //   Posting Button
                PostButton(onTap: postMessage),
              ],
            ),
          ),

        //   Posts made by users
          StreamBuilder(
              stream: database.getPosts(),
              builder: (context, snapshot) {

              //   Waiting
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: LinearProgressIndicator(),
                  );
                }


                final posts= snapshot.data!.docs;
              //   Current data NULL
                if(snapshot.data==null || posts.isEmpty){
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(25),
                          child: Text("No Posts.."),
                        ),
                      );
                }

              //   Returning actual messages
                return Expanded(
                    child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index){

                          final post = posts[index];
                          
                          return MyMessageTile(
                              message: post['PostedMessages'],
                              subTitle: post['UserEmail']);
                        }
                    )
                );



              }
          ),

        ],
      ),
    );

  }
}
