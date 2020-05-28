import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FollowersPage.dart';
import '../services/User.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> user = List<User>();

  Future<List<User>> fetchUserData() async {
    var url = 'https://api.github.com/gists/public';
    var response = await http.get(url);

    var users = List<User>();

    if (response.statusCode == 200) {
      var usersJson = json.decode(response.body);
      for (var userJson in usersJson) {
        users.add(User.fromJson(userJson));
      }
    }
    return users;
  }

  @override
  void initState() {
    fetchUserData().then((value) {
      setState(() {
        user.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('GitHub users'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
                child: InkWell(
              splashColor: Colors.green,
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => FollowersPage()));
              },
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 50.0, bottom: 50.0, left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      user[index].owner.login,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: Image.network(
                        user[index].owner.avatarUrl,
                      ),
                    ),
                  ],
                ),
              ),
            ));
          },
          itemCount: user.length,
        ));
  }
}
