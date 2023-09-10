
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pruebas extends StatelessWidget{
   Pruebas({super.key});
final User = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
appBar: AppBar(
  
  title: Text('Editar Perfil'),
  actions: [
    IconButton(
      onPressed: (){},
       icon: const Icon(Icons.login))
  ],
),
body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(User!.email.toString()),
      
    ],
  )
),
   );
  }

}