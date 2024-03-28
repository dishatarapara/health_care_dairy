class UserModel{
  late int user_id;
  late String title;
  late String description;
  late String time;

  UserModel({
    required this.user_id,
    required this.title,
    required this.description,
    required this.time
  });

  UserModel.fromMap(Map<String, dynamic> result)
  : user_id = result["user_id"],
        title = result["title"],
        description = result["description"],
        time = result["time"];

  Map<String, dynamic> toMap() {
    return {
      'user_id': user_id,
      'title': title,
      'description': description,
      'time': time,
    };
  }
}