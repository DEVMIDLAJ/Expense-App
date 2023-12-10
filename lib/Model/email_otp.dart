import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailOTP {
  // Constructor for the EmailOTP class
  EmailOTP();

  // Method to send OTP to the provided email
  Future<String> sendOtp(email) async {
    // Define the request URL with the email parameter
    Uri requestUrl = Uri.parse('https://malluscart.online/flutter-projects/expense-app/mail-verification/mailer.php?email=$email');
    // Perform an HTTP GET request to send the OTP
    final response = await http.get(requestUrl);
    // Decode the JSON response and extract the "id" field
    var responseJson = json.decode(response.body.toString());
    return responseJson["id"];
  }

  // Method to verify the OTP with the provided ID and user-entered OTP
  Future<String> verifyOtp(id, userOtp) async {
    // Define the request URL with the ID and user-entered OTP parameters
    Uri requestUrl = Uri.parse('https://malluscart.online/flutter-projects/expense-app/mail-verification/verify-otp.php?id=$id&otp=$userOtp');
    // Perform an HTTP GET request to verify the OTP
    final response = await http.get(requestUrl);
    // Decode the JSON response and extract the "status" field
    var responseJson = json.decode(response.body.toString());
    return responseJson["status"];
  }
}
