class DeviceConnection {
  DeviceConnection(
    this.id,
    this.deviceId,
    this.userId,
  );

  String id;
  String deviceId;
  String userId;


  factory DeviceConnection.fromJson(Map<String, dynamic> json) => DeviceConnection(
    json["id"],
    json["deviceId"],
    json["userId"],
    
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "deviceId": deviceId,
    "userId": userId,

  };
}