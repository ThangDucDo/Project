import 'dart:async';
import 'package:flutter/material.dart';

class MemoryGameScreen extends StatefulWidget {
  const MemoryGameScreen({super.key});

  @override
  State<MemoryGameScreen> createState() => _MemoryGameScreenState();
}

class _MemoryGameScreenState extends State<MemoryGameScreen> {
  final List<String> images = [
    'assets/face1.jpg',
    'assets/face2.jpg',
    'assets/face1.jpg',
    'assets/face2.jpg',
    'assets/face3.jpg',
    'assets/face4.jpg',
    'assets/face3.jpg',
    'assets/face4.jpg',
    'assets/face5.jpg',
    'assets/face6.jpg',
    'assets/face5.jpg',
    'assets/face6.jpg',
  ];

  List<bool> flipped = [];
  List<bool> temporaryFlipped = [];
  int? firstIndex, secondIndex;

  @override
  void initState() {
    super.initState();
    images.shuffle();
    flipped = List<bool>.filled(images.length, false);
    temporaryFlipped = List<bool>.filled(images.length, false);
  }

  void _onTileTap(int index) {
    if (flipped[index] || temporaryFlipped[index] || secondIndex != null) {
      return;
    }

    setState(() {
      temporaryFlipped[index] = true;

      if (firstIndex == null) {
        firstIndex = index;
      } else {
        secondIndex = index;
        Timer(Duration(seconds: 1), _checkMatch);
      }
    });
  }

  void _checkMatch() {
    if (images[firstIndex!] == images[secondIndex!]) {
      setState(() {
        flipped[firstIndex!] = true;
        flipped[secondIndex!] = true;
      });
    }

    setState(() {
      temporaryFlipped[firstIndex!] = false;
      temporaryFlipped[secondIndex!] = false;
      firstIndex = null;
      secondIndex = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Memory Faces')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: images.length,
        padding: EdgeInsets.all(20),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _onTileTap(index);
            },
            child:
                flipped[index] || temporaryFlipped[index]
                    ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(images[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                    : Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                      ),
                    ),
          );
        },
      ),
    );
  }
}
