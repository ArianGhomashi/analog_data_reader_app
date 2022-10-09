import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String url = 'http://192.168.4.1/';
  String resistance = 'null';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                resistance,
                style: TextStyle(
                  fontSize: 70,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Timer(Duration(seconds: 1), () async {
                    while (true) {
                      http.Response r = await http.get(Uri.parse(url + 'read'));
                      setState(() {
                        resistance = r.body;
                      });
                    }
                  });
                },
                child: Text('read data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
