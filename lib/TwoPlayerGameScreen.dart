import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'GlobalVariables.dart' as globals;
import 'DataBase.dart';

int firstScore = 0, secondScore = 0;
String _currentAddress;

class TwoPlayerGameScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => TwoPlayerGameScreenState();
}

class TwoPlayerGameScreenState extends State{
  final dbHelper = DatabaseHelper.instance;
  int counter = 1;
  Color firstButtonColor = Color(0xFF312E2E),
      secondButtonColor = Color(0xFF908C8C);

  void _insertResults(firstPlayer, secondPlayer, firstScore, secondScore) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnFirstDepartmentName : firstPlayer,
      DatabaseHelper.columnSecondDepartmentName: secondPlayer,
      DatabaseHelper.columnFirstScore: firstScore,
      DatabaseHelper.columnSecondScore: secondScore,
      DatabaseHelper.columnAddress: _currentAddress
    };
    final id = await dbHelper.insertResults(row);
    print('inserted row id: $id');
  }

  void myDispose(){
    firstScore = 0;
    secondScore = 0;
    globals.firstPlayerName = "";
    globals.firstPlayerDepartment = "";
    globals.secondPlayerName = "";
    globals.secondPlayerDepartment = "";
  }

  @override
  Widget build(BuildContext context) {
    globals.getUserLocation().then((value) => {if(this.mounted){setState(()=>{_currentAddress = value})}});

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text("Игра", style: TextStyle(fontFamily: 'Caveat', fontSize: 25)),
        ),
        body: Column(
          children: [
            Table(
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Center(child: Text("${globals.firstPlayerDepartment} ${globals.firstPlayerName}", style: TextStyle(fontFamily: 'Caveat', fontSize: 22))),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Center(child: Text("${globals.secondPlayerDepartment} ${globals.secondPlayerName}", style: TextStyle(fontFamily: 'Caveat', fontSize: 22))),
                    ),
                  ]
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FloatingActionButton(
                          heroTag: "btn1",
                          onPressed: (){
                            setState(() {
                              firstScore++;
                              if(counter.isEven) {
                                if(firstButtonColor == Color(0xFF312E2E)){
                                  firstButtonColor = Color(0xFF908C8C);
                                  secondButtonColor = Color(0xFF312E2E);
                                } else {
                                  firstButtonColor = Color(0xFF312E2E);
                                  secondButtonColor = Color(0xFF908C8C);
                                }
                              }
                              counter++;
                            });

                            if((firstScore >= 11 && firstScore - secondScore >= 2) || (secondScore >= 11 && secondScore - firstScore >= 2)) {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => CupertinoAlertDialog(
                                  title: const Text('Игра окончена'),
                                  content: Text('Игра окончена. Счет $firstScore-$secondScore'),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        _insertResults("${globals.firstPlayerDepartment} ${globals.firstPlayerName}", "${globals.secondPlayerDepartment} ${globals.secondPlayerName}",
                                            firstScore, secondScore);
                                        Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                                        myDispose();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }

                            },
                          child: Text("$firstScore", textScaleFactor: 1.25),
                          backgroundColor: firstButtonColor
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FloatingActionButton(
                          heroTag: "btn2",
                          onPressed: (){
                            setState(() {
                              secondScore++;
                              if(counter.isEven) {
                                if(firstButtonColor == Color(0xFF312E2E)){
                                  firstButtonColor = Color(0xFF908C8C);
                                  secondButtonColor = Color(0xFF312E2E);
                                } else {
                                  firstButtonColor = Color(0xFF312E2E);
                                  secondButtonColor = Color(0xFF908C8C);
                                }
                              }
                              counter++;
                            });

                            if((firstScore >= 11 && firstScore - secondScore >= 2) || (secondScore >= 11 && secondScore - firstScore >= 2)) {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => CupertinoAlertDialog(
                                  title: const Text('Игра окончена'),
                                  content: Text('Игра окончена. Счет $firstScore-$secondScore'),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      onPressed: () {
                                        _insertResults("${globals.firstPlayerDepartment} ${globals.firstPlayerName}", "${globals.secondPlayerDepartment} ${globals.secondPlayerName}",
                                            firstScore, secondScore);
                                        Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                                        myDispose();
                                      },
                                      child: const Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }

                            },
                          child: Text("$secondScore", textScaleFactor: 1.25),
                          backgroundColor: secondButtonColor
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(child: MyListView())
          ],
        ),
    );
  }
}

class MyListView extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => MyListViewState();
}

class MyListViewState extends State{
  List<String> array = ["0\t:\t0"];
  int firScore = 0, secScore = 0;

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: array.length,
        itemBuilder: (context, i){

          if(firstScore != firScore || secondScore != secScore){
            firScore = firstScore;
            secScore = secondScore;

            array.addAll(["$firScore\t:\t$secScore"]);
          }

          return new Column(children:[ListTile(title: Center(child: new Text(array[i], style: TextStyle(fontSize: 19),))), Divider()]);
        }
    );
  }
}