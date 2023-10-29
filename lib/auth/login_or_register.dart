import 'package:flutter/material.dart';
import 'package:projects/pages/login_page.dart';
import 'package:projects/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool whichPage= true;

  void changePage()
  {
    setState(() {
      whichPage= !whichPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(whichPage==true){
      return LoginPage(onTap: changePage);}
    else{
      return RegisterPage(onTap: changePage);}
  }
}
