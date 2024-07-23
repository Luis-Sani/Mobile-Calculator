import 'dart:math';

// Función para calcular el logaritmo natural de un número
double naturalLog(double number) {
  if (number <= 0) return 0.0; // Manejo de casos donde el número es negativo o cero

  return log(number);
}
