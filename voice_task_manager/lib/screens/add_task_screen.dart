import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import '../services/database_service.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDateTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Tarea')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ListTile(
                title: Text(
                  _selectedDateTime == null
                      ? 'Selecciona Fecha y Hora'
                      : DateFormat('dd/MM/yyyy HH:mm').format(_selectedDateTime!),
                ),
                trailing: Icon(Icons.calendar_today),
                onTap: _selectDateTime,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveTask,
                child: Text('Guardar Tarea'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  void _saveTask() async {
    if (_formKey.currentState!.validate() && _selectedDateTime != null) {
      final task = Task(
        id: 0,
        description: _descriptionController.text,
        registeredAt: DateTime.now(),
        scheduledTime: _selectedDateTime!,
      );

      await DatabaseService().insertTask(task);
      Navigator.pop(context);
    }
  }
}
