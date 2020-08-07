import 'dart:convert';
import 'package:http/http.dart' as http;

const clientId = '748883a601544df09c58f64955f2a019';
const clientSecret = '7bbfa008b011408a91f437f2a6afd8ca';
const token_url = 'https://accounts.spotify.com/api/token';

Future<String> getAccessToken() async {
  final response = await http.post(token_url, body: {
    'grant_type': 'client_credentials'
  }, headers: {
    'Authorization':
        'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}'
  });
  var tokenResponseData = jsonDecode(response.body);
//    print(tokenResponseData);
  var _accessToken = tokenResponseData['access_token'];

//    print(_accessToken);
  return _accessToken;
}

Future<Map> getAlbums() async {
  String accessToken = await getAccessToken();
  final url =
      'https://api.spotify.com/v1/albums?ids=41MnTivkwTO3UUJ8DrqEJJ%2C6JWc4iAiJ9FjyK0B59ABb4%2C6UXCm6bOO4gFlDQZV5yL37';
  final response = await http.get(
    url,
    headers: {'Authorization': 'Bearer $accessToken'},
  );
//    print(response.body);
  final loadedData = jsonDecode(response.body);
  print(loadedData);
  return loadedData;
}
