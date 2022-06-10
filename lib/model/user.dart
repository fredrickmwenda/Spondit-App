class User {
  final String id;
  final String fullName;
  final String email;
  final String accessToken;
  final String refreshToken;
  // password
  final String password;
  
  




  User(this.id,this.fullName,  this.email, 
      this.refreshToken, this.password, this.accessToken, );
  
  User.fromJson(Map<String, dynamic> json):
    id = json['user_id'],
    fullName = json['full_name'],
    email = json['email'],
    password = json['password'],
    accessToken = json['access_token'],
    refreshToken = json['refresh_token'];

  Map<String, dynamic> toJson() =>
    {
      'user_id': id,
      'full_name': fullName,
      'email': email,
      'password': password,
      'access_token': accessToken,
      'refresh_token': refreshToken,

    };



  
}