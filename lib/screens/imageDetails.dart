import 'package:browser786/constants.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  int tag = 0;
  String url = "";
  String title = "";
  String camera = "";
  String price = "";
  String details = "";
  void setData(data) {
    setState(() {
      tag = data['id'];
      url = data['img_src'];
      title = data['rover']['name'] + " Rover";
      camera = data['camera']['full_name'];
      price = data['earth_date'];
      details = data['rover']['status'];
    });
  }

  @override
  Widget build(BuildContext context) {
    var data = ModalRoute.of(context)!.settings.arguments;
    setData(data);
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Hero(
                tag: tag,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    image: DecorationImage(
                      image: NetworkImage(url),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: 260,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'By $camera',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.orangeAccent,
                          ),
                        ),
                        Text(
                          price,
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Status of Rover: " + details,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.grey[900],
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Image by", style: navBarTextStyle),
          Image.asset('assets/icons/nasa.png', height: 50, width: 50)
        ]),
      ),
    );
  }
}
