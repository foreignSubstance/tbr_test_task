import 'package:http/http.dart' as http;

Future getLaunchData({required int limit, required int offset}) async {
  String baseUrl = 'https://api.spacexdata.com/v3/launches';
  await Future.delayed(const Duration(seconds: 1));
  http.Response response =
      await http.get(Uri.parse('$baseUrl?limit=$limit&offset=$offset'));
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
