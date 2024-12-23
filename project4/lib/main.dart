import 'dart:ffi'; // Thư viện FFI
import 'package:flutter/material.dart';

import 'package:project4/quadratic.dart'; // Để tải thư viện chia sẻ

// Cấu trúc trả về từ hàm C
final class QuadraticResult extends Struct {
  @Int32()
  external int num_roots; // Số nghiệm
  @Double()
  external double root1; // Nghiệm 1
  @Double()
  external double root2; // Nghiệm 2
}

// Định nghĩa hàm C trong Dart
typedef SolveQuadraticC =
    QuadraticResult Function(Double a, Double b, Double c);
typedef SolveQuadraticDart =
    QuadraticResult Function(double a, double b, double c);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: QuadraticSolverScreen());
  }
}
