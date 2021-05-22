import 'package:browser786/constants.dart';
import 'package:flutter/material.dart';

class TopImageDetail extends StatefulWidget {
  @override
  _TopImageDetailState createState() => _TopImageDetailState();
}

class _TopImageDetailState extends State<TopImageDetail> {
  var data;
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
        bottomSheet: Container(
          color: Colors.grey[900],
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("Image by ", style: musicCardTextStyle),
            Text(data['copyright'] == null ? "NASA" : data['copyright'],
                style: musicCardTextStyle)
          ]),
        ),
        backgroundColor: Colors.grey[900],
        body: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                  data['explanation'] == null ? "" : data['explanation'],
                  style: musicCardTextStyle),
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    data['hdurl'] == null ? randomImage : data['hdurl']),
                fit: BoxFit.cover),
          ),
        ));
  }
}
