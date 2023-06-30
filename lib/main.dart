import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

import 'dart:developer';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


Future<String> get() async {
  const domain = 'http://10.30.95.84:8080/ChatGPT';//ここに'http://0.0.0.0:0000'の形でサーバのアドレスとポート番号を記述する
  var url = Uri.parse(domain);
  Map<String, dynamic> pass = {
    'password': '1234',
    'body': {
       "model": "gpt-3.5-turbo",
       "messages": [
         {"role": "user", "content": "こんにちは"}
       ]
    }
  };
  var response = await http.post(url, body: jsonEncode(pass));
  Map<String, dynamic> map = jsonDecode(response.body);
  String message = map['message'].toString();
  return message;
}


class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String text = '受け取ったメッセージがここに表示されます';


  Future<void> _incrementCounter() async {
    String result = await get();
    setState(() {
      text = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              text,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
