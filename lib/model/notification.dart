class NotificationsData {
  String title, message;
  //time
  DateTime time;

  NotificationsData(
      {required this.title, required this.message, required this.time});
  factory NotificationsData.fromJson(Map<String, dynamic> json) {
    return NotificationsData(
      title: json['title'],
      message: json['message'],
      time: DateTime.parse(json['created_at']),
    );
  }
}
