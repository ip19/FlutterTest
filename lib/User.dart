// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  String url;
  String forksUrl;
  String commitsUrl;
  String id;
  String nodeId;
  String gitPullUrl;
  String gitPushUrl;
  String htmlUrl;
  Map<String, FileValue> files;
  bool public;
  DateTime createdAt;
  DateTime updatedAt;
  String description;
  int comments;
  dynamic user;
  String commentsUrl;
  Owner owner;
  bool truncated;

  User({
    this.url,
    this.forksUrl,
    this.commitsUrl,
    this.id,
    this.nodeId,
    this.gitPullUrl,
    this.gitPushUrl,
    this.htmlUrl,
    this.files,
    this.public,
    this.createdAt,
    this.updatedAt,
    this.description,
    this.comments,
    this.user,
    this.commentsUrl,
    this.owner,
    this.truncated,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        url: json["url"],
        forksUrl: json["forks_url"],
        commitsUrl: json["commits_url"],
        id: json["id"],
        nodeId: json["node_id"],
        gitPullUrl: json["git_pull_url"],
        gitPushUrl: json["git_push_url"],
        htmlUrl: json["html_url"],
        files: Map.from(json["files"]).map(
            (k, v) => MapEntry<String, FileValue>(k, FileValue.fromJson(v))),
        public: json["public"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        description: json["description"],
        comments: json["comments"],
        user: json["user"],
        commentsUrl: json["comments_url"],
        owner: Owner.fromJson(json["owner"]),
        truncated: json["truncated"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "forks_url": forksUrl,
        "commits_url": commitsUrl,
        "id": id,
        "node_id": nodeId,
        "git_pull_url": gitPullUrl,
        "git_push_url": gitPushUrl,
        "html_url": htmlUrl,
        "files": Map.from(files)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "public": public,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "description": description,
        "comments": comments,
        "user": user,
        "comments_url": commentsUrl,
        "owner": owner.toJson(),
        "truncated": truncated,
      };
}

class FileValue {
  String filename;
  String type;
  String language;
  String rawUrl;
  int size;

  FileValue({
    this.filename,
    this.type,
    this.language,
    this.rawUrl,
    this.size,
  });

  factory FileValue.fromJson(Map<String, dynamic> json) => FileValue(
        filename: json["filename"],
        type: json["type"],
        language: json["language"] == null ? null : json["language"],
        rawUrl: json["raw_url"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "filename": filename,
        "type": type,
        "language": language == null ? null : language,
        "raw_url": rawUrl,
        "size": size,
      };
}

class Owner {
  String login;
  int id;
  String nodeId;
  String avatarUrl;
  String gravatarId;
  String url;
  String htmlUrl;
  String followersUrl;
  String followingUrl;
  String gistsUrl;
  String starredUrl;
  String subscriptionsUrl;
  String organizationsUrl;
  String reposUrl;
  String eventsUrl;
  String receivedEventsUrl;
  Type type;
  bool siteAdmin;

  Owner({
    this.login,
    this.id,
    this.nodeId,
    this.avatarUrl,
    this.gravatarId,
    this.url,
    this.htmlUrl,
    this.followersUrl,
    this.followingUrl,
    this.gistsUrl,
    this.starredUrl,
    this.subscriptionsUrl,
    this.organizationsUrl,
    this.reposUrl,
    this.eventsUrl,
    this.receivedEventsUrl,
    this.type,
    this.siteAdmin,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
        login: json["login"],
        id: json["id"],
        nodeId: json["node_id"],
        avatarUrl: json["avatar_url"],
        gravatarId: json["gravatar_id"],
        url: json["url"],
        htmlUrl: json["html_url"],
        followersUrl: json["followers_url"],
        followingUrl: json["following_url"],
        gistsUrl: json["gists_url"],
        starredUrl: json["starred_url"],
        subscriptionsUrl: json["subscriptions_url"],
        organizationsUrl: json["organizations_url"],
        reposUrl: json["repos_url"],
        eventsUrl: json["events_url"],
        receivedEventsUrl: json["received_events_url"],
        type: typeValues.map[json["type"]],
        siteAdmin: json["site_admin"],
      );

  Map<String, dynamic> toJson() => {
        "login": login,
        "id": id,
        "node_id": nodeId,
        "avatar_url": avatarUrl,
        "gravatar_id": gravatarId,
        "url": url,
        "html_url": htmlUrl,
        "followers_url": followersUrl,
        "following_url": followingUrl,
        "gists_url": gistsUrl,
        "starred_url": starredUrl,
        "subscriptions_url": subscriptionsUrl,
        "organizations_url": organizationsUrl,
        "repos_url": reposUrl,
        "events_url": eventsUrl,
        "received_events_url": receivedEventsUrl,
        "type": typeValues.reverse[type],
        "site_admin": siteAdmin,
      };
}

enum Type { USER }

final typeValues = EnumValues({"User": Type.USER});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
