import 'package:project3/model/timestampmodel.dart';

class DataModel {
  final String text;
  final List<TimestampModel> timestamp;

  DataModel({required this.text, required this.timestamp});

  // Phương thức factory để chuyển từ JSON sang đối tượng DataModel
  factory DataModel.fromJson(Map<String, dynamic> json) {
    var list = json['timestamp'] as List;
    List<TimestampModel> timestamp =
        list
            .map((item) => TimestampModel.fromList(List<int>.from(item)))
            .toList();
    return DataModel(text: json['text'] ?? '', timestamp: timestamp);
  }
}
