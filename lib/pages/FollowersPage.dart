import 'package:flutter/material.dart';
import 'package:flutter_listview_json/services/FollowerProfileService.dart';

class FollowersPage extends StatefulWidget {
  @override
  _FollowersPageState createState() => _FollowersPageState();
}

class _FollowersPageState extends State<FollowersPage> {
  List<FollowerProfile> followerProfile = List<FollowerProfile>();
  final FollowerProfileService followerProfileService =
      FollowerProfileServiceImpl();

  @override
  void initState() {
    followerProfileService.getFollowerProfiles().then((value) {
      setState(() {
        followerProfile.addAll(value);
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
                      followerProfile[index].login,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: Image.network(
                        followerProfile[index].avatar_url,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: followerProfile.length,
        ));
  }
}
