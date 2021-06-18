import 'package:flutter/material.dart';
import 'package:test_app/GameResults.dart';

import 'AboutGame.dart';
import 'StartGame.dart';

class Button0 extends StatelessWidget {

  String _title;

  Button0(title){
    this._title = title;
  }

  void buttonAction(context){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => StartGame())
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        buttonAction(context);
      },
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 50.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.black87,
        ),
        child: Center(
          child: Text(_title, style: TextStyle(color: Colors.white, fontFamily: 'Caveat', fontSize: 22)),
        ),
      ),
    );
  }
}

class Button1 extends Button0{

  Button1(_title) : super(_title);

  @override
  void buttonAction(context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GameResults())
    );
  }
}

class Button2 extends Button0{

  Button2(_title) : super(_title);

  @override
  void buttonAction(context) {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AboutGame())
    );
  }
}

class MainMenu extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Button0("Начать игру"),
                  SizedBox(height: 10),
                  Button1("История игр"),
                  SizedBox(height: 10),
                  Button2("Об игре")
                ],
              )
        )
    );
  }
}