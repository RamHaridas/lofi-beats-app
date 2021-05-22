import 'package:browser786/card/headerView.dart';
import 'package:browser786/constants.dart';
import 'package:browser786/screens/about.dart';
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
  List<Widget> screens = [
    WebBrowser(),
    MusicSearch(),
    SpaceHome(),
    LofiPage(),
    AboutPage()
  ];
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
        title: "Lofi", id: 3, icon: Icons.radio, textStyle: navBarTextStyle),
    MenuItem(title: "Info", id: 4, icon: Icons.info, textStyle: navBarTextStyle)
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
          headerView: HeaderView(),
          degree: 35,
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
