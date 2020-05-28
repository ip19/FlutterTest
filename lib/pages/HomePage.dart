import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_listview_json/services/UserProfileService.dart';
import 'FollowersPage.dart';
import '../services/User.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserProfile userProfile = UserProfile();
  List<User> user = List<User>();

  @override
  void initState() {
    userProfile.fetchUserData().then((value) {
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
