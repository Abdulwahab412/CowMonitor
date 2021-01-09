import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  Map mapRes;
  http.Response res;
  Future fetch() async {
    res = await http.get(
        'https://api.thingspeak.com/channels/1247440/feeds.json?api_key=VAXYTLLSDP1F4JIW');
    if (res.statusCode == 200) {
      print(res.body);
      setState(() {
        mapRes = json.decode(res.body);
      });
    }
  }

  @override
  void initState() {
    fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('thingspeak data'),
          backgroundColor: Colors.blue[900],
        ),
        body: mapRes == null
            ? Container()
            : Text(
                mapRes["feeds"][0]['field5'].toString(),
                style: TextStyle(fontSize: 30),
              ));
  }
}
