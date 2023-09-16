import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

import 'firebase-services.dart';
import 'main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Raleway',
      ),
      debugShowCheckedModeBanner: false,
      home: const RegisterPage(title: 'Flutter Demo Home Page'),
    );
  }
}

enum SinginCharacter { femenino, masculino }

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.title});
  final String title;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  SinginCharacter? _sex = SinginCharacter.femenino;

  String _nombre = '';
  final _formKey = GlobalKey<FormState>();
  String _password = '';

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 40, left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/");
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: const Text(
                'Registrarse',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text('¡Ya puedes registrarte, bienvenido!'),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: TextFormField(
                          controller: _firstNameController,
                          decoration: InputDecoration(
                              hintText: 'Nombre',
                              hintStyle:
                                  const TextStyle(fontWeight: FontWeight.w600),
                              fillColor: Colors.grey.shade200,
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              filled: true),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Por favor ingrese su nombre';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              _nombre = value.toString();
                            });
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          controller: _lastNameController,
                          decoration: InputDecoration(
                              hintText: 'Apellidos',
                              hintStyle:
                                  const TextStyle(fontWeight: FontWeight.w600),
                              fillColor: Colors.grey.shade200,
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              filled: true),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor digite su apellido';
                            }
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              hintText: 'Correo',
                              hintStyle:
                                  const TextStyle(fontWeight: FontWeight.w600),
                              fillColor: Colors.grey.shade200,
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              filled: true),
                          validator: (value) {
                            String pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regExp = RegExp(pattern);
                            if (value!.isEmpty) {
                              return "El correo es necesario";
                            } else if (!regExp.hasMatch(value)) {
                              return "Correo invalido";
                            } else {
                              return null;
                            }
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              _password = value;
                            });
                          },
                          decoration: InputDecoration(
                              hintText: 'Contraseña',
                              hintStyle:
                                  const TextStyle(fontWeight: FontWeight.w600),
                              fillColor: Colors.grey.shade200,
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              filled: true),
                          validator: (value) {
                            String pattern =
                                r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{3,}$';
                            RegExp regExp = RegExp(pattern);
                            if (value!.isEmpty) {
                              return "La contraseña es necesaria";
                            } else if (!regExp.hasMatch(value)) {
                              return "La contraseña debe tener al menos 8 caracteres, 1 letra mayúscula, 1 minúscula y 1 número. Además puede contener caracteres especiales.";
                            } else {
                              return null;
                            }
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: 'Confirmar contraseña',
                              hintStyle:
                                  const TextStyle(fontWeight: FontWeight.w600),
                              fillColor: Colors.grey.shade200,
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, style: BorderStyle.none),
                              ),
                              filled: true),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            if (value != _password) {
                              return 'Las contraseñas no coinciden';
                            }
                            return null;
                          },
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final firstName = _firstNameController.text;
                                  final lastName = _lastNameController.text;
                                  final age = _ageController.text;
                                  final email = _emailController.text;
                                  final password = _passwordController.text;
                                  await adUsers(firstName, lastName, age, email,
                                      password).then((_) => _enviarCorreo(_emailController.text));
                                  Navigator.pushNamed(context, "/");
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Usuario agregado con éxito'),
                                    ),
                                  );

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const <Widget>[
                                        Icon(
                                          Icons.check_circle,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Usuario registrado correctamente",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                        )
                                      ],
                                    ),
                                    duration:
                                        const Duration(milliseconds: 2000),
                                    width: 300,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 10),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(3.0),
                                    ),
                                    backgroundColor:
                                        const Color.fromARGB(255, 12, 195, 106),
                                  ));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 67, 67,
                                    248), // background (button) color
                                foregroundColor:
                                    Colors.white, // foreground (text) color
                              ),
                              child: const Text(
                                'Registrarse',
                                style: TextStyle(fontSize: 20),
                              )),
                        )),
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}

Future<void> _enviarCorreo(String recipientEmail) async {
    String username = 'decruz82@misena.edu.co'; // Reemplaza con tu dirección de correo
    String password = 'uphxfykntnmhxcut'; // Reemplaza con tu contraseña de correo

    final smtpServer = gmail(username, password);

    // Create our message.
    final message = Message()
      ..from = Address(username, 'Automático')
      ..recipients.add(recipientEmail)
      ..ccRecipients.addAll([recipientEmail, recipientEmail])
      ..bccRecipients.add(Address(recipientEmail))
      ..subject = '¡Bienvenido a la aplicación!'
      ..html = 'Hola, $recipientEmail, ¡te has registrado en nuestra aplicación!';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }

    var connection = PersistentConnection(smtpServer);

    // Send the first message
    await connection.send(message);

    // Close the connection
    await connection.close();
 } 
