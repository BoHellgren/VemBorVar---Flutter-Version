// import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart' show timeDilation;
// import 'package:flutter/rendering.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'wholivehere.dart';
import 'membersearch.dart';

class VemBorVar extends StatefulWidget {
  @override
  _VemBorVarState createState() => _VemBorVarState();
}

class _VemBorVarState extends State<VemBorVar> {
/*    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }  */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.light(),
        home: Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(58.0),
            child: MyAppBar(),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Stack(
                  alignment: const Alignment(0.0, -0.4),
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: Image.asset(
                        'images/logga.png',
                        width: 332.0,
                        //     height: 100.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Opacity(
                        opacity: 0.7,
                        child: Text('Brf Husarvikens Strand',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.white)))
                  ],
                ),
              ),
              Expanded(
                child: Card(
                    //      color: Theme.of(context).primaryColor,
                    color: Theme.of(context).backgroundColor,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                            color: Color(0xFF7B919E),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Taxgatan 3',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                  HouseButton('7 trappor', '28'),
                                  HouseButton('6 trappor', '27'),
                                  HouseButton('5 trappor', '26'),
                                  HouseButton('4 trappor', '25'),
                                  HouseButton('3 trappor', '24'),
                                  HouseButton('2 trappor', '23'),
                                  HouseButton('1 trappa', '22'),
                                ]),
                          ),
                          Card(
                            color: Color(0xFF977981),
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Taxgatan 7',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0),
                                  ),
                                  HouseButton('6 trappor', '17'),
                                  HouseButton('5 trappor', '16'),
                                  HouseButton('4 trappor', '15'),
                                  HouseButton('3 trappor', '14'),
                                  HouseButton('2 trappor', '13'),
                                  HouseButton('1 trappa', '12'),
                                ]),
                          ),
                        ])),
              ),
              // buttonSection,
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              "2018-12-20",
              textAlign: TextAlign.center,
            ),
          ),
        ));
  }
}

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        'Vem Bor Var ?',
      ),
      actions: <Widget>[
        IconButton(
          //    icon: Icon(Icons.search),
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 1000),
                    pageBuilder: (BuildContext context,
                        Animation<double> animation,
                        Animation<double> secondaryAnimation) {
                      return MemberSearch();
                    },
                    transitionsBuilder: (
                      BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation,
                      Widget child,
                    ) {
                      return new SlideTransition(
                        position: new Tween<Offset>(
                          begin: const Offset(0.0, 1.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    }));
          },
        ),
      ],
    );
  }
}

class HouseButton extends StatelessWidget {
  final _floorName;
  final _mask;

  HouseButton(this._floorName, this._mask);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.push(
                  context,
                  PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 2000),
                      pageBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return AnimatedBuilder(
                            animation: animation,
                            builder: (BuildContext context, Widget child) {
                              return Opacity(
                                opacity: animation.value,
                                child:
                                    WhoLiveHere(mask: _mask, calledBy: 'Home'),
                              );
                            });
                      }))

              /*   Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WhoLiveHere(mask: _mask, calledBy: 'Home')),
          ) */
              ;
        },
        child: Hero(
          tag: _mask,
          transitionOnUserGestures: true,
          flightShuttleBuilder:
              (flightContext, animation, direction, fromContext, toContext) {
            //   return Icon(Icons.domain, size: 50.0,);},
            return Image.asset('images/32px-Elevator_icon.png');
          },
          child: SizedBox(
            height: 43.0,
            width: 148.0,
            child: Card(
                elevation: 5.0,
                color: Theme.of(context).buttonColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7.0),
                  child: Text(
                    _floorName,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0),
                  ),
                )),
          ),
        ),
      );
}

void main() {
//  debugPaintSizeEnabled=true;
  runApp(VemBorVar());
}
