import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_listview_json/services/Follower.dart';
import 'package:flutter_listview_json/services/User.dart';
import 'package:http/http.dart' as http;

import '../services/User.dart';

class FollowersPage extends StatefulWidget {
  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  List<Follower> follower = List<Follower>();
  List<User> user = List<User>();

  Future<List<Follower>> fetchFollowerData() async {
    final login = 'igorsegallafa';
    final url = 'https://api.github.com/users/' + login + '/followers';
    final response = await http.get(url);

    var followers = List<Follower>();

    if (response.statusCode == 200) {
      final followersJson = json.decode(response.body);
      for (final followerJson in followersJson) {
        followers.add(Follower.fromJson(followerJson));
      }
    }
    return followers;
  }

  @override
  void initState() {
    fetchFollowerData().then((value) {
      setState(() {
        follower.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('GitHub Followers'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 50.0, bottom: 50.0, left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      follower[index].login,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: Image.network(
                        follower[index].avatarUrl,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: follower.length,
        ));
  }
}
