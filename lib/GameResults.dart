import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DataBase.dart';
import 'dart:convert';

class GameResults extends StatefulWidget{
  @override
  _GameResultsState createState() => _GameResultsState();
}

class _GameResultsState extends State<GameResults> {
  final dbHelper = DatabaseHelper.instance;

  List<Map<String, dynamic>> results = [];

  Future<List> _queryResult() async {
    List<Map<String, dynamic>> allRows = await dbHelper.queryAllRowsResults();
    return allRows.toList();
  }

  @override
  Widget build(BuildContext context) {
    _queryResult().then((value) => {if(this.mounted){setState(()=>{this.results = value})}});

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text("История игр", style: TextStyle(fontFamily: 'Caveat', fontSize: 25)),
        ),
        body: Center(
          child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, i){
                var document = jsonDecode(jsonEncode(results[i]));

                return new Column(
                  children: [
                    Center(
                      child:Table(
                        children: [
                          TableRow(children: [
                            Center(child: Column(
                              children: [
                                Text("${document['data']}", style: TextStyle(color: Colors.grey),),
                                SizedBox(height: 5),
                                Text("${document['address']}", style: TextStyle(color: Colors.grey),),
                                SizedBox(height: 10),
                                Text("${document['firstScore']}  :  ${document['secondScore']}", style: TextStyle(fontSize: 17)),
                                SizedBox(height: 5)
                              ],
                            ))
                          ]),
                          TableRow(children: [
                            Row(
                              children:[
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("${document['firstDepartmentName']}"),
                                      if(document['thirdDepartmentName'] != null) Text("${document['secondDepartmentName']}")
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      if(document['thirdDepartmentName'] == null) Text("${document['secondDepartmentName']}"),
                                      if(document['thirdDepartmentName'] != null) Text("${document['thirdDepartmentName']}"),
                                      if(document['thirdDepartmentName'] != null) Text("${document['fourthDepartmentName']}")
                                    ],
                                  ),
                                )
                              ],
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            )
                          ]),
                        ],
                      ),
                    ),
                    new Divider()
                  ],
                );
              }
          )
        )
    );
  }
}