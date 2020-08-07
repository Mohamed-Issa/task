import 'package:flutter/material.dart';
import 'package:task/album.dart';
import 'package:task/album_screen.dart';
import 'authorization.dart';

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
        primaryColor: Colors.deepPurple,
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
        backgroundColor: Colors.deepPurple,
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
                  color: Colors.purple[300],
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
                        subtitle: Text(
                          albums[index].albumType ?? '',
                          style: TextStyle(color: Colors.black),
                        ),
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
