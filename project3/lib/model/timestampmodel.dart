class TimestampModel {
  final int timeellapsed;
  final int wordduration;
  final int wordindex;
  final int wordlength;

  TimestampModel({
    required this.timeellapsed,
    required this.wordduration,
    required this.wordindex,
    required this.wordlength,
  });

  factory TimestampModel.fromList(List<int> values) {
    return TimestampModel(
      timeellapsed: values[0],
      wordduration: values[1],
      wordindex: values[2],
      wordlength: values[3],
    );
  }
}
