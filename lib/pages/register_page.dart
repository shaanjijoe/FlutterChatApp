import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projects/components/my_button.dart';
import 'package:projects/components/text_field.dart';
import 'package:projects/helper/help_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({super.key,
  required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController passwordConfirmController = TextEditingController();

  //  register function
  void register() async
  {
    showDialog(
        context: context,
        builder: (context)=> const Center(
          child: LinearProgressIndicator(),
        )
    );

  //   Password matching
    if(passwordController.text != passwordConfirmController.text) {
      // Stop loading bar
      Navigator.pop(context);
      // Show error message
      displayErrorToUser("Passwords don't match", context);

    }

  //   User creation
        else
        {
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        createUserDoc(userCredential);
        if(context.mounted)  Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);

        displayErrorToUser(e.code, context);
      }
    }
  }

  Future<void>createUserDoc(UserCredential? userCredential) async
  {
    if(userCredential!= null && userCredential.user!=null){
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': userNameController.text
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_box_sharp,
                size:80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),

              const SizedBox(height: 25),
              //   Spacing

              //App name
              const Text(
                'C H I T - C H A T',
                style: TextStyle(fontSize: 20),
              ),


              const SizedBox(height: 50),
              //   Spacing

              //   username TextField
              MyTextField(controller: userNameController,
                  hideText: false,
                  hintText: " UserName"),

              const SizedBox(height: 10),

              //   email TextField
              MyTextField(controller: emailController,
                  hideText: false,
                  hintText: " E-mail"),

              const SizedBox(height: 10),

              // Password Field
              MyTextField(controller: passwordController,
                  hideText: true,
                  hintText: " Password "),


              const SizedBox(height: 10,),

              // Password Field
              MyTextField(controller: passwordConfirmController,
                  hideText: true,
                  hintText: " Confirm Password"),


              const SizedBox(height: 10,),

              // //   Forgot Password
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Text(
              //         "Forgot Password?",
              //         style: TextStyle(
              //             color: Theme.of(context).colorScheme.secondary)
              //
              //     ),
              //   ],
              // ),


              const SizedBox(height: 25),


              //   Login Button
              MyButton(
                  text: "Register",
                  onTap: register),


              const SizedBox(height: 20),

              //   no account option
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Have an account?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary)),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text("Login Here", style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),),
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
