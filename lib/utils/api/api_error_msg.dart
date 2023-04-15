abstract class APIErrorMsg {
  static const String socketException = 'Please try again later';

  // No Internet...
  static const String noInternet = "No Internet";
  static const String noInternetMsg = "Please check your internet connection";

  // Un-authorised user...
  static const String unAuthorisedTitle = "UnAuthorised";
  static const String unAuthorisedMsg =
      "The session is expired due to security reasons, please login again to continue.";

  // Default error msg...
  static const String defaultErrorTitle = "Error";
  static const String somethingWentWrong =
      "Something went wrong, please try again later...";

  // Under Maintiance...
  static const String underMaintainanceTitle = "Under Maintainance";
  static const String underMaintainanceMsg =
      "Sorry, we're down for scheduled maintenance right now, please try after some time.";

  // Invalid API response format...
  static const String invalidFormat = "Invalid format";

  // Socket Exception...
  static const String httpErrorMsg = "The server is currently unavailable.";

  // Request timeout...
  static const String requestTimeOutTitle = "Request Timeout";
  static const String requestTimeOutMessage =
      "Looks like the server is taking to long to respond, this can be caused by either poor connectivity or an error with our servers. Please try again in a while";
}
