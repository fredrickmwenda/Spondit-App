class DeviceData {

  //Add enable boolean field
  DeviceData({
    required this.deviceId,
    required this.deviceName,
    required this.deviceType,
    //Add lanes
    required this.lane1,
    required this.lane2,
    required this.lane3,
    required this.lane4,
    //lane 5 is not required use null safety
    required this.lane5,
    required this.lane6,
    required this.lane7,
    required this.lane8,


    //Add float latitude
    required this.latitude,
    //Add float longitude
    required this.longitude,   
    required this.deviceDescription,
    required this.deviceImages,
    required this.deviceCreatedAt,
    required this.id,
    //Add enable boolean field
    required this.deviceStatus,
    required this.enable_1,
    required this.enable_2,
    required this.enable_3,
    required this.enable_4,
    required this.enable_5,
    required this.enable_6,
    required this.enable_7,
    required this.enable_8,
    required this.state,
    required this.city,

  });
  //integer id
  int id;
  String deviceId;
  String deviceName;
  String deviceType;
  String lane1;
  String lane2;
  String lane3;
  String lane4;
  String lane5;
  String lane6;
  String lane7;

  //Add float latitude
  double latitude;
  //Add float longitude
  double longitude;
  String deviceDescription;
  String deviceImages;
  DateTime deviceCreatedAt;
  //Add enable boolean field
  bool deviceStatus;
  bool enable_1;
  bool enable_2;
  bool enable_3;
  bool enable_4;
  bool enable_5;
  bool enable_6;
  bool enable_7;
  bool enable_8;
  String state;
  String city;

  factory DeviceData.fromJson(Map<String, dynamic> json) => DeviceData(
        id: json["id"],
        deviceName: json["name"],
        deviceType: json["device_type"],
        lane1: json["lane_1"],
        lane2: json["lane_2"],
        lane3: json["lane_3"],
        lane4: json["lane_4"],
        
        deviceId: json["device_id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        deviceDescription: json["_description"],
        deviceImages: json["device_image"],
        deviceCreatedAt: DateTime.parse(json["pub_date"]),
        //Add enable boolean field
        deviceStatus: json["enable"],
        enable_1: json["enable_1"],
        enable_2: json["enable_2"],
        enable_3: json["enable_3"],
        enable_4: json["enable_4"],
        state: json["state"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "device_id": deviceId,
        "device_name": deviceName,
        "device_type": deviceType,
        "lane_1": lane1,
        "lane_2": lane2,
        "lane_3": lane3,
        "lane_4": lane4,
        "device_status": deviceStatus,
        "enable_1": enable_1,
        "enable_2": enable_2,
        "enable_3": enable_3,
        "enable_4": enable_4,
        "state": state,
        "city": city,        
        "device_description": deviceDescription,
        "device_image": deviceImages,
        "device_created_at":
            "${deviceCreatedAt.year.toString().padLeft(4, '0')}-${deviceCreatedAt.month.toString().padLeft(2, '0')}-${deviceCreatedAt.day.toString().padLeft(2, '0')}",

      };
}
