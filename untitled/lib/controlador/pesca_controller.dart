import 'package:untitled/modelo/pesca.dart';

class PescaController {
  late Pesca pesca;

  PescaController(int limite) {
    pesca = Pesca(limite: limite);
  }

  String registrarPesca(int peso) {
    if (peso == 0) return 'Programa terminado.';
    if (pesca.agregarPesca(peso)) {
      return '¡LÍMITE SUPERADO! Exceso: ${pesca.total - pesca.limite} Kg';
    } else {
      return 'Total pescado por ahora: ${pesca.total} Kg';
    }
  }
}

