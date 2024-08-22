import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

 Future<bool>  checkInternet() async {
  try {
    var result = await InternetAddress.lookup("google.com");
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }return false;
  }on SocketException catch (_) {
    return false;
  }
}





Future<bool> checkInternetConnectivity() async {
  try {
    final response = await http.get(Uri.parse('https://google.com'));
    if (response.statusCode == 200) {
      // Internet connected
      return true;
    } else {
      // Internet not connected
      return false;
    }
  } catch (e) {
    // Error in making GET request, internet not connected
    return false;
  }
}

