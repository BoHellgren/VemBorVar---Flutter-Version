import 'package:flutter/material.dart';
import 'members.dart';
import 'wholivehere.dart';


class MemberSearch extends StatefulWidget {
//  final String mask;

  MemberSearch();
  @override
  _MemberSearchState createState() => _MemberSearchState();
}

class _MemberSearchState extends State<MemberSearch> {
  final TextEditingController myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    print('Start listening to changes');
    myController.addListener(_findHits);
  }

  @override
  void dispose() {
    // Stop listening to text changes
    myController.removeListener(_findHits);
    // Clean up the controller when the Widget is removed from the Widget tree
    myController.dispose();
    super.dispose();
  }

  _MemberSearchState();

  List<Member> hits = members;

  void _findHits() {
    String lookfor;
    setState(() {
      print("Search text: ${myController.text}");
      hits = [];
      lookfor = myController.text.toLowerCase();

      members.forEach((member) {
        //  if (member.lgh.substring(0, 2) == '28') hits.add(member);
        if (member.membername.toLowerCase().contains(lookfor) ||
            member.lgh.contains(lookfor) ||
            member.lmv.contains(lookfor)) hits.add(member);
      });
      print('Hits length: ${hits.length}');
    });
  }

  void _resetSearch() {
    print('input cancelled');
    setState(() {
      hits = members;
      myController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    print("_MemberSearchState build called");

    return Scaffold(
      //     resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        title: TextField(
          controller: myController,
          autofocus: false,
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8.0))),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.only(left: 8.0),
            hintText: "Skriv namn eller lgh-nr",
            hintStyle: TextStyle(color: Colors.grey),
            suffix: IconButton(
              icon: Icon(Icons.cancel),
              color: Colors.grey,
              onPressed: () {
                _resetSearch();
              },
            ),
          ),
        ),
      ),
      body: Card(
        color: Theme.of(context).backgroundColor,
        margin: const EdgeInsets.all(8.0),
        child: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: hits.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                print('line $index ${hits[index].membername} tapped');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WhoLiveHere(mask: hits[index].lgh.substring(0, 2), calledBy: 'Search'),
                )
                );
              },
              child: Row(children: <Widget>[
                Padding(
                  padding: new EdgeInsets.all(4.0),
                  child: Text(
                    '${hits[index].lgh}    ${hits[index].lmv}    ${hits[index].membername}  ',
                      style: TextStyle(fontSize: 16.0, height: 0.9),
                  ),
                ),
                Icon(Icons.arrow_forward, size: 15.0),
              ]),
            );
          },
        ),
      ),
    );
  }
}
