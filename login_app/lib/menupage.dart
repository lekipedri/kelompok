import 'package:flutter/material.dart';
//import 'package:login_app/kelompokpage.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Koneksi Flutter ke MySQL',
      //home: new MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/kelompokpage': (BuildContext context) => new Kelompok(),
      },
    );
  }
}

class MenuPage extends StatelessWidget {
  MenuPage({this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MENU UTAMA"),
        backgroundColor: Colors.blue[900],
      ),
      backgroundColor: Colors.blue[100],
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text(
                "AD Project Photography",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              accountEmail: new Text("ad.photography@photo.com"),
              currentAccountPicture: CircleAvatar(
                //backgroundImage: NetworkImage("img/ad_png.png"),
                child: Center(
                  child: Image.asset(
                    "img/ad_png.png",
                    width: 150,
                  ), //Icon(Icons.person, size: 50, color: Colors.white),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.blue[900]),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text("Profil"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.vpn_key),
              title: Text("Ubah Password"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("Tentang"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Keluar"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/');
              },
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            MyMenu(
              title: "Wedding Photo",
              icon: Icons.auto_awesome_mosaic,
              warna: Colors.pink,
            ),
            MyMenu(
              title: "Pre-wedding Photo",
              icon: Icons.auto_awesome_motion,
              warna: Colors.brown,
            ),
            MyMenu(
              title: "Engagement Photo",
              icon: Icons.photo_rounded,
              warna: Colors.blue,
            ),
            MyMenu(
              title: "Group Photo",
              icon: Icons.photo_library_outlined,
              warna: Colors.red,
            ),
            MyMenu(
              title: "Personal Photo",
              icon: Icons.photo_library,
              warna: Colors.yellow,
            ),
            MyMenu(
              title: "Informasi",
              icon: Icons.info_outline,
              warna: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

class MyMenu extends StatelessWidget {
  MyMenu({this.title, this.icon, this.warna});

  final String title;
  final IconData icon;
  final MaterialColor warna;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        splashColor: Colors.green,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icon,
                size: 70.0,
                color: warna,
              ),
              Text(
                title,
                style: new TextStyle(fontSize: 17.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';

//class untuk nama kelompok
class Kelompok extends StatelessWidget {
  Kelompok({this.username});
  final String username;

  Future<List> tampilan() async {
    final response =
        await http.get("http://127.0.0.1/login_flutter/tampilan.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Nama Kelompok"),
      ),
      body: new FutureBuilder<List>(
        future: tampilan(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List list;

  ItemList({this.list});
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          padding: const EdgeInsets.all(10.0),
          child: new Card(
            child: new ListTile(
              title: new Text(list[i]['nama_mhs']),
              leading: new Icon(Icons.widgets),
              subtitle: new Text("NPM : ${list[i]['npm']}"),
            ),
          ),
        );
      },
    );
  }
}
