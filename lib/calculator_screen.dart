import 'package:proyectop1/button_values.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'display.dart'; // Importación del widget DisplayWidget
import 'botonera.dart'; // Importación de las constantes de botones

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String number1 = ""; // Primer número de la operación
  String operand = ""; // Operador (+, -, *, /)
  String number2 = ""; // Segundo número de la operación

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Output de la calculadora
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                // Widget Personalizado para mostrar el resultado
                child: DisplayWidget(
                  displayText: "$number1$operand$number2",
                ),
              ),
            ),
            // Botonera de la calculadora
            Wrap(
              children: Btn.buttonValues
                  .map(
                    (value) => SizedBox(
                  width: value == Btn.n0
                      ? screenSize.width / 2
                      : (screenSize.width / 4),
                  height: screenSize.width / 5,
                  // Widget Personalizado para los botones de la calculadora
                  child: CalculatorButton(
                    value: value,
                    color: getBtnColor(value),
                    onPressed: onBtnTap,
                  ),
                ),
              )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  // Función llamada al presionar un botón
  void onBtnTap(String value) {
    if (value == Btn.del) {
      delete();
      return;
    }

    if (value == Btn.clr) {
      clearAll();
      return;
    }

    if (value == Btn.per) {
      convertToPercentage();
      return;
    }

    if (value == Btn.calculate) {
      calculate();
      return;
    }

    appendValue(value);
  }


  // FUNCION PARA CALCULAR RESULTADOS
  void calculate() {
    if (number1.isEmpty) return;

    // Elevar al cuadrado
    if (operand == Btn.n11) {
      final double num1 = double.parse(number1);
      var result = num1 * num1;

      setState(() {
        number1 = result.toStringAsPrecision(3);
        if (number1.endsWith(".0")) {
          number1 = number1.substring(0, number1.length - 2);
        }
        operand = "";
        number2 = "";
      });
      return;
    }

    // Calcular logaritmo natural (ln)
    if (operand == Btn.n10) {
      final double num1 = double.parse(number1);
      var result = lnManual(num1); // Llamada a la función para calcular ln

      setState(() {
        number1 = result.toStringAsPrecision(3);
        if (number1.endsWith(".0")) {
          number1 = number1.substring(0, number1.length - 2);
        }
        operand = "";
        number2 = "";
      });
      return;
    }

    // Calcular seno
    if (operand == Btn.n13) {
      final double num1 = double.parse(number1);
      var result = sinManual(num1); // Llamada a la función para calcular el seno

      setState(() {
        number1 = result.toStringAsPrecision(3);
        if (number1.endsWith(".0")) {
          number1 = number1.substring(0, number1.length - 2);
        }
        operand = "";
        number2 = "";
      });
      return;
    }

    // Calcular coseno
    if (operand == Btn.n14) {
      final double num1 = double.parse(number1);
      var result = cosManual(num1); // Llamada a la función para calcular el coseno

      setState(() {
        number1 = result.toStringAsPrecision(3);
        if (number1.endsWith(".0")) {
          number1 = number1.substring(0, number1.length - 2);
        }
        operand = "";
        number2 = "";
      });
      return;
    }

    // Operaciones aritméticas básicas
    if (operand.isEmpty) return;
    if (number2.isEmpty) return;

    final double num1 = double.parse(number1);
    final double num2 = double.parse(number2);

    var result = 0.0;
    switch (operand) {
      case Btn.add:
        result = num1 + num2;
        break;
      case Btn.subtract:
        result = num1 - num2;
        break;
      case Btn.multiply:
        result = num1 * num2;
        break;
      case Btn.divide:
        result = num1 / num2;
        break;
      default:
    }

    setState(() {
      number1 = result.toStringAsPrecision(3);
      if (number1.endsWith(".0")) {
        number1 = number1.substring(0, number1.length - 2);
      }
      operand = "";
      number2 = "";
    });
  }

  // Función para calcular el logaritmo natural (ln) manualmente
  double lnManual(double number) {
    if (number <= 0) return 0.0;

    return log(number);
  }

  // Función para calcular el seno manualmente
  double sinManual(double number) {
    return sin(number);
  }

  // Función para calcular el coseno manualmente
  double cosManual(double number) {
    return cos(number);
  }

  // Función para calcular la raíz cuadrada manualmente
  double sqrtManual(double number) {
    if (number <= 0) return 0.0; //

    double approx = number / 2.0; // Aproximación inicial
    double lastApprox = 0.0;

    // Iterar hasta alcanzar una precisión aceptable
    while (approx != lastApprox) {
      lastApprox = approx;
      approx = (approx + number / approx) / 2.0;
    }

    return approx;
  }

  // Función para convertir el resultado a porcentaje
  void convertToPercentage() {
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      calculate(); // Calcula antes de convertir si hay operaciones pendientes
    }

    if (operand.isNotEmpty) {
      return; // No puede convertir si hay un operador pendiente
    }

    final number = double.parse(number1);
    setState(() {
      number1 = "${(number / 100)}";
      operand = "";
      number2 = "";
    });
  }

  // Función para limpiar todos los valores
  void clearAll() {
    setState(() {
      number1 = "";
      operand = "";
      number2 = "";
    });
  }

  // Función para eliminar el último dígito o operador
  void delete() {
    if (number2.isNotEmpty) {
      number2 = number2.substring(0, number2.length - 1);
    } else if (operand.isNotEmpty) {
      operand = "";
    } else if (number1.isNotEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    }

    setState(() {});
  }

  // Función para añadir un valor al número actual o al operador
  void appendValue(String value) {
    if (value != Btn.dot && int.tryParse(value) == null) {
      if (operand.isNotEmpty && number2.isNotEmpty) {
        calculate(); // Calcula antes de añadir un operador si hay operaciones pendientes
      }
      operand = value;
    } else if (number1.isEmpty || operand.isEmpty) {
      if (value == Btn.dot && number1.contains(Btn.dot)) return;
      if (value == Btn.dot && (number1.isEmpty || number1 == Btn.n0)) {
        value = "0."; // Manejo especial para el punto decimal
      }
      number1 += value;
    } else if (number2.isEmpty || operand.isNotEmpty) {
      if (value == Btn.dot && number2.contains(Btn.dot)) return;
      if (value == Btn.dot && (number2.isEmpty || number2 == Btn.n0)) {
        value = "0."; // Manejo especial para el punto decimal
      }
      number2 += value;
    }

    setState(() {});
  }

  // Función para obtener el color del botón según su valor
  Color getBtnColor(value) {
    return [Btn.del, Btn.clr].contains(value)
        ? Colors.green
        : [
      Btn.per,
      Btn.multiply,
      Btn.add,
      Btn.subtract,
      Btn.divide,
      Btn.calculate,
      Btn.n10,
      Btn.n11,
      Btn.n13,
      Btn.n14,
    ].contains(value)
        ? Colors.orange
        : Colors.black;
  }
}
