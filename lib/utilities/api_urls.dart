class ApiUrls {
  var serverUrl = "https://e977-102-167-221-175.eu.ngrok.io/";

  // get Login url
  getLoginUrl() {
    return serverUrl + "user/login";
  }

  //get device list url
  getDeviceListUrl() {
    return serverUrl + "devices/all";
  }

  //connect device url
  getConnectDeviceUrl() {
    return serverUrl + "device/connection";
  }

  //disconnect device url
  getDisconnectDeviceUrl() {
    return serverUrl + "device/disconnection";
  }

  //change device state
  getChangeDeviceStateUrl() {
    return serverUrl + "device/change-state";
  }

  //get notifications
  getNotificationsUrl() {
    return serverUrl + "user/notifications";
  }
 
  getChangeLaneUrl() {
    return serverUrl + "device/lane";
  }

  //reset password url
  getResetPasswordUrl() {
    return serverUrl + "user/reset-password";
  }
  //get user connected devices url
  getUserConnectedDevicesUrl() {
    return serverUrl + "user/devices";
  }
}
