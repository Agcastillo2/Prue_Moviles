import 'package:flutter/material.dart';
import 'package:untitled/controlador/pesca_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _inputController = TextEditingController();
  PescaController? _controller; // Cambiado para inicializar después
  String _message = 'Introduce el límite máximo de kilos:';
  bool _definiendoLimite = true; // Indica si estamos definiendo el límite

  void _procesarEntrada() {
    final input = int.tryParse(_inputController.text);
    if (input == null || input < 0) {
      setState(() {
        _message = 'Por favor, ingresa un número válido.';
      });
      return;
    }

    if (_definiendoLimite) {
      // Definir el límite máximo
      _controller = PescaController(input);
      setState(() {
        _definiendoLimite = false;
        _message = 'Límite establecido en $input Kg.\nIntroduce los kilos pescados:';
      });
    } else {
      // Registrar la pesca
      final result = _controller!.registrarPesca(input);
      setState(() {
        _message = result;
      });

      if (result.contains('LÍMITE SUPERADO')) {
        _definiendoLimite = true; // Reinicia el programa
        _controller = null;
        _message += '\nIntroduce un nuevo límite para reiniciar.';
      }
    }

    _inputController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Límite de Pesca'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: _definiendoLimite
                    ? 'Límite máximo (Kg)'
                    : 'Introduce Kg pescados (0 para salir)',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _procesarEntrada,
              child: Text(_definiendoLimite ? 'Establecer límite' : 'Registrar'),
            ),
            SizedBox(height: 20),
            Text(
              _message,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
