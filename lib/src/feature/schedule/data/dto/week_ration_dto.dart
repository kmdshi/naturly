class WeekRationDto {
  final String shareId;
  final List<Map<String, dynamic>> foodData;

  WeekRationDto({required this.shareId, required this.foodData});

  factory WeekRationDto.fromJson(Map<String, dynamic> json) {
    return WeekRationDto(
      shareId: json['share_id'] ?? '',
      foodData: List<Map<String, dynamic>>.from(json['food_data'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {'share_id': shareId, 'food_data': foodData};
  }

  WeekRationDto copyWith({
    String? weekShareKey,
    List<Map<String, dynamic>>? foodData,
  }) {
    return WeekRationDto(
      shareId: weekShareKey ?? this.shareId,
      foodData: foodData ?? this.foodData,
    );
  }
}
