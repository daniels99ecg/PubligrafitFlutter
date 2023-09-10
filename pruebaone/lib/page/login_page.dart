import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  final void Function()? onPressed;
  const LoginPage({super.key, required this.onPressed});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

final _formKey=GlobalKey<FormState>();
bool isLoading=false;
final TextEditingController _email = TextEditingController();
final TextEditingController _password = TextEditingController();


signInWithEmailAndPassword() async{
  try {
    setState(() {
       isLoading=true;
    });
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _email.text,
    password: _password.text,
  );
   setState(() {
       isLoading=false;
    });
} on FirebaseAuthException catch (e) {
  setState(() {
       isLoading=false;
    });
  if (e.code == 'user-not-found') {
    return ScaffoldMessenger.of(context).showSnackBar(
     const SnackBar(
      content: Text('Usuario incorrecto.')));
    
  } else if (e.code == 'wrong-password') {

    return ScaffoldMessenger.of(context).showSnackBar(
     const SnackBar(
      content: Text('Contraseña incorrecta.')));

    
  }
}
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView(
        
     
          padding: EdgeInsets.all(16.0),
        

          children: [
            Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  SizedBox(height: 90,),
                  Image.network('http://drive.google.com/uc?export=view&id=1Zu2cm69lPkIEu09fqA4wA1B3BTL88v1w', height: 100,),
                const Text('Iniciar Sesión', style: TextStyle(fontSize: 25),),
                  SizedBox(height: 10),
                  TextFormField(
                    controller:_email,
                    validator: (text){
                      if(text == null || text.isEmpty){
                          return 'Email is emply';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: "Correo"),
                  ),
                  TextFormField(
                    controller: _password,
                    validator: (text){
                      if(text == null || text.isEmpty){
                          return 'Password is emply';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(labelText: "Contraseña"),
                  ),
                  SizedBox(height: 16,),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                            signInWithEmailAndPassword();
                        }
                      }, 
                      child:isLoading?
                      const Center(child: CircularProgressIndicator(
                        color: Colors.white,
                      )):
                       const Text('Iniciar Sesión')),
                  ),
                   SizedBox(height: 15,),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: widget.onPressed, 
                      child: const Text('Registrar')),
                  ),
                ],
                ),
            ),
          ],
        ),
        
        );
      
  }
}