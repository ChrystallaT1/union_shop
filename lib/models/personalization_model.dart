class PersonalizationModel {
  final String text;
  final String fontStyle;
  final String color;
  final double additionalCost;

  PersonalizationModel({
    required this.text,
    this.fontStyle = 'Arial',
    this.color = 'Black',
    this.additionalCost = 0.0,
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'fontStyle': fontStyle,
      'color': color,
      'additionalCost': additionalCost,
    };
  }

  factory PersonalizationModel.fromJson(Map<String, dynamic> json) {
    return PersonalizationModel(
      text: json['text'],
      fontStyle: json['fontStyle'] ?? 'Arial',
      color: json['color'] ?? 'Black',
      additionalCost: json['additionalCost'] ?? 0.0,
    );
  }

  PersonalizationModel copyWith({
    String? text,
    String? fontStyle,
    String? color,
    double? additionalCost,
  }) {
    return PersonalizationModel(
      text: text ?? this.text,
      fontStyle: fontStyle ?? this.fontStyle,
      color: color ?? this.color,
      additionalCost: additionalCost ?? this.additionalCost,
    );
  }

  bool get isValid => text.trim().isNotEmpty && text.length <= 50;

  String get displaySummary => '"$text" in $fontStyle ($color)';
}
