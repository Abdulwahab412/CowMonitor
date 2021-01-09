import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:FypProject/login.dart';
import 'addanimal.dart';
import 'package:FypProject/youranimal.dart';
import 'package:firebase_database/firebase_database.dart';

import 'alaram.dart';
import 'data1.dart';

import 'animalrecord.dart';

class insedate extends StatefulWidget {
  @override
  _insedateState createState() => _insedateState();
}

class _insedateState extends State<insedate> {
  List<data> mydata = [];

  void initState() {
    DatabaseReference ref = FirebaseDatabase.instance.reference();
    ref.child('Insemination').once().then((DataSnapshot snap) {
      var keys = snap.value.keys;
      var datas = snap.value;
      mydata.clear();
      for (var key in keys) {
        data d = new data(
          datas[key]['Average_steps'],
          datas[key]['Average_temperature'],
          datas[key]['Last_insemination_date'],
           datas[key]['AnimalId'],
          // datas[key]['Vaccination Name'],
        );

        mydata.add(d);
      }
      setState(() {
        print('Length : ${mydata.length}');
      });
      print(mydata);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Animals'),
        backgroundColor: Colors.purple,
      ),
      body: new Container(
          color: Colors.blueGrey,
          child: mydata.length == 0
              ? new Text(' No Data is Available')
              : new ListView.builder(
                  itemCount: mydata.length,
                  itemBuilder: (_, index) {
                    return UI(
                      mydata[index].Average_steps,
                      mydata[index].Average_temperature,
                      mydata[index].Last_insemination_date,
                     mydata[index].AimalId,
                    //  mydata[index].InsseminationDate,
                    );
                  },
                )),
    );
  }

  Widget UI(String AimalId, String Average_steps, String Average_temperature,
      String Last_insemination_date) {
    return new Card(
      color: Colors.grey[300],
      elevation: 30.0,
      child: new Container(
        padding: new EdgeInsets.all(30.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(
              'AimalId : $AimalId',
              style: Theme.of(context).textTheme.title,
            ),
            new Text(
              'Average_steps : $Average_steps',
            ),
            new Text('Last_insemination_date : $Last_insemination_date'),
            // new Text('VaccinationDate : $VaccinationDate'),
            new Text('Average_temperature : $Average_temperature'),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                    color: Colors.redAccent,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AnimalRecord()));
                    },
                    child: const Text("View")),
                FlatButton(
                    color: Colors.yellowAccent,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => alaram()));
                    },
                    child: const Text("Alaram"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
