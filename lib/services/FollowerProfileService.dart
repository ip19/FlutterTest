import 'package:codable/codable.dart';
import 'package:flutter_listview_json/Network.dart';

abstract class FollowerProfileService {
  Future<List<FollowerProfile>> getFollowerProfiles();
}

class FollowerProfileServiceImpl extends FollowerProfileService {
  Future<List<FollowerProfile>> getFollowerProfiles() async {
    return Network.request(
            endpoint: "users/igorsegallafa/followers",
            methodType: MethodType.GET,
            entityType: FollowerProfileResponse())
        .then((value) => value.data);
  }
}

class FollowerProfileResponse extends Coding {
  List<FollowerProfile> data;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);
    this.data = object.decodeObjects("data", () => FollowerProfile());
  }

  @override
  void encode(KeyedArchive object) {
    object.encodeObjects("data", this.data);
  }
}

class FollowerProfile extends Coding {
  String avatar_url;
  String login;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);
    avatar_url = object.decode("avatar_url");
    login = object.decode("login");
  }

  @override
  void encode(KeyedArchive object) {
    object.encode("avatar_url", avatar_url);
    object.encode("login", login);
  }
}
