import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:assets_audio_player/assets_audio_player.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Apple Music',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'Apple Music'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _index = 1;
  FlatButton playPauseButton;
  bool isPlaying = false;
  double volumeSliderValue = 10;


  //Music Player
  AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();




  _MyHomePageState()
  {
    playPauseButton = new FlatButton(
        onPressed: clickPlay,
        child:
            Image(image:AssetImage('assets/play.png'),width: 40,height: 40,),
        //Icon(IconData(), color: Colors.pinkAccent,size: 70,)
    );
    _assetsAudioPlayer.open(AssetsAudio(
      asset: "song1.mp3",
      folder: "assets/audios/",
    ));
    _assetsAudioPlayer.pause();

  }

  void nextSong()
  {
    setState(() {
      if(_index<3)
        {
          _index++;
          String path = "song"+_index.toString()+".mp3";
          _assetsAudioPlayer.open(AssetsAudio(
            asset: path,
            folder: "assets/audios/",
          ));
        }
    });

  }
  void prevSong()
  {
    setState(() {
      if(_index>0)
      {
        _index--;
        String path = "song"+_index.toString()+".mp3";
        _assetsAudioPlayer.open(AssetsAudio(
          asset: path,
          folder: "assets/audios/",
        ));
      }
    });
  }
  //When we hit play pause button
  void clickPlay()
  {
    setState(() {
      if(isPlaying) {
        playPauseButton = new FlatButton(
            onPressed: clickPlay,
            child:
            Image(image:AssetImage('assets/play.png'),width: 40,height: 40,),
        );
        _assetsAudioPlayer.pause();
        isPlaying = false;
      }
      else{
        playPauseButton = new FlatButton(
            onPressed: clickPlay,
            child:
            Image(image:AssetImage('assets/pause.png'),width: 40,height: 40,),
        );
        _assetsAudioPlayer.play();
        isPlaying = true;
      }


    });
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            /**
             *
             * SONG NAME
             */
            Container(width: 210,height: 210,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 30),
              decoration: new BoxDecoration(
                  color: Colors.amber,
                  boxShadow: [new BoxShadow(
                    color: Color.fromARGB(255, 224, 224, 224),
                    blurRadius: 20.0,
                    spreadRadius: 20,
                  ),]
              ),),
            Text(
              "Song Name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ),
            ),
            Container(child: Text(
              "Album Name", style: TextStyle(color:Colors.pinkAccent,fontSize: 20, fontWeight: FontWeight.bold ),
            ),margin: EdgeInsets.fromLTRB(20, 0, 20, 90),),

            /**
             *
             * MEDIA CONTROLLER
             */

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: FlatButton(
                    onPressed: prevSong,
                    child:
                    Image(image:AssetImage('assets/previous.png'),width: 40,height: 40,),
                  ),
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 20),

                ),

                Container(
                  child:playPauseButton,
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                ),

                Container(
                  child: FlatButton(
                    onPressed: nextSong,
                    child:
                    Image(image:AssetImage('assets/next.png'),width: 40,height: 40,),
                  ),
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                ),

              ],
            ),
            /**
             *
             *
             * VOLUME SLIDER
             */
            Row(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(width:20,child:
                Icon(Icons.volume_mute,color: Colors.grey,),),
                Container(width: 300,child: Slider(
                  value: volumeSliderValue,
                  activeColor: Colors.grey,
                  inactiveColor: Color.fromARGB(255, 224, 224, 224),
                  onChanged: (newValue){
                    setState(() {
                      volumeSliderValue = newValue;
                    });
                  },min: 0,max: 100,divisions: 100,
                ),),
                Container(width: 20,child:
                Icon(Icons.volume_up,color: Colors.grey,),),
              ],
            ),


            /**
             *
             *
             * CLOUD DOWNLOAD AND BOTTOM BUTTONS
             */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: FlatButton(
                    onPressed: null,
                    child:
                    Icon(Icons.cloud_download, color: Colors.pinkAccent,size:30),
                  ),
                  margin: EdgeInsets.fromLTRB(20, 0, 30, 20),
                ),
                Container(
                  child: FlatButton(
                    onPressed: null,
                    child:
                    Icon(Icons.wifi_tethering, color: Colors.pinkAccent,size:30),
                  ),
                  margin:
                  EdgeInsets.fromLTRB(20, 0, 20, 20),
                ),

                Container(
                  child: FlatButton(
                    onPressed: null,
                    child:
                    Icon(CupertinoIcons.ellipsis,color: Colors.pinkAccent,size: 30,),
                  ),
                  margin: EdgeInsets.fromLTRB(30, 0, 20, 20),
                ),


              ],
            )
          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
