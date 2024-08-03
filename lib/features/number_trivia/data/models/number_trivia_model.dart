class NumberTriviaModel {
  NumberTriviaModel({
    String? text,
    int? number,
  }) {
    _text = text;
    _number = number;
  }

  String? _text;
  int? _number;

  String? get text => _text;

  int? get number => _number;

  NumberTriviaModel.fromJson(Map<String, dynamic> json) {
    _text = json['text'];
    _number = (json['number'] as num).toInt();
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    map['number'] = _number;
    return map;
  }
}
