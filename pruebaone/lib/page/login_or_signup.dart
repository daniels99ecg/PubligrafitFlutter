import 'package:flutter/widgets.dart';
import 'package:pruebaone/page/login_page.dart';
import 'package:pruebaone/page/sign_up_page.dart';

class LoginAndSingUp extends StatefulWidget{
  const LoginAndSingUp({super.key});

  @override
  State<LoginAndSingUp> createState() => _LoginAndSingUpState();
}

class _LoginAndSingUpState extends State<LoginAndSingUp> {
  
  bool isLoading=true;

  void togglePage(){
    setState(() {
          isLoading=!isLoading;

    });

  }
  
  
  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return  LoginPage(onPressed: togglePage,);
    }else{
       return  SignUp(onPressed: togglePage,);
    }
  }
}