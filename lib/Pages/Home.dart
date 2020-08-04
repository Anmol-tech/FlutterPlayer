import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String videoUrl;
TextEditingController url = TextEditingController();

class Data {
  String link = url.text;
}

showtoast() {
  return Fluttertoast.showToast(
      msg: "Url Cannot be Empty",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.deepOrange[400],
      textColor: Colors.white,
      fontSize: 16.0);
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var filePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'Live Player',
                  style: Theme.of(context).textTheme.headline1,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                TextField(
                  controller: url,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter media link',
                    labelText: 'Media URL',
                    icon: Icon(
                      Icons.public,
                      size: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                RaisedButton(
                  onPressed: () {
                    if (url.text.isNotEmpty) {
                      Navigator.pushReplacementNamed(
                          context, '/onlineVideoPlayer');
                    } else {
                      showtoast();
                    }
                  },
                  color: Theme.of(context).accentColor,
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Play Media ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                Text(
                  'OR',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),

                RaisedButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/audioPlayer'),
                  color: Theme.of(context).accentColor,
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Choose Audio File',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                RaisedButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, '/offlineVideoPlayer'),
                  color: Theme.of(context).accentColor,
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Choose Video File',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),

                // Container(
                //   height: 300,
                //   width: double.infinity,
                //   child: Row(
                //     children: <Widget>[
                //       Container(
                //         width: 150,
                //         height: 150,
                //         child: Card(
                //           child: Icon(Icons.ac_unit),
                //         ),
                //       ),
                //       IconButton(
                //         onPressed: () => print('play'),
                //         iconSize: 60,
                //         icon: Icon(
                //           Icons.play_arrow,
                //         ),
                //       )
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
