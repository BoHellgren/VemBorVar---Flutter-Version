import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'members.dart';
import 'membersearch.dart';
// import 'dart:developer';

class WhoLiveHere extends StatefulWidget {
  final String mask;
  final String calledBy;

  WhoLiveHere({Key key, @required this.mask, @required this.calledBy});

  @override
  _WhoLiveHereState createState() =>
      _WhoLiveHereState(mask: mask, calledBy: this.calledBy);
}

class _WhoLiveHereState extends State<WhoLiveHere> {
//    with SingleTickerProviderStateMixin {

  PageController pageController;
  var floors;

  initState() {
    super.initState();

    int initialPage;
    int floor = int.parse(mask.substring(1, 2));
    //

    initialPage = mask.substring(0, 1) == '1' ? 14 - floor : 8 - floor;
    this.color = mask.substring(0, 1) == '1' ? Color(0xFF977981) : Color(0xFF7B919E);

    pageController =
        PageController(initialPage: initialPage, viewportFraction: 0.85);

    this.floors = locateMembers();

    timeDilation = 5.0;
  }

  dispose() {
    pageController.dispose();
    super.dispose();
  }

  String mask;
  String calledBy;
  Color color;
  int direction = 0;

  _WhoLiveHereState({Key key, @required this.mask, @required this.calledBy});

  void _goUp() {
    direction = 0;
    pageController.previousPage(
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _goDown() {
    direction = 1;
    pageController.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _goHome() {
    if (this.calledBy == 'Search') {
      Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(centerTitle: true, title: Text('Vilka bor här ?'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MemberSearch()),
            );
          },
        ),
      ]),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: HouseBadge(mask),
        ),
        Container(
          constraints: BoxConstraints(maxHeight: 390),
          child: PageView.builder(
              controller: pageController,
              scrollDirection: Axis.vertical,
              onPageChanged: (page) {
                setState(() {
                  if (page < 7) {
                    this.mask = '2' + (8 - page).toString();
                    this.color = Color(0xFF7B919E);
                  } else {
                    this.mask = '1' + (14-page).toString();
                    this.color = Color(0xFF977981);
                  }
                  // print(this.mask);
                });
              },
              itemCount: floors.length,
              itemBuilder: (context, index) {
                return Card(
                    color: this.color,
                    margin: const EdgeInsets.all(8.0),
                    child: Column(
                     //   crossAxisAlignment: CrossAxisAlignment.start,
                     //   mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AptCard(floors[index], 1),
                          AptCard(floors[index], 2),
                          AptCard(floors[index], 3),
                    ]));
              }),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          //   // print('tapindex $index');
          if (index == 0) {
            _goUp();
          } else if (index == 1) {
            _goDown();
          } else {
            _goHome();
          }
        },
        currentIndex:
            this.direction, // this will be set when a new tab is tapped
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_upward),
            title: Text('Upp'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_downward),
            title: Text('Ner'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Startsidan'),
          )
        ],
      ),
    );
  }
}

class HouseBadge extends StatelessWidget {
  final mask;
  HouseBadge(this.mask);
  @override
  Widget build(BuildContext context) {
    String building = mask.substring(0, 1);
    Color floorcolor;
    String floorname;
    if (building == '1') {
      floorcolor = Color(0xFF977981);
      floorname = 'Taxgatan 7';
    } else {
      floorcolor = Color(0xFF7B919E);
      floorname = 'Taxgatan 3';
    }

    String maskfloor = mask.substring(1, 2);
    String trappor;
    if (maskfloor == '2') {
      trappor = (int.parse(maskfloor) - 1).toString() + ' trappa';
    } else {
      trappor = (int.parse(maskfloor) - 1).toString() + ' trappor';
    }

    return (SizedBox(
      //      height: 40.0,
      width: 500.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 140.0,
            child: Card(
                //   color: Theme.of(context).buttonColor,
                color: floorcolor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    floorname,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0),
                  ),
                )),
          ),
          Hero(
            tag: mask,
            child: SizedBox(
              width: 140.0,
              child: Card(
                  //   color: Theme.of(context).buttonColor,
                  color: floorcolor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      trappor,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  )),
            ),
          ),
        ],
      ),
    ));
  }
}

class AptCard extends StatelessWidget {
  final floor;
  final aptnum; // 1, 2 or 3
  AptCard(this.floor, this.aptnum);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
     //   constraints: BoxConstraints(maxHeight: 85.0),
        child: Card(
          child: Column(children: [
            Text('  ${floor[(aptnum-1)*2].lgh}  ${floor[(aptnum-1)*2].lmv}  ${floor[(aptnum-1)*2].membername}'.padRight(99),
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18.0, height: 1.5)),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text('  ${floor[(aptnum-1)*2+1].lgh}  ${floor[(aptnum-1)*2+1].lmv}  ${floor[(aptnum-1)*2+1].membername}'.padRight(99),
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18.0, height: 1.5)),
            ),
          ]),
        ),
      ),
    );
  }
}
