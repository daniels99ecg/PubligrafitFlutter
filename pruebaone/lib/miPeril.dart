// import 'package:flutter/material.dart';

// import 'firebase-services.dart';

// class MyPerfil extends StatefulWidget {
//   const MyPerfil({Key? key});

//  @override
//  State<MyPerfil> createState() => _MyPerfilState();
// }
// class _MyPerfilState extends State<MyPerfil> {
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Perfiles'),
//       ),
//       body: FutureBuilder(
//         future: getPerfil(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('No se encontraron perfiles.'));
//           } else {
//             final perfiles = snapshot.data;
//             return ListView.builder(
//               itemCount: perfiles!.length,
//               itemBuilder: (context, index) {
//                 final perfil = perfiles[index];
//                 return ListTile(
//                   title: Text('Nombre: ${perfil["firstname"]} ${perfil["lastname"]}'),
//                   subtitle: Text('Edad: ${perfil["age"]} - Email: ${perfil["email"]}'),
                  
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
  
// }
