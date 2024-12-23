import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project3/highlighttext.dart';
import 'package:project3/model/readjsonfile.dart';

class ReadBookPage extends StatefulWidget {
  const ReadBookPage({super.key});

  @override
  State<ReadBookPage> createState() => _ReadBookPageState();
}

class _ReadBookPageState extends State<ReadBookPage> {
  final ValueNotifier<int> highlightedIndex = ValueNotifier<int>(
    -1,
  ); // Sử dụng ValueNotifier
  Timer? timer;
  String displayedText = "";
  List<String> words = [];

  @override
  void dispose() {
    timer?.cancel();
    highlightedIndex.dispose(); // Hủy ValueNotifier khi widget bị hủy
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('JSON Example')),
      body: FutureBuilder<DataModel>(
        future: loadData(),
        builder: (context, snapshot) => buildFutureContent(snapshot),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final player = AudioCache();
          player.load('output.wav');
        },
      ),
    );
  }

  Future<DataModel> loadData() async {
    final String response = await rootBundle.loadString('assets/output.json');
    final Map<String, dynamic> data = json.decode(response);
    return DataModel.fromJson(data);
  }

  Widget buildFutureContent(AsyncSnapshot<DataModel> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (snapshot.hasData) {
      DataModel data = snapshot.data!;
      displayedText = data.text;
      words = displayedText.split(' ');
      if (timer == null) {
        startHighlighting(words);
        // Chỉ khởi động timer một lần
      }
      return ValueListenableBuilder<int>(
        valueListenable: highlightedIndex,
        builder: (context, value, child) {
          return HighlightedText(
            text: displayedText,
            highlightedIndex: value, // Chỉ số cập nhật từ ValueNotifier
          );
        },
      );
    }
    return Center(child: Text('No data'));
  }

  void startHighlighting(List<String> words) {
    timer?.cancel();
    highlightedIndex.value = -1; // Reset index
    timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      if (highlightedIndex.value < words.length - 1) {
        highlightedIndex.value++; // Cập nhật ValueNotifier
      } else {
        timer.cancel(); // Dừng timer khi hoàn tất
      }
    });
  }
}
