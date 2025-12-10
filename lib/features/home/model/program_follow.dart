class ProgramFollow {
  List<UserProgramMapping>? userProgramMapping;

  ProgramFollow({this.userProgramMapping});

  ProgramFollow.fromJson(Map<String, dynamic> json) {
    if (json['user_program_mapping'] != null) {
      userProgramMapping = <UserProgramMapping>[];
      json['user_program_mapping'].forEach((v) {
        userProgramMapping!.add(UserProgramMapping.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userProgramMapping != null) {
      data['user_program_mapping'] = userProgramMapping!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserProgramMapping {
  String? programCode;

  UserProgramMapping({this.programCode});

  UserProgramMapping.fromJson(Map<String, dynamic> json) {
    programCode = json['program_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['program_code'] = programCode;
    return data;
  }
}
