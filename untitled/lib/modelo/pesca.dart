class Pesca {
  int limite;
  int total;

  Pesca({required this.limite, this.total = 0});

  bool agregarPesca(int peso) {
    total += peso;
    return total >= limite;
  }
}
