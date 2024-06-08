import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agenda Pro',
      theme: ThemeData(
        primaryColor: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> data = [];
  bool isLoading = false;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    getData();  // Llama a getData cuando se inicia el estado
  }

  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse('http://localhost/Agenda_Pro/api.php'),
        headers: {"Accept": "application/json"},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          data = responseData;
        });
        print('Data received: $data');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> createData(Map<String, dynamic> newRecord) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost/Agenda_Pro/api.php'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(newRecord),
      );

      if (response.statusCode == 200) {
        getData();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> updateData(Map<String, dynamic> updatedRecord) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.put(
        Uri.parse('http://localhost/Agenda_Pro/api.php'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(updatedRecord),
      );

      if (response.statusCode == 200) {
        getData();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteData(int idAgenda) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.delete(
        Uri.parse('http://localhost/Agenda_Pro/api.php'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'ID_Agenda': idAgenda}),
      );

      if (response.statusCode == 200) {
        getData();
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showEditDialog(Map<String, dynamic> record) {
    TextEditingController nombreController = TextEditingController(text: record['Nombre_Recordatorio']);
    TextEditingController descripcionController = TextEditingController(text: record['Descripcion']);
    TextEditingController fechaController = TextEditingController(text: record['Fecha']);
    TextEditingController horaController = TextEditingController(text: record['Hora']);
    String tipo = record['Tipo'];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Actualizar Recordatorio'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Nombre Recordatorio'),
                controller: nombreController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Descripción'),
                controller: descripcionController,
              ),
              TextField(
                readOnly: true,
                controller: fechaController,
                decoration: InputDecoration(labelText: 'Fecha'),
                onTap: () => _selectDate(context, fechaController),
              ),
              TextField(
                readOnly: true,
                controller: horaController,
                decoration: InputDecoration(labelText: 'Hora'),
                onTap: () => _selectTime(context, horaController),
              ),
              DropdownButton<String>(
                value: tipo,
                onChanged: (String? newValue) {
                  setState(() {
                    tipo = newValue!;
                  });
                },
                items: <String>['Urgente', 'Importante', 'Poca Importancia']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                updateData({
                  'ID_Agenda': record['ID_Agenda'],
                  'Nombre_Recordatorio': nombreController.text,
                  'Descripcion': descripcionController.text,
                  'Fecha': fechaController.text,
                  'Hora': horaController.text,
                  'Tipo': tipo,
                });
                Navigator.of(context).pop();
              },
              child: Text('Actualizar'),
            ),
          ],
        );
      },
    );
  }

  void showCreateDialog() {
    TextEditingController nombreController = TextEditingController();
    TextEditingController descripcionController = TextEditingController();
    TextEditingController fechaController = TextEditingController();
    TextEditingController horaController = TextEditingController();
    String tipo = 'Urgente';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Crear Nuevo Recordatorio'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Nombre Recordatorio'),
                controller: nombreController,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Descripción'),
                controller: descripcionController,
              ),
              TextField(
                readOnly: true,
                controller: fechaController,
                decoration: InputDecoration(labelText: 'Fecha'),
                onTap: () => _selectDate(context, fechaController),
              ),
              TextField(
                readOnly: true,
                controller: horaController,
                decoration: InputDecoration(labelText: 'Hora'),
                onTap: () => _selectTime(context, horaController),
              ),
              DropdownButton<String>(
                value: tipo,
                onChanged: (String? newValue) {
                  setState(() {
                    tipo = newValue!;
                  });
                },
                items: <String>['Urgente', 'Importante', 'Poca Importancia']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                createData({
                  'Nombre_Recordatorio': nombreController.text,
                  'Descripcion': descripcionController.text,
                  'Fecha': fechaController.text,
                  'Hora': horaController.text,
                  'Tipo': tipo,
                });
                Navigator.of(context).pop();
              },
              child: Text('Crear'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agenda"),
      ),
      body: Column(
        children: [
          CalendarDatePicker(
            initialDate: selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
            onDateChanged: (date) {
              setState(() {
                selectedDate = date;
              });
            },
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : data.isEmpty
                    ? Center(child: Text('No hay datos disponibles'))
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          final record = data[index] as Map<String, dynamic>;
                          DateTime recordDate = DateTime.parse(record["Fecha"]);
                          if (recordDate == selectedDate) {
                            return Card(
                              elevation: 4,
                              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: ListTile(
                                title: Text(record["Nombre_Recordatorio"] ?? 'No Name'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Descripción: ${record["Descripcion"] ?? ''}'),
                                    Text('Hora: ${record["Hora"] ?? ''}'),
                                    Text('Tipo: ${record["Tipo"] ?? ''}'),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () {
                                        showEditDialog(record);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        deleteData(record['ID_Agenda']);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showCreateDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}