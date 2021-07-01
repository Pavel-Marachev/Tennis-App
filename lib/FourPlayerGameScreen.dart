import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'GlobalVariables.dart' as globals;
import 'DataBase.dart';

int firstScore = 0, secondScore = 0;

class FourPlayerGameScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => FourPlayerGameScreenState();
}

class FourPlayerGameScreenState extends State{
  final dbHelper = DatabaseHelper.instance;
  String _currentAddress;

  Color firstIndicatorColor = Color(0xFF312E2E),
      secondIndicatorColor = Colors.grey[50],
      thirdIndicatorColor = Colors.grey[50],
      fourthIndicatorColor = Colors.grey[50];

  void _insertResults(firstPlayer, secondPlayer, thirdPlayer, fourthPlayer, firstScore, secondScore) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnFirstDepartmentName : firstPlayer,
      DatabaseHelper.columnSecondDepartmentName: secondPlayer,
      DatabaseHelper.columnFirstScore: firstScore,
      DatabaseHelper.columnSecondScore: secondScore,
      DatabaseHelper.columnThirdDepartmentName: thirdPlayer,
      DatabaseHelper.columnFourthDepartmentName: fourthPlayer,
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
    globals.thirdPlayerDepartment = "";
    globals.thirdPlayerName = "";
    globals.fourthPlayerDepartment = "";
    globals.fourthPlayerName = "";
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
          Column(
            children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("${globals.firstPlayerDepartment} ${globals.firstPlayerName}", style: TextStyle(fontFamily: 'Caveat', fontSize: 22)),
                              SizedBox(width: 3),
                              Icon(CupertinoIcons.circle_filled, color: firstIndicatorColor)
                            ],
                          ),
                          Row(
                            children: [
                              Text("${globals.secondPlayerDepartment} ${globals.secondPlayerName}", style: TextStyle(fontFamily: 'Caveat', fontSize: 22)),
                              SizedBox(width: 3),
                              Icon(CupertinoIcons.circle_filled, color: secondIndicatorColor)
                            ],
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Icon(CupertinoIcons.circle_filled, color: thirdIndicatorColor),
                              SizedBox(width: 3),
                              Text("${globals.thirdPlayerDepartment} ${globals.thirdPlayerName}", style: TextStyle(fontFamily: 'Caveat', fontSize: 22)),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(CupertinoIcons.circle_filled, color: fourthIndicatorColor),
                              SizedBox(width: 3),
                              Text("${globals.fourthPlayerDepartment} ${globals.fourthPlayerName}", style: TextStyle(fontFamily: 'Caveat', fontSize: 22)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ]
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FloatingActionButton(
                        heroTag: "btn1",
                        onPressed: (){
                          setState(() {
                            firstScore++;

                            if(firstIndicatorColor == Color(0xFF312E2E)){
                              firstIndicatorColor = Colors.grey[50];
                              secondIndicatorColor = Color(0xFF312E2E);
                            } else if(secondIndicatorColor == Color(0xFF312E2E)){
                              secondIndicatorColor = Colors.grey[50];
                              thirdIndicatorColor = Color(0xFF312E2E);
                            } else if(thirdIndicatorColor == Color(0xFF312E2E)){
                              thirdIndicatorColor = Colors.grey[50];
                              fourthIndicatorColor = Color(0xFF312E2E);
                            } else {
                              fourthIndicatorColor = Colors.grey[50];
                              firstIndicatorColor = Color(0xFF312E2E);
                            }
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
                                          "${globals.thirdPlayerDepartment} ${globals.thirdPlayerName}", "${globals.fourthPlayerDepartment} ${globals.fourthPlayerName}", firstScore, secondScore);
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
                        backgroundColor: Colors.black
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FloatingActionButton(
                        heroTag: "btn2",
                        onPressed: (){
                          setState(() {
                            secondScore++;

                            if(firstIndicatorColor == Color(0xFF312E2E)){
                              firstIndicatorColor = Colors.grey[50];
                              secondIndicatorColor = Color(0xFF312E2E);
                            } else if(secondIndicatorColor == Color(0xFF312E2E)){
                              secondIndicatorColor = Colors.grey[50];
                              thirdIndicatorColor = Color(0xFF312E2E);
                            } else if(thirdIndicatorColor == Color(0xFF312E2E)){
                              thirdIndicatorColor = Colors.grey[50];
                              fourthIndicatorColor = Color(0xFF312E2E);
                            } else {
                              fourthIndicatorColor = Colors.grey[50];
                              firstIndicatorColor = Color(0xFF312E2E);
                            }
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
                                          "${globals.thirdPlayerDepartment} ${globals.thirdPlayerName}", "${globals.fourthPlayerDepartment} ${globals.fourthPlayerName}", firstScore, secondScore);
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
                        backgroundColor: Colors.black
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