class NotificationResponse {
  final int total;
  final List<NotifItem> values;

  NotificationResponse({
    required this.total,
    required this.values,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      total: json['total'] ?? 0,
      values: (json['values'] as List<dynamic>?)
              ?.map((e) => NotifItem.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'total': total,
        'values': values.map((e) => e.toJson()).toList(),
      };
}

class NotifItem {
  final int id;
  final int resourceId;
  final String textMessage;
  final String targetUrl;
  final int typeMessage;
  final int status;
  final int createdBy;
  final DateTime? createdDate;
  final String? author;

  NotifItem({
    required this.id,
    required this.resourceId,
    required this.textMessage,
    required this.targetUrl,
    required this.typeMessage,
    required this.status,
    required this.createdBy,
    this.createdDate,
    this.author,
  });

  factory NotifItem.fromJson(Map<String, dynamic> json) {
    return NotifItem(
      id: json['id'] ?? 0,
      resourceId: json['resource_id'] ?? 0,
      textMessage: json['text_message'] ?? '',
      targetUrl: json['target_url'] ?? '',
      typeMessage: json['type_message'] ?? 0,
      status: json['status'] ?? 0,
      createdBy: json['created_by'] ?? 0,
      createdDate: json['created_date'] != null
          ? DateTime.tryParse(json['created_date'])
          : null,
      author: json['author'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'resource_id': resourceId,
        'text_message': textMessage,
        'target_url': targetUrl,
        'type_message': typeMessage,
        'status': status,
        'created_by': createdBy,
        'created_date': createdDate?.toIso8601String(),
        'author': author,
      };
}
