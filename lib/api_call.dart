import 'package:http/http.dart' as http;

Future getLaunchData({required String rocketId}) async {
  String baseUrl = 'https://api.spacexdata.com/v3/launches';
  //await Future.delayed(const Duration(seconds: 1));
  http.Response response =
      await http.get(Uri.parse('$baseUrl?rocket_id=$rocketId'));
  try {
    if (response.statusCode == 200) {
      return response;
    } else {
      return 'failed';
    }
  } catch (e) {
    return 'failed';
  }
}

Future getRocketsList() async {
  String baseUrl = 'https://api.spacexdata.com/v3/rockets';
  http.Response response = await http.get(Uri.parse(baseUrl));
  try {
    if (response.statusCode == 200) {
      return response;
    } else {
      return 'failed';
    }
  } catch (e) {
    return 'failed';
  }
}

Future getLaunchImages() async {
  String baseUrl = 'https://api.spacexdata.com/v3/launches';
  http.Response response = await http.get(Uri.parse(baseUrl));
  try {
    if (response.statusCode == 200) {
      return response;
    } else {
      return 'failed';
    }
  } catch (e) {
    return 'failed';
  }
}
