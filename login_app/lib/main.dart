import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_app/menupage.dart';
//import 'package:login_app/kelompokpage.dart';

void main() => runApp(new MyApp());

String username = '';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo Apllications',
      home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/menupage': (BuildContext context) => new MenuPage(
              username: username,
            ),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';

  Future<List> _proseslogin() async {
    final response = await http
        .post("http://127.0.0.1/login_flutter/proses_login.php", body: {
      "username": user.text,
      "password": pass.text,
    });
    var dataadmin = json.decode(response.body);

    if (dataadmin.length == 1) {
      Navigator.pushReplacementNamed(context, '/menupage');
      setState(() {
        username = dataadmin[0]['username'];
      });
    } else {
      setState(() {
        msg = "Login Gagal";
      });
    }
    return dataadmin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.blue[900],
      ),
      backgroundColor: Colors.blue[100],
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black87,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  "img/ad_png.png",
                  width: 150,
                ), //Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Welcome To My Photography",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black87),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                controller: user,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)),
                    prefixIcon: Icon(
                      Icons.person,
                      size: 40,
                    ),
                    hintText: "Masukkan Username",
                    hintStyle: TextStyle(color: Colors.black87),
                    labelText: "Username",
                    labelStyle: TextStyle(color: Colors.black87))),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                controller: pass,
                obscureText: true, //hide kata sandi
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black87)),
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 40,
                    ),
                    hintText: "Masukkan Password",
                    hintStyle: TextStyle(color: Colors.black87),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.black87))),
            SizedBox(
              height: 20,
            ),
            Card(
              color: Colors.blue[900],
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Container(
                height: 50,
                child: InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    _proseslogin();
                  },
                  child: Center(
                    child: Text(
                      "Masuk",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Login With",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black87),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "img/facebook.png",
                    width: 80,
                  ),
                  Image.asset(
                    "img/google.png",
                    width: 80,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "You Agree To All Application Activity",
              style: TextStyle(
                  //fontWeight: FontWeight.bold

                  fontSize: 14,
                  color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}