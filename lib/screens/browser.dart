import 'package:browser786/constants.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:http/http.dart' as http;
import 'package:loading_indicator/loading_indicator.dart';
import 'package:lottie/lottie.dart';

class WebBrowser extends StatefulWidget {
  @override
  _WebBrowserState createState() => _WebBrowserState();
}

class _WebBrowserState extends State<WebBrowser> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  bool progress = false;
  String query = googleSearch;
  String currIcon = google;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //progress = false;
  }

  void setDefaultSearchEngine(i) {
    print('func');
    switch (i) {
      case 1:
        {
          print('case');
          query = googleSearch;
          currIcon = google;
        }
        break;
      case 2:
        {
          query = yahooSearch;
          currIcon = yahoo;
        }
        break;
      case 3:
        {
          query = bingSearch;
          currIcon = bing;
        }
        break;
      case 4:
        {
          query = duckSearch;
          currIcon = duck;
        }
        break;
      default:
        {
          query = googleSearch;
          currIcon = google;
        }
        break;
    }
    if (fabKey.currentState!.isOpen) {
      fabKey.currentState!.close();
    }
  }

  Widget getIcon() {
    return Padding(
        padding: EdgeInsets.all(7),
        child: SvgPicture.asset(currIcon, height: 50, width: 50));
  }

  void launchWebsite(url) {
    FlutterWebBrowser.openWebPage(
      url: url,
      customTabsOptions: CustomTabsOptions(
        colorScheme: CustomTabsColorScheme.dark,
        toolbarColor: Colors.deepPurple,
        secondaryToolbarColor: Colors.green,
        navigationBarColor: Colors.transparent,
        addDefaultShareMenuItem: true,
        instantAppsEnabled: true,
        showTitle: true,
        urlBarHidingEnabled: true,
      ),
      safariVCOptions: SafariViewControllerOptions(
        barCollapsingEnabled: true,
        preferredBarTintColor: Colors.green,
        preferredControlTintColor: Colors.amber,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        modalPresentationCapturesStatusBarAppearance: true,
      ),
    );
    EasyLoading.dismiss();
  }

  void openBrowser(url) async {
    EasyLoading.show(status: "Please wait...");
    if (url.toString().isEmpty) {
      EasyLoading.dismiss();
      return;
    }
    progress = true;
    final response;
    var fixurl = "http://$url";
    try {
      response = await http.head(Uri.parse(fixurl));
      if (response.statusCode == 200) {
        progress = false;
        launchWebsite(fixurl);
      } else {
        String new_url = "$query$url";
        progress = false;
        launchWebsite(new_url);
      }
    } catch (e) {
      String new_url = "$query$url";
      progress = false;
      launchWebsite(new_url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FabCircularMenu(
          ringColor: Colors.deepPurple,
          alignment: Alignment.bottomCenter,
          animationDuration: Duration(milliseconds: 300),
          ringWidth: 70,
          key: fabKey,
          fabCloseIcon: Icon(Icons.close, color: Colors.white),
          fabOpenIcon: getIcon(),
          children: <Widget>[
            TextButton(
                onPressed: () {
                  print('ontap');
                  setState(() {
                    setDefaultSearchEngine(1);
                  });
                },
                child: Container(
                    child: SvgPicture.asset(google, height: 50, width: 50))),
            GestureDetector(
                onTap: () {
                  setState(() {
                    setDefaultSearchEngine(2);
                  });
                },
                child: SvgPicture.asset(yahoo, height: 50, width: 50)),
            GestureDetector(
                onTap: () {
                  setState(() {
                    setDefaultSearchEngine(3);
                  });
                },
                child: SvgPicture.asset(bing, height: 50, width: 50)),
            GestureDetector(
                onTap: () {
                  setState(() {
                    setDefaultSearchEngine(4);
                  });
                },
                child: SvgPicture.asset(duck, height: 50, width: 50))
          ],
        ),
        backgroundColor: Colors.grey[900],
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            Padding(
              padding: EdgeInsets.all(5),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                onFieldSubmitted: (val) {
                  openBrowser(val.toString());
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                  ),
                  hintText: "https://",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                ),
              ),
            ),
            Visibility(
              visible: progress,
              child: Container(
                width: 40,
                height: 40,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballBeat,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            Lottie.asset('assets/search.json', width: 200, height: 200),
            Text("Browse", style: TextStyle(color: Colors.white, fontSize: 20)),
          ]),
        ));
  }
}
