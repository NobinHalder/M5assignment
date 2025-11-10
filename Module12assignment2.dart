

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.blue),
      darkTheme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.blue),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: CalculatorPage(isDarkMode: _isDarkMode, toggleTheme: _toggleTheme),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;
  const CalculatorPage({super.key, required this.isDarkMode, required this.toggleTheme});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _expression = '';
  String _result = '';
  final Set<String> _operators = {'+', '-', '×', '÷', '*', '/'};

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _expression = '';
        _result = '';
        return;
      }

      if (value == '⌫') {
        if (_expression.isNotEmpty) {
          _expression = _expression.substring(0, _expression.length - 1);
        }
        return;
      }

      if (value == '=') {
        _evaluate();
        return;
      }

      if (_expression.isEmpty && _operators.contains(value)) {
        if (value != '-') return;
      }

      if (_expression.isNotEmpty && _operators.contains(value)) {
        String last = _expression[_expression.length - 1];
        if (_operators.contains(last)) {
          if (value == '-' && last != '-') {
            _expression += value;
            return;
          }
          _expression = _expression.substring(0, _expression.length - 1) + value;
          return;
        }
      }

      if (value == '.') {
        int lastOp = -1;
        for (int i = _expression.length - 1; i >= 0; i--) {
          if (_operators.contains(_expression[i])) {
            lastOp = i;
            break;
          }
        }
        String lastNumber = _expression.substring(lastOp + 1);
        if (lastNumber.contains('.')) return;
      }

      _expression += value;
    });
  }

  void _evaluate() {
    if (_expression.isEmpty) return;

    String parsed = _expression.replaceAll('×', '*').replaceAll('÷', '/');
    while (parsed.isNotEmpty && _operators.contains(parsed[parsed.length - 1])) {
      parsed = parsed.substring(0, parsed.length - 1);
    }

    if (parsed.isEmpty) return;

    try {
      Parser p = Parser();
      Expression exp = p.parse(parsed);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      String resText = eval.toString();
      if (resText.endsWith('.0')) {
        resText = resText.substring(0, resText.length - 2);
      }

      setState(() {
        _result = resText;
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }

  Widget _buildButton(String text, {double flex = 1, Color? color}) {
    return Expanded(
      flex: flex.toInt(),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(text),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20),
            backgroundColor: color,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          child: Text(text, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              alignment: Alignment.bottomRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    child: Text(_expression, style: const TextStyle(fontSize: 32)),
                  ),
                  const SizedBox(height: 8),
                  Text(_result, style: const TextStyle(fontSize: 24, color: Colors.grey)),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(children: [
                _buildButton('C', color: Colors.redAccent),
                _buildButton('⌫'),
                _buildButton('%'),
                _buildButton('÷', color: Colors.orange),
              ]),
              Row(children: [
                _buildButton('7'),
                _buildButton('8'),
                _buildButton('9'),
                _buildButton('×', color: Colors.orange),
              ]),
              Row(children: [
                _buildButton('4'),
                _buildButton('5'),
                _buildButton('6'),
                _buildButton('-', color: Colors.orange),
              ]),
              Row(children: [
                _buildButton('1'),
                _buildButton('2'),
                _buildButton('3'),
                _buildButton('+', color: Colors.orange),
              ]),
              Row(children: [
                _buildButton('0', flex: 2),
                _buildButton('.'),
                _buildButton('=', color: Colors.green),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}