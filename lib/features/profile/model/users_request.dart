class UsersRequest {
  final List<String> users;
  final String mode;

  UsersRequest({required this.users, required this.mode});
  factory UsersRequest.fromJson(Map<String, dynamic> json) {
    return UsersRequest(
      mode: json['mode'],
      users: List<String>.from(json['users'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mode': mode,
      'users': users,
    };
  }
}
