import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
import 'wholivehere.dart';
import 'membersearch.dart';

class VemBorVar extends StatefulWidget {
  @override
  _VemBorVarState createState() => _VemBorVarState();
}

class _VemBorVarState extends State<VemBorVar> {
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
              Image.asset(
                'images/logga.png',
                //     width: 600.0,
                //     height: 100.0,
                fit: BoxFit.cover,
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
                            //  color: Colors.pinkAccent[100],
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
              "2018-12-12",
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
          icon: Icon(Icons.search),
          onPressed: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 500),
                    pageBuilder: (
                        BuildContext context,
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
            MaterialPageRoute(
                builder: (context) =>
                    WhoLiveHere(mask: _mask, calledBy: 'Home')),
          );
        },
        child: Hero(
          tag: _mask,
          transitionOnUserGestures: true,
          flightShuttleBuilder:
              (flightContext, animation, direction, fromContext, toContext) {
              return Icon(Icons.domain, size: 50.0,);},
         //   return Image.asset('images/128px-Elevator_icon.png');},
          child: SizedBox(
            //      height: 40.0,
            width: 160.0,
            child: Card(
                color: Theme.of(context).buttonColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
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
