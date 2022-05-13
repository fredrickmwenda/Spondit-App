
class ApiUrls{

  final serverUrl = "https://cd6c-105-162-4-213.eu.ngrok.io";

  String getLoginUrl(){
    return serverUrl + "/user/login";
  }

  String getDevicesUrl(){
    return serverUrl + "/devices/all";
  }
  String getConnectedDevicesUrl(){
    return serverUrl + "/devices/connected";
  }
  String getProfileUrl(){
    return serverUrl +"";
  }
}