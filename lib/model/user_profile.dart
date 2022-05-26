class UserProfile {
  String id;
  String name;
  String email;
  String phone;
  String address;
  String city;
  String state;
  String country;
  String zip;
  String profilePic;
  String about;
  //final List<String> interests;
  final bool isDarkMode;

// ignore: non_constant_identifier_names
  UserProfile(
      this.id,
      this.name,
      this.email,
      this.phone,
      this.address,
      this.city,
      this.state,
      this.country,
      this.zip,
      this.profilePic,
      this.about,
      this.isDarkMode);

  UserProfile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        phone = json['phone'],
        address = json['address'],
        city = json['city'],
        state = json['state'],
        country = json['country'],
        zip = json['zip'],
        profilePic = json['profile_pic'],
        about = json['about'],
        isDarkMode = json['is_dark_mode'];
  

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'address': address,
        'city': city,
        'state': state,
        'country': country,
        'zip': zip,
        'profile_pic': profilePic,
        'about': about,
        'is_dark_mode': isDarkMode,
      };
}
