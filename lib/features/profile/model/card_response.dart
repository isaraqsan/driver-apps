class GenerateCardResponse {
  final bool status;
  final String message;
  final String data; // path PDF

  GenerateCardResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  // Factory dari JSON
  factory GenerateCardResponse.fromJson(Map<String, dynamic> json) {
    return GenerateCardResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] ?? '',
    );
  }

  // Convert ke JSON (opsional, kalau perlu)
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data,
    };
  }
}
