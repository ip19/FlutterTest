import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Follower.dart';
import 'User.dart';

class UserProfile {
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
}
