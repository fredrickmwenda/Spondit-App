class User {
  final String fullName;
  final String email;
  final String accessToken;
  final String refreshToken;
  // password
  final String password;
  




  User(this.fullName,  this.email, 
      this.refreshToken, this.password, this.accessToken, );
  
  User.fromJson(Map<String, dynamic> json):
    fullName = json['full_name'],
    email = json['email'],
    password = json['password'],
    accessToken = json['access_token'],
    refreshToken = json['refresh_token'];

  Map<String, dynamic> toJson() =>
    {
      'full_name': fullName,
      'email': email,
      'password': password,
      'access_token': accessToken,
      'refresh_token': refreshToken,

    };



  
}