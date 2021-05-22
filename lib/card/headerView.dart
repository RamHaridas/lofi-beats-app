import 'package:flutter/material.dart';

class HeaderView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              ClipRRect(
                  child: Image.asset('assets/icons/header.png',
                      height: 80, width: 80),
                  borderRadius: BorderRadius.circular(150)),
              SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Hello there,",
                      style: TextStyle(color: Colors.white, fontSize: 25)),
                  Text("May the force be with you",
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                ],
              ),
            ],
          ),
        ));
  }
}
