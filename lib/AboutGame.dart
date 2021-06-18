import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class RequestState {
  const RequestState();
}

class RequestInitial extends RequestState {}

class RequestLoadInProgress extends RequestState {}

class RequestLoadSuccess extends RequestState {
  const RequestLoadSuccess(this.body);
  final String body;
}

class RequestLoadFailure extends RequestState {}


class AboutGame extends StatelessWidget{
  final resultNotifier = ValueNotifier<RequestState>(RequestInitial());
  static const urlPrefix = 'https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exlimit=max&explaintext&exintro&titles=Table_tennis';

  void _handleResponse(Response response) {
    if (response.statusCode >= 400) {
      resultNotifier.value = RequestLoadFailure();
    } else {
      resultNotifier.value = RequestLoadSuccess(response.body);
    }
  }
  Future<void> makeGetRequest() async {
    resultNotifier.value = RequestLoadInProgress();
    final url = Uri.parse('$urlPrefix');
    Response response = await get(url);
    print('Status code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
    _handleResponse(response);
  }


  @override
  Widget build(BuildContext context) {
    makeGetRequest();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text("Об игре", style: TextStyle(fontFamily: 'Caveat', fontSize: 25)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            ValueListenableBuilder<RequestState>(
              valueListenable: resultNotifier,
              builder: (context, requestState, child) {
                if (requestState is RequestLoadInProgress) {
                  return CircularProgressIndicator();
                } else if (requestState is RequestLoadSuccess) {
                  var document = jsonDecode(requestState.body);
                  return Expanded(child: SingleChildScrollView(child: Text("${document['query']['pages']['30589']['extract']}", style: TextStyle(fontFamily: 'Caveat', fontSize: 21))));
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}