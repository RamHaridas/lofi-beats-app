import 'dart:convert';

import 'package:browser786/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

class SpaceHome extends StatefulWidget {
  @override
  _SpaceHomeState createState() => _SpaceHomeState();
}

class _SpaceHomeState extends State<SpaceHome> {
  PageController _controller = PageController();
  List<Widget> imageSliders = [];
  List<dynamic> roverImages = [];
  List<dynamic> images = [];
  int _current = 0;

  void setTopImages(list) {
    for (var img in list) {
      imageSliders.add(buildPage(img['url']));
    }
    EasyLoading.dismiss();
  }

  void setRoverImages(list) {
    setState(() {
      roverImages = list;
    });
  }

  void getRoverImages() async {
    var res = await http.get(Uri.parse(marsRoverImages));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      roverImages = data['photos'];
      setRoverImages(roverImages);
    } else {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No internet")));
    }
  }

  void getTopImages() async {
    var res = await http.get(Uri.parse(topImages));
    if (res.statusCode == 200) {
      images = jsonDecode(res.body);
      setState(() {
        setTopImages(images);
      });
    } else {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("No internet")));
    }
  }

  Widget buildPage(String url) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        child: Center(
          child: Image.network(url),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    EasyLoading.show(status: "Please wait...");
    getTopImages();
    getRoverImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(children: [
        CarouselSlider(
          items: imageSliders,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageSliders.map((url) {
            int index = imageSliders.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index ? Colors.white : Colors.grey,
              ),
            );
          }).toList(),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          'Top NASA Images',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 40,
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return RawMaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/details',
                        arguments: roverImages.elementAt(index));
                  },
                  child: Hero(
                    tag: {roverImages.elementAt(index)['id']},
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(
                              roverImages.elementAt(index)['img_src']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: roverImages.length,
            ),
          ),
        ),
      ]),
    );
  }
}
