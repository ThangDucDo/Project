import 'dart:ffi';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project4/main.dart';

class QuadraticSolverScreen extends StatefulWidget {
  @override
  _QuadraticSolverScreenState createState() => _QuadraticSolverScreenState();
}

class _QuadraticSolverScreenState extends State<QuadraticSolverScreen> {
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  final TextEditingController _cController = TextEditingController();

  String _result = '';

  late final DynamicLibrary _nativeLib;
  late final SolveQuadraticDart _solveQuadratic;

  @override
  void initState() {
    super.initState();

    // Tải thư viện C
    if (Platform.isAndroid || Platform.isLinux) {
      _nativeLib = DynamicLibrary.open("libquadratic_solver.so");
    } else if (Platform.isWindows) {
      _nativeLib = DynamicLibrary.open("quadratic_solver.dll");
    } else if (Platform.isMacOS) {
      _nativeLib = DynamicLibrary.open("libquadratic_solver.dylib");
    }

    _solveQuadratic = _nativeLib
        .lookupFunction<SolveQuadraticC, SolveQuadraticDart>("solve_quadratic");
  }

  void _calculate() {
    final double a = double.tryParse(_aController.text) ?? 0.0;
    final double b = double.tryParse(_bController.text) ?? 0.0;
    final double c = double.tryParse(_cController.text) ?? 0.0;

    final QuadraticResult result = _solveQuadratic(a, b, c);

    setState(() {
      if (result.num_roots == 2) {
        _result = "Two roots: x1 = ${result.root1}, x2 = ${result.root2}";
      } else if (result.num_roots == 1) {
        _result = "One root: x = ${result.root1}";
      } else {
        _result = "No real roots";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quadratic Equation Solver")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _aController,
              decoration: InputDecoration(labelText: "Enter a"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _bController,
              decoration: InputDecoration(labelText: "Enter b"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _cController,
              decoration: InputDecoration(labelText: "Enter c"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _calculate, child: Text("Solve")),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
