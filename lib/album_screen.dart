import 'package:flutter/material.dart';

class AlbumScreen extends StatelessWidget {
  final String albumName;
  final String albumImage;
  final String copyRight;

  AlbumScreen({this.albumImage, this.albumName, this.copyRight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        title: Text(
          albumName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 370,
              width: 400,
              child: Image.network(albumImage),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              copyRight,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
