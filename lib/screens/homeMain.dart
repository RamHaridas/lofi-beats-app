import 'package:browser786/constants.dart';
import 'package:browser786/screens/browser.dart';
import 'package:browser786/screens/lofiPage.dart';
import 'package:browser786/screens/musicSearch.dart';
import 'package:browser786/screens/space.dart';
import 'package:flutter/material.dart';
import 'package:drawerbehavior/drawerbehavior.dart';

class DrawerScale extends StatefulWidget {
  @override
  _DrawerScaleState createState() => _DrawerScaleState();
}

class _DrawerScaleState extends State<DrawerScale> {
  late int selectedMenuItemId;
  List<Widget> screens = [WebBrowser(), MusicSearch(), SpaceHome(), LofiPage()];
  Menu menu = Menu(items: [
    MenuItem(
        title: "Browse", id: 0, icon: Icons.search, textStyle: navBarTextStyle),
    MenuItem(
        title: "Music",
        id: 1,
        icon: Icons.music_note,
        textStyle: navBarTextStyle),
    MenuItem(
        title: "Space",
        id: 2,
        icon: Icons.travel_explore,
        textStyle: navBarTextStyle),
    MenuItem(
        title: "Lofi", id: 3, icon: Icons.radio, textStyle: navBarTextStyle)
  ]);
  @override
  void initState() {
    super.initState();
    selectedMenuItemId = menu.items[0].id;
  }

  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
      appBar: AppBar(title: Text(menu.items[selectedMenuItemId].title)),
      drawers: [
        SideDrawer(
          slide: true,
          duration: Duration(milliseconds: 300),
          menu: menu,
          direction: Direction.left,
          animation: true,
          color: Colors.orange,
          selectedItemId: selectedMenuItemId,
          onMenuItemSelected: (itemId) {
            setState(() {
              selectedMenuItemId = itemId;
            });
          },
        )
      ],
      builder: (context, id) => screens[selectedMenuItemId],
    );
  }
}
