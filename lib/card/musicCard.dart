import 'package:browser786/constants.dart';
import 'package:flutter/material.dart';

class MusicCard extends StatelessWidget {
  var song;
  MusicCard(this.song);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/music', arguments: song);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Card(
            color: Colors.grey[850],
            elevation: 2,
            child: ListTile(
              subtitle: Text(
                song['album']['title'],
                style: musicCardTextStyle,
              ),
              title: Text(
                song['title'],
                style: musicCardTextStyle,
              ),
              trailing: Hero(
                tag: song['id'],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(song['album']['cover_medium']),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
