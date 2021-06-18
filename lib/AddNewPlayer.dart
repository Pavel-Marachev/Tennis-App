import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DataBase.dart';

class FormOfScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => FormOfScreenState();
}

class FormOfScreenState extends State{
  final dbHelper = DatabaseHelper.instance;
  final _formKey = GlobalKey<FormState>();
  FocusNode _focusNode;
  
  String name, department;

  void _insert(name, department) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : name,
      DatabaseHelper.columnDepartment : department
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }


  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(10.0),
      child: Form (
        key: _formKey,
        child: new Column(children: <Widget>[
          new TextFormField(
            decoration: InputDecoration(
              icon:  Icon(Icons.person),
              hintText: 'Введите своё имя',
              labelText: 'Имя*',
            ),
            validator: (value) {
              return (value.isEmpty) ? 'Пожалуйста введите свое имя' : null;
            },
            onSaved: (String value) {
              name = value;
            },
          ),

          new TextFormField(
            decoration: InputDecoration(
              icon:  Icon(Icons.business),
              hintText: 'Введите свой отдел',
              labelText: 'Отдел*',
            ),
            validator: (value) {
              return (value.isEmpty) ? 'Пожалуйста введите свой отдел' : null;
            },
            onSaved: (value){
              department = value;
            },
          ),

          new SizedBox(height: 20.0),

          new ElevatedButton(onPressed: (){
            if(_formKey.currentState.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text('Игрок добавлен'), backgroundColor: Colors.green,));
              FocusScope.of(context).unfocus();
              _formKey.currentState.save();
              _formKey.currentState.reset();
              _insert(name, department);
            }
          },
            child: Text('Добавить'),
          ),
        ]),
      ),
    );
  }
}

class AddNewPlayer extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Добавление нового игрока", style: TextStyle(fontFamily: 'Caveat', fontSize: 25)),
      ),
      body: FormOfScreen()
    );
  }
}