import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task/album.dart';
import 'package:task/album_screen.dart';

const clientId = '748883a601544df09c58f64955f2a019';
const clientSecret = '7bbfa008b011408a91f437f2a6afd8ca';
const token_url = 'https://accounts.spotify.com/api/token';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  String albumType;
//  String albumImage;
//  String copyRight;

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

  List<Album> albums = [];

  @override
  void initState() {
    super.initState();
    getAlbums().then((value) {
      setState(() {
        albums = [
          Album(
              albumImage: value['albums'][0]['images'][0]['url'],
              albumType: value['albums'][0]['album_type'],
              albumName: value['albums'][0]['name'],
              copyRight: value['albums'][0]['copyrights'][0]['text']),
          Album(
              albumImage: value['albums'][1]['images'][0]['url'],
              albumType: value['albums'][1]['album_type'],
              albumName: value['albums'][1]['name'],
              copyRight: value['albums'][1]['copyrights'][0]['text']),
          Album(
              albumImage: value['albums'][2]['images'][0]['url'],
              albumType: value['albums'][2]['album_type'],
              albumName: value['albums'][2]['name'],
              copyRight: value['albums'][2]['copyrights'][0]['text']),
        ];
//        albumType = value['albums'][0]['album_type'];
//        albumImage = value['albums'][0]['images'][0]['url'];
//        copyRight = value['albums'][0]['copyrights'][0]['text'];
      });
//      print(albums[1].albumType);
//      print(albums[1].albumImage);
//      print(albums[1].copyRight);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.purple[300],
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'Home',
            style: TextStyle(fontSize: 40.0),
          ),
        ),
        body: ListView.builder(
          itemCount: albums.length,
          itemBuilder: (ctx, index) {
            return Column(
              children: [
                Container(
                  color: Colors.purple[100],
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return AlbumScreen(
                          albumImage: albums[index].albumImage,
                          albumName: albums[index].albumName,
                          copyRight: albums[index].copyRight,
                        );
                      }));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage: albums[index].albumImage == null
                              ? AssetImage('assets/default.png')
                              : NetworkImage(albums[index].albumImage),
                        ),
                        title: Text(
                          albums[index].albumName ?? '',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(albums[index].albumType ?? ''),
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 6,
                ),
              ],
            );
          },
        ));
  }
}
