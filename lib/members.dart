class Member {
  const Member({this.lgh, this.lmv, this.membername});

  final String lgh;
  final String lmv;
  final String membername;
}

const List<Member> members = const <Member>[
  const Member(lgh: '123', lmv: '1001', membername: 'Tomas Frank'),
  const Member(lgh: '123', lmv: '1001', membername: 'Anna Jansson'),
  const Member(lgh: '131', lmv: '1102', membername: 'Lennart Axelsson'),
  const Member(lgh: '131', lmv: '1102', membername: 'Yvonne Axelsson'),
  const Member(lgh: '132', lmv: '1103', membername: 'Stefan Killander'),
  const Member(lgh: '132', lmv: '1103', membername: 'Cecilia Killander'),
  const Member(lgh: '133', lmv: '1101', membername: 'Clas Halldin'),
  const Member(lgh: '133', lmv: '1101', membername: 'Gunilla Halldin'),
  const Member(lgh: '141', lmv: '1202', membername: 'Anders Nyman'),
  const Member(lgh: '142', lmv: '1203', membername: 'Bo Niveman'),
  const Member(lgh: '142', lmv: '1203', membername: 'Viveca Niveman'),
  const Member(lgh: '143', lmv: '1201', membername: 'Mikael Andersson'),
  const Member(lgh: '143', lmv: '1201', membername: 'Elif Eroglu Andersson'),
  const Member(lgh: '151', lmv: '1302', membername: 'Lennart Andreasson'),
  const Member(lgh: '152', lmv: '1303', membername: 'Martin Blom'),
  const Member(lgh: '152', lmv: '1303', membername: 'Agnieszka Blom'),
  const Member(lgh: '153', lmv: '1301', membername: 'Leif Edvinsson'),
  const Member(lgh: '153', lmv: '1301', membername: 'Gunilla Edvinsson'),
  const Member(lgh: '161', lmv: '1402', membername: 'Ola Ohlson'),
  const Member(lgh: '162', lmv: '1403', membername: 'Bert Conneryd'),
  const Member(lgh: '162', lmv: '1403', membername: 'Barbro Lorentzon'),
  const Member(lgh: '163', lmv: '1401', membername: 'Stefan Söderström'),
  const Member(lgh: '163', lmv: '1401', membername: 'Indira Furniss'),
  const Member(lgh: '171', lmv: '1501', membername: 'Anders Tolleson'),
  const Member(lgh: '171', lmv: '1501', membername: 'Ditte Tolleson'),
  const Member(lgh: '221', lmv: '1001', membername: 'Mikaela Cadstedt'),
  const Member(lgh: '222', lmv: '1002', membername: 'Michael Askebrink'),
  const Member(lgh: '222', lmv: '1002', membername: 'Jannica Askebrink'),
  const Member(lgh: '231', lmv: '1102', membername: 'Erik Kinnander'),
  const Member(lgh: '231', lmv: '1102', membername: 'Marthe Kinnander'),
  const Member(lgh: '232', lmv: '1103', membername: 'Richard Wilhelmsson'),
  const Member(lgh: '232', lmv: '1103', membername: 'Jenny Wilhelmsson'),
  const Member(lgh: '233', lmv: '1101', membername: 'Eva Clausen'),
  const Member(lgh: '241', lmv: '1202', membername: 'Richard Larsson'),
  const Member(lgh: '241', lmv: '1202', membername: 'Annika Lignell'),
  const Member(lgh: '242', lmv: '1203', membername: 'Sebastian Tham'),
  const Member(lgh: '242', lmv: '1203', membername: 'Johanna Tham'),
  const Member(lgh: '243', lmv: '1201', membername: 'Emelie Jin'),
  const Member(lgh: '251', lmv: '1302', membername: 'Sebastian Svartz'),
  const Member(lgh: '251', lmv: '1303', membername: 'Amelie Winberg'),
  const Member(lgh: '252', lmv: '1303', membername: 'Jan Arfwidsson'),
  const Member(lgh: '253', lmv: '1301', membername: 'Johan Eriksson'),
  const Member(lgh: '253', lmv: '1301', membername: 'Emma Eriksson'),
  const Member(lgh: '261', lmv: '1402', membername: 'Mårten Renberg'),
  const Member(lgh: '261', lmv: '1402', membername: 'Sara Renberg'),
  const Member(lgh: '262', lmv: '1403', membername: 'Tomas Parmbäck'),
  const Member(lgh: '262', lmv: '1403', membername: 'Susanna Parmbäck'),
  const Member(lgh: '263', lmv: '1401', membername: 'Bo Selling'),
  const Member(lgh: '263', lmv: '1401', membername: 'Hanna Selling'),
  const Member(lgh: '271', lmv: '1502', membername: 'Daniel Granlycke'),
  const Member(lgh: '271', lmv: '1502', membername: 'Sanna Berg'),
  const Member(lgh: '272', lmv: '1503', membername: 'Carl Wegener'),
  const Member(lgh: '272', lmv: '1503', membername: 'Erika Wegener'),
  const Member(lgh: '273', lmv: '1501', membername: 'Viktor Bodin'),
  const Member(lgh: '273', lmv: '1501', membername: 'Beatrice Backman'),
  const Member(lgh: '281', lmv: '1601', membername: 'Anna Sköld'),
  const Member(lgh: '282', lmv: '1602', membername: 'Bo Hellgren'),
  const Member(lgh: '282', lmv: '1602', membername: 'Ingalill Hellgren'),
];

// class test {
  locateMembers() {
    // returns an array with one entry per floor
    // each entry holds six members, two for each apartment

    List<Member> hits = []; // all members on a certain floor

    var nobody = Member(lgh: '', lmv: '', membername: ''); // for apt with only one member, or non-existing apartment
    var floors = []; // six or seven floors in each building
    var newfloors = [];
    // First insert members on each floor
    String apt = members[0].lgh;
    String floor = '';
    String oldfloor = apt.substring(1, 2);
    for (var i = 0; i < members.length; i++) {
      apt = members[i].lgh;
      floor = apt.substring(1, 2);
      if (floor == oldfloor) {
        hits.add(members[i]);
      } else {
        floors.add(hits);
        oldfloor = floor;
        hits = [];
        hits.add(members[i]);
      }
    }
    floors.add(hits);
    // Now insert nobody-members where needed
    for (var i = 0; i < floors.length; i++) {
      hits = floors[i];
      var newhits = [];
      int numinapt = 0;
      String oldlgh = hits[0].lgh;

      for (var j = 0; j < 6; j++) {
        if (j < hits.length) {
          var lgh = hits[j].lgh;
          if (lgh == oldlgh) {
            newhits.add(hits[j]);
            numinapt++;
          } else {
            if (numinapt < 2) newhits.add(nobody);
            newhits.add(hits[j]);
            numinapt = 1;
            oldlgh = lgh;
          }
        } else {
          newhits.add(nobody);
        }
      }
      newfloors.add(newhits);
    }
    return newfloors;
  }
// }
