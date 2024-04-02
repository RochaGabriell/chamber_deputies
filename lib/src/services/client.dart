import 'package:http/http.dart' as http;

class HttpClient {
  final client = http.Client();

  Future get({required String url}) async {
    return await client.get(Uri.parse(url));
  }
}
