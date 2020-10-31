import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'file:///E:/androidstd/testingapp/testapp/lib/home/chewie_list_item.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),),
      centerTitle: true,
      backgroundColor: Colors.blue[900],


    ),

      body: ListView(
        children: <Widget>[
          /*ChewieListItem(videoPlayerController: VideoPlayerController.asset('videos/IntroVideo.mp4'
          ),
            looping: true,
          ),*/
          ChewieListItem(videoPlayerController: VideoPlayerController.network('https://firebasestorage.googleapis.com/v0/b/commentsystem-ef25d.appspot.com/o/videos%2FDesign%20-%2048420.mp4?alt=media&token=fde021ea-7aaa-494c-a655-647f4537954d'),
          ),
        ],
      ),

    );
  }
}
