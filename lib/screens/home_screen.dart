import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importa el archivo de la pantalla de inicio de sesión
import 'register_screen.dart'; // Importa el archivo de la pantalla de registro

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 10, 173, 37),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Open drawer or menu
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Text(
                'Registrarse',
                style: TextStyle(color: Color.fromARGB(255, 154, 62, 20)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                'Iniciar sesión',
                style: TextStyle(color: Color.fromARGB(255, 30, 174, 69)),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF7F7FD5), Color(0xFF86A8E7), Color(0xFF91EAE4)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bienvenido a\nAgendaPro',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Entendemos lo que son los recordatorios y medicamentos. Nuestra plataforma ha sido diseñada pensando en simplificar el proceso de recordatorio de medicamentos brindándote comodidad y control sobre tu agenda',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 32),
              Text(
                'Nuestros servicios',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              ServiceTile(title: 'Recodatorios'),
              ServiceTile(title: 'Gestión de Agenda'),
              ServiceTile(title: 'Configuración de Perfil'),
              ServiceTile(title: 'Medicamentos'),
              Spacer(),
              Text(
                '¡Organiza tu tiempo, con tranquilidad!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.phone, color: Color.fromARGB(255, 177, 47, 47)),
                    onPressed: () {
                      // Contact action
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.message, color: const Color.fromARGB(255, 208, 87, 87)),
                    onPressed: () {
                      // Contact action
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceTile extends StatelessWidget {
  final String title;

  ServiceTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
