class UserModel{
  late int user_id;
  late String user_name;

  UserModel({required this.user_id, required this.user_name});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'user_id': user_id,
      'user_name': user_name,
    };
    return map;
  }
}