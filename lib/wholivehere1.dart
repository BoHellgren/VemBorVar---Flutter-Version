import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'members.dart';
import 'membersearch.dart';
import 'dart:developer';

class WhoLiveHere extends StatefulWidget {
  final String mask;
  final String calledBy;

  WhoLiveHere({Key key, @required this.mask, @required this.calledBy});

  @override
  _WhoLiveHereState createState() =>
      _WhoLiveHereState(mask: mask, calledBy: this.calledBy);
}

class _WhoLiveHereState extends State<WhoLiveHere>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();

    controller = AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);

    animation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        //       print('now new members');
        setState(() {
          //         controller.reverse();
          this.hits1 = [];
          this.hits2 = [];
          this.hits3 = [];
          //       this.direction = 0;
          if (this.direction == 0) {
            this.mask = (int.parse(this.mask) + 1).toString();
          } else {
            this.mask = (int.parse(this.mask) - 1).toString();
          }
        });
  //      controller.forward();
      }
    }); // end of status listener
    timeDilation = 5.0;
//    controller.forward();
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }

  String mask;
  String calledBy;
  String titleString;
  int direction = 0;

  // _WhoLiveHereState({Key key, @required this.mask}) : super(key: key);
  _WhoLiveHereState({Key key, @required this.mask, @required this.calledBy});

  List<Member> hits1 = [];
  List<Member> hits2 = [];
  List<Member> hits3 = [];

  void _setTitle() {
    String floorName;
    String floorNum;
    if (this.mask.substring(0, 1) == '1') {
      floorName = 'Taxgatan 7';
    } else {
      floorName = 'Taxgatan 3';
    }
    floorNum = (int.parse(this.mask.substring(1, 2)) - 1).toString() + " tr";
    titleString = floorName + "    " + floorNum;
  }

  void _goUp() {
    // invalid masks for go up: 17 and 28
    int intmask = int.parse(this.mask);
    bool ok = (intmask != 17) && (intmask != 28);
    // debugger();
    if (ok) {
      setState(() {
        controller.forward();
        this.direction = 0;
      });
    }
  }

  void _goDown() {
    // invalid masks for go down: 12 and 22
    int intmask = int.parse(this.mask);
    bool ok = (intmask != 12) && (intmask != 22);
    // print('assert följer, mask = ' + this.mask);
    // assert(this.mask != '27', 'mask är 27');
    if (ok) {
      setState(() {
        controller.reverse();
        this.direction = 1;
      });
    }
  }

  void _goHome() {
    print(this.calledBy);
    if (this.calledBy == 'Search') {
      Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("_WhoLiveHereState build called");
    print("Mask $mask");
    print("Direction $direction");
    _setTitle();
    String building = mask.substring(0, 1);
    hits1 = [];
    hits2 = [];
    hits3 = [];
    members.forEach((member) {
      if (member.lgh == (mask + '1'))
        hits1.add(member);
      else if (member.lgh == (mask + '2'))
        hits2.add(member);
      else if (member.lgh == (mask + '3')) hits3.add(member);
    });
 //   timeDilation = 5.0;
    return Scaffold(
       backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: Text('Vilka bor här?'), actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            print('search button pressed');
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MemberSearch()),
            );
          },
        ),
      ]),

      body: Column(children: [
        HouseBadge(mask),
        AnimatedCard(
          animation: animation,
          building: building,
          hits1: hits1,
          hits2: hits2,
          hits3: hits3,
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          //   print('tapindex $index');
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

class AnimatedCard extends AnimatedWidget {
  String building;
  List<Member> hits1;
  List<Member> hits2;
  List<Member> hits3;

  AnimatedCard({
    Key key,
    Animation<double> animation,
    this.building,
    this.hits1,
    this.hits2,
    this.hits3,
  }) : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
//    Color floorcolor = Color(0xFF7B919E);
    final Animation<double> animation = listenable;
    //   print('animation value: ${animation.value}');
    Color floorcolor = Color(0xFF7B919E);
    // print('Color: ' + Color(0xFF7B919E).toString());
    if (building == '1') {
      floorcolor = Color(0xFF977981);
    }
    print(animation);
    const begin = Offset(0.0, 0.0);
    const end = Offset(0.0, 1.0);
    return SlideTransition(
      position: new Tween<Offset>(
        begin: begin,
        end: end,
      ).animate(animation),
      child: Container(
 //   constraints: BoxConstraints(maxHeight: animation.value),
          constraints: BoxConstraints(maxHeight: 400),
        //     color: Colors.grey,
        child: Column(
          children: [
            Expanded(
              child: Card(
                color: floorcolor,
                margin: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: hits1.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        '${hits1[index].lgh}  ${hits1[index].lmv}  ${hits1[index].membername}',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Card(
                color: floorcolor,
                margin: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: hits2.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        '${hits2[index].lgh}  ${hits2[index].lmv}  ${hits2[index].membername}',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Card(
                color: floorcolor,
                margin: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: hits3.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        '${hits3[index].lgh}  ${hits3[index].lmv}  ${hits3[index].membername}',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
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
    Color floorcolor = Color(0xFF7B919E);
    String floorname = 'Taxgatan 3';
    if (building == '1') {
      floorcolor = Color(0xFF977981);
      floorname = 'Taxgatan 7';
    }
    String trappor =
        (int.parse(this.mask.substring(1, 2)) - 1).toString() + " trappor";
    return (SizedBox(
      //      height: 40.0,
      width: 500.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 160.0,
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
              width: 160.0,
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
