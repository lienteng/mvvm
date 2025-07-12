class BannerItem {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String? actionUrl;
  final String type;
  final bool isActive;
  final DateTime startDate;
  final DateTime endDate;

  BannerItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.actionUrl,
    required this.type,
    required this.isActive,
    required this.startDate,
    required this.endDate,
  });

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      actionUrl: json['action_url'],
      type: json['type'],
      isActive: json['is_active'] ?? true,
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'action_url': actionUrl,
      'type': type,
      'is_active': isActive,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
    };
  }
}
