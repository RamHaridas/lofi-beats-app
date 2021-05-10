import 'dart:convert';
import 'package:browser786/card/musicCard.dart';
import 'package:browser786/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class MusicSearch extends StatefulWidget {
  @override
  _MusicSearchState createState() => _MusicSearchState();
}

class _MusicSearchState extends State<MusicSearch> {
  bool isAnim = true;
  var results;
  List<dynamic> songlist = [];

  //function to searhc music from API
  void searchMusic(String search) async {
    EasyLoading.show(status: "Searching...");
    if (search.isEmpty) {
      EasyLoading.dismiss();
      return;
    }
    var response = await http.get(Uri.parse(BASE_URL + "search?q=$search"),
        headers: {
          "x-rapidapi-key": API_KEY,
          "x-rapidapi-host": "deezerdevs-deezer.p.rapidapi.com"
        });
    if (response.statusCode == 200) {
      results = jsonDecode(response.body);
      print(results['total']);
      setState(() {
        songlist = results['data'];
        if (songlist.isEmpty || songlist.length == 0) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("No songs found")));
          return;
        }
        isAnim = false;
      });

      //print(songlist[0].toString());
    }
    EasyLoading.dismiss();
  }

  Widget getMainWidget() {
    return isAnim
        ? Expanded(
            child: Lottie.asset('assets/music.json', height: 300, width: 300),
          )
        : Expanded(
            child: AnimationLimiter(
              child: ListView.builder(
                  itemCount: songlist.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        duration: Duration(milliseconds: 400),
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          duration: Duration(milliseconds: 400),
                          child: MusicCard(songlist[index]),
                        ),
                      ),
                    );
                  }),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                onFieldSubmitted: (val) {
                  //EasyLoading.dismiss();
                  searchMusic(val.toString());
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                  ),
                  hintText: "Search Music",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
              ),
            ),
            getMainWidget(),
          ],
        ));
  }
}
