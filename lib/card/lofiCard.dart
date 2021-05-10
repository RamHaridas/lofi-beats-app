import 'package:browser786/constants.dart';
import 'package:flutter/material.dart';

class LofiCard extends StatelessWidget {
  var song;
  LofiCard(this.song);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/lofi', arguments: song);
      },
      child: Padding(
        padding: EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Card(
            color: Colors.grey[850],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Hero(
                      tag: song['title'],
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          song['image'],
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(song['title'], style: musicCardTextStyle)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
