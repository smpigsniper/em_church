import 'package:http/http.dart' as http;

class ApiRequest {
  static Future<String> getRequest(String url, String token) async {
    String response = "";
    try {
      final responseData = await http.get(
        Uri.parse(url),
        headers: addHeader(token),
      );
      if (responseData.statusCode == 200) {
        response = responseData.body;
      }
      return response;
    } on Exception catch (_) {
      return response;
    }
  }

  static Future<String> postRequest(String url, String token, Map<String, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: addHeader(token),
        body: body,
      );

      if (response.statusCode == 200) {
        return response.body;
      } else {
        // Handle non-200 responses here (e.g., throw an exception or return an error message)
        throw Exception('Failed to load data: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle or log exceptions here
      throw Exception('Request failed: $e');
    }
  }

  static Map<String, String> addHeader(String token) {
    return {
      'Accept': 'application/json',
      'x-access-token': token.isNotEmpty ? token : '',
    };
  }
}
