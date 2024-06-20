import 'package:agenda_personalizada/main.dart';
import 'package:flutter/material.dart';
import 'index_screen.dart'; // Asegúrate de importar correctamente index_screen.dart
import 'user_screen.dart'; // Asegúrate de importar correctamente user_screen.dart




class ReminderScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recordatorios'),
      ),
      body: Center(
        child: Text('Contenido de la pantalla de Recordatorios'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Agenda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Recordatorios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Mi perfil',
          ),
        ],
        currentIndex: 1, // El índice de la pestaña seleccionada actualmente
        selectedItemColor: const Color.fromARGB(255, 0, 128, 128),
        onTap: (index) {
          // Manejar el cambio de pestaña
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            // Ya estás en la pantalla de Recordatorios
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserScreen()),
            );
          }
        },
      ),
    );
  }
}
