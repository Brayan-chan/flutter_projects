import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(BudgetApp());
}

class BudgetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BudgetCalculator(),
      theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
      ),
    );
  }
}

class BudgetCalculator extends StatefulWidget {
  @override
  _BudgetCalculatorState createState() => _BudgetCalculatorState();
}

class _BudgetCalculatorState extends State<BudgetCalculator> {
  final TextEditingController _budgetController = TextEditingController();
  double _needs = 0.0, _wants = 0.0, _savings = 0.0;

  void _calculateBudget() {
    double budget = double.tryParse(_budgetController.text) ?? 0.0;
    setState(() {
      _needs = budget * 0.5;
      _wants = budget * 0.3;
      _savings = budget * 0.2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Calculadora 50/30/20"),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Ingresa tu presupuesto mensual:",
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _budgetController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Ejemplo: 10000",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _calculateBudget,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              child: Text("Calcular"),
            ),
            SizedBox(height: 30.0),
            if (_needs > 0) ...[
              _buildBudgetCard("Necesidades (50%)", _needs, Colors.blue),
              _buildBudgetCard("Deseos (30%)", _wants, Colors.green),
              _buildBudgetCard("Ahorros (20%)", _savings, Colors.orange),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetCard(String title, double amount, Color color) {
    return Card(
      color: color.withOpacity(0.1),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(Icons.monetization_on, color: color),
        title: Text(title),
        trailing: Text("\$${amount.toStringAsFixed(2)}"),
      ),
    );
  }
}
