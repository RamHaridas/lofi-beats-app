import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:browser786/card/lofiCard.dart';
import 'package:browser786/card/musicCard.dart';
import 'package:browser786/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;

class LofiPage extends StatefulWidget {
  @override
  _LofiPageState createState() => _LofiPageState();
}

class _LofiPageState extends State<LofiPage> {
  //https://forms-rest-api.herokuapp.com/lofi
  var songs = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSongs();
  }

  void getSongs() async {
    EasyLoading.show(status: "Please wait...");
    var res = await http.get(Uri.parse(lofi));
    if (res.statusCode == 200) {
      EasyLoading.dismiss();
      setState(() {
        songs = jsonDecode(res.body);
      });
    }
    print(songs);
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text("Hello there,",
                  style: TextStyle(color: Colors.white, fontSize: 25)),
            ),
            Expanded(
              child: AnimationLimiter(
                child: GridView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: FlipAnimation(
                        duration: Duration(milliseconds: 500),
                        // horizontalOffset: 50.0,
                        child: ScaleAnimation(
                            duration: Duration(milliseconds: 500),
                            child: LofiCard(songs[index])),
                      ),
                    );
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                ),
              ),
            ),
          ],
        ));
  }
}
