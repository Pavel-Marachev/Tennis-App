import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/FourPlayerGameScreen.dart';
import 'package:test_app/TwoPlayerGameScreen.dart';
import 'AddNewPlayer.dart';
import 'DataBase.dart';

import 'GlobalVariables.dart' as globals;

class StartGame extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => StartGameState();
}

class StartGameState extends State {
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> department = [];
  List<Map<String, dynamic>> name = [];
  String chosenName, chosenDepartment;

  final controller = PageController(
    initialPage: 0,
  );

  Future<List> _queryDepartment() async {
    List<Map<String, dynamic>> allRows = await dbHelper.queryDepartment();
    return allRows.toList();
  }

  Future<List> _queryName() async {
    List<Map<String, dynamic>> allRows = await dbHelper.queryName();
    return allRows.toList();
  }

  List<DropdownMenuItem> myDropdownMenuItemDepartment(){
    List<DropdownMenuItem> myItemList = [];
      for (int i = 0; i < department.length; i++){
        myItemList.add(DropdownMenuItem(child: Text(jsonDecode(jsonEncode(department[i]))['department'], overflow: TextOverflow.ellipsis,), value: jsonDecode(jsonEncode(department[i]))['department']));
      }
      return myItemList;
  }

  List<DropdownMenuItem> myDropdownMenuItemName(){
    List<DropdownMenuItem> myItemList = [];
    for (int i = 0; i < name.length; i++){
      myItemList.add(DropdownMenuItem(child: Text(jsonDecode(jsonEncode(name[i]))['name'], overflow: TextOverflow.ellipsis,), value: jsonDecode(jsonEncode(name[i]))['name']));
    }
    return myItemList;
  }


  TableRow myTableRow(int id){
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 15.0, 10.0),
          child: Text(
            "$id",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18.0
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          child: DropdownButtonFormField(
            isExpanded: true,
            items: myDropdownMenuItemDepartment(),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Отдел",
            ),
            onChanged: (value) {
              setState(() {
                if(id == 1) {
                  globals.firstPlayerDepartment = value;
                } else if (id == 2){
                  globals.secondPlayerDepartment = value;
                } else if (id == 3){
                  globals.thirdPlayerDepartment = value;
                } else if (id == 4){
                  globals.fourthPlayerDepartment = value;
                }
              });
            }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          child: DropdownButtonFormField(
            items: myDropdownMenuItemName(),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Имя",
            ),
            onChanged: (value) {
              setState(() {
                if(id == 1) {
                  globals.firstPlayerName = value;
                } else if (id == 2){
                  globals.secondPlayerName = value;
                } else if (id == 3){
                  globals.thirdPlayerName = value;
                } else if (id == 4){
                  globals.fourthPlayerName = value;
                }
              });
            }
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _queryDepartment().then((value) => {if(this.mounted){setState(()=>{this.department = value})}});
    _queryName().then((value) => {if(this.mounted){setState(()=>{this.name = value})}});

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text("Формирование команд", style: TextStyle(fontFamily: 'Caveat', fontSize: 25),),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_circle, color: Colors.white),
              tooltip: "Добавление учасников",
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddNewPlayer())
                );
              },
            )
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Двое"),
              Tab(text: "Четверо"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: {0: FractionColumnWidth(.09)},
                  children: [
                    myTableRow(1),
                    myTableRow(2),
                  ],
                ),
                SizedBox(height: 350),
                ElevatedButton(onPressed: (){
                  if(globals.firstPlayerDepartment != "" && globals.firstPlayerName != "" && globals.secondPlayerDepartment != "" && globals.secondPlayerName != ""){
                    Navigator.push(
                        context,
                       MaterialPageRoute(builder: (context) => TwoPlayerGameScreen())
                    );
                  }
                }, child: Text("Начать игру")),
              ],
            ),
            Column(
              children: [
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: {0: FractionColumnWidth(.09)},
                  children: [
                    myTableRow(1),
                    myTableRow(2),
                    myTableRow(3),
                    myTableRow(4),
                  ],
                ),
                SizedBox(height: 162),
                ElevatedButton(onPressed: (){
                  if(globals.firstPlayerDepartment != "" && globals.firstPlayerName != "" && globals.secondPlayerDepartment != "" && globals.secondPlayerName != ""
                      && globals.thirdPlayerDepartment != "" && globals.thirdPlayerName != "" && globals.fourthPlayerDepartment != "" && globals.fourthPlayerName != ""){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FourPlayerGameScreen())
                    );
                  }
                }, child: Text("Начать игру")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}