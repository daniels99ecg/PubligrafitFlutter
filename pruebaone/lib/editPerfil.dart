import 'package:flutter/material.dart';
import 'package:pruebaone/firebase-services.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController firstnameController = TextEditingController(text: "");
  TextEditingController lastnameController = TextEditingController(text: "");
  TextEditingController ageController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController documentoController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    firstnameController.text = arguments["firstname"];
    lastnameController.text = arguments["lastname"];
    ageController.text = arguments["age"];
    emailController.text = arguments["email"];
    passwordController.text = arguments["password"];

    return Scaffold(
      appBar: AppBar(
        // Cambia el color de la barra de aplicación a negro
        title: const Text("Editar Usuario",
            textAlign: TextAlign.center), // Centra el texto del AppBar
        // Centra el título del AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTextField(firstnameController, "firstname"),
            _buildTextField(lastnameController, "Apellido"),
            _buildTextField(ageController, "age"),
            _buildTextField(emailController, "Email"),
            _buildTextField(passwordController, "Nueva contraseña"),
            ElevatedButton(
              onPressed: () async {
                await updateProfile(
                  arguments["uid"],
                  firstnameController.text,
                  lastnameController.text,
                  ageController.text,
                  emailController.text,
                  passwordController.text,
                ).then((_) {
                  Navigator.pop(context);
                });
              },
             
              child: const Text("Actualizar"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
