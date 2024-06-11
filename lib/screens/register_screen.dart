import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF7F7FD5), Color(0xFF86A8E7), Color(0xFF91EAE4)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(32.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Regístrate',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Crea tu cuenta ahora',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 32),
                  _buildTextField(Icons.person, 'Nombre Completo', controller: nameController),
                  SizedBox(height: 16),
                  _buildDropdownField('Edad', controller: ageController),
                  SizedBox(height: 16),
                  _buildTextField(null, 'Estatura (cm)', keyboardType: TextInputType.number, controller: heightController),
                  SizedBox(height: 16),
                  _buildTextField(null, 'Peso (kg)', keyboardType: TextInputType.number, controller: weightController),
                  SizedBox(height: 16),
                  _buildTextField(Icons.email, 'Correo Electrónico', controller: emailController),
                  SizedBox(height: 16),
                  _buildTextField(Icons.lock, 'Contraseña', obscureText: true, controller: passwordController),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _register(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 64.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: Colors.amber,
                    ),
                    child: Text(
                      'Regístrate',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '¿Ya tienes una cuenta? ',
                        style: TextStyle(color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        child: Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: Text(
                      'Inicio',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(IconData? icon, String hintText, {bool obscureText = false, TextInputType? keyboardType, required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: icon != null ? Icon(icon, color: Colors.white) : null,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor completa este campo';
        }
        return null;
      },
    );
  }

  Widget _buildDropdownField(String hintText, {required TextEditingController controller}) {
    return DropdownButtonFormField<int>(
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.2),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
      ),
      dropdownColor: Colors.white,
      style: TextStyle(color: Colors.white),
      items: List.generate(100, (index) => index + 1).map((value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(
            value.toString(),
            style: TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
      onChanged: (value) {
        controller.text = value.toString();
      },
      validator: (value) {
        if (value == null) {
          return 'Por favor selecciona una edad';
        }
        return null;
      },
    );
  }

  Future<void> _register(BuildContext context) async {
    final String nombre = nameController.text;
    final int edad = int.parse(ageController.text);
    final int estatura = int.parse(heightController.text);
    final int peso = int.parse(weightController.text);
    final String correo = emailController.text;
    final String contrasena = passwordController.text;

    try {
      final response = await http.post(
        Uri.parse('http://localhost/Agenda_pro/usuario.php'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'nombre': nombre, // Corrección aquí
          'edad': edad,
          'estatura': estatura,
          'peso': peso,
          'correo': correo, // Corrección aquí
          'contrasena': contrasena, // Corrección aquí
        }),
      );

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        _showErrorDialog(context, 'Error al registrar');
      }
    } catch (e) {
      _showErrorDialog(context, 'Error al registrar');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
