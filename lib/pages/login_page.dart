import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projects/components/my_button.dart';
import 'package:projects/components/text_field.dart';
import 'package:projects/helper/help_functions.dart';

class LoginPage extends StatefulWidget {

    final void Function()? onTap;

   const LoginPage({super.key,
   required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    final TextEditingController emailController = TextEditingController();

    final TextEditingController passwordController = TextEditingController();

  //  Login function
  void login() async
  {
  //     show progress
    showDialog(
        context: context,
        builder: (context) => const Center(
          child: LinearProgressIndicator(),
        )
    );

    try{
       await FirebaseAuth.instance.signInWithEmailAndPassword(
           email: emailController.text,
           password: passwordController.text);

       if(context.mounted)
         {
           Navigator.pop(context);
         }


    }on FirebaseAuthException catch (e){
      Navigator.pop(context);
      displayErrorToUser(e.code, context);
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


            //   email TextField
              MyTextField(controller: emailController,
                  hideText: false,
                  hintText: " E-mail"),

              const SizedBox(height: 10),

              // Password Field
              MyTextField(controller: passwordController,
                  hideText: true,
                  hintText: " Password"),


              const SizedBox(height: 10,),

            //   Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary)

                  ),
                ],
              ),


              const SizedBox(height: 25),


            //   Login Button
              MyButton(
                  text: "Login",
                  onTap: login),


              const SizedBox(height: 20),

            //   no account option
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text("Don't have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary)),
                   GestureDetector(
                     onTap: widget.onTap,
                     child: const Text("Register Here", style: TextStyle(
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
