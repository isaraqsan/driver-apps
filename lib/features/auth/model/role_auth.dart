class RoleAuth {
  int? roleId;
  String? roleName;
  int? status;

  RoleAuth.fromJson(Map<String, dynamic> json) {
    roleId = json['role_id'];
    roleName = json['role_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() => {
        'role_id': roleId,
        'role_name': roleName,
        'status': status,
      };
}
