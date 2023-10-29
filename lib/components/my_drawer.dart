import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout()
  {
    FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        //   Drawer header

          Column(
            children: [
              DrawerHeader(
                  child: Icon(Icons.favorite_sharp,
                    color: Theme.of(context).colorScheme.inversePrimary,)
                  ),

              const SizedBox(height: 25,),

              // Home
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: ListTile(
                      leading: Icon(Icons.home_outlined,
                      color: Theme.of(context).colorScheme.inversePrimary,),

                      title: const Text("H O M E"),
                      onTap: (){
                        Navigator.pop(context);
                      //   Navigate to home page
                        Navigator.pushNamed(context, '/home_page');
                      },
                    ),
                  ),

                  // Profile
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: ListTile(
                      leading: Icon(Icons.person_2,
                        color: Theme.of(context).colorScheme.inversePrimary,),

                      title: const Text("P R O F I L E"),
                      onTap: (){
                        Navigator.pop(context);
                        //   Navigate to home page
                        Navigator.pushNamed(context, '/profile_page');
                      },
                    ),
                  ),


        //   Users
                  Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: ListTile(
                      leading: Icon(Icons.group,
                        color: Theme.of(context).colorScheme.inversePrimary,),

                      title: const Text("U S E R S"),
                      onTap: (){
                        Navigator.pop(context);
                        //   Navigate to home page
                        Navigator.pushNamed(context, '/users_page');
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),




        //   Logout
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              leading: Icon(Icons.group,
                color: Theme.of(context).colorScheme.inversePrimary,),

              title: const Text("L O G O U T"),
              onTap: (){
                Navigator.pop(context);

              //   Logging out
                logout();
              },
            ),
          ),




        ],
      ),
    );
  }
}
