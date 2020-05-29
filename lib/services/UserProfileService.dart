import 'package:codable/codable.dart';
import 'package:flutter_listview_json/Network.dart';

abstract class UserProfileService {
  Future<List<UserProfile>> getUserProfiles();
}

class UserProfileServiceImpl extends UserProfileService {
  Future<List<UserProfile>> getUserProfiles() async {
    return Network.request(
            endpoint: "gists/public",
            methodType: MethodType.GET,
            entityType: UserProfileResponse())
        .then((value) => value.data);
  }
}

class UserProfileResponse extends Coding {
  List<UserProfile> data;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);
    this.data = object.decodeObjects("data", () => UserProfile());
  }

  @override
  void encode(KeyedArchive object) {
    object.encodeObjects("data", this.data);
  }
}

class UserProfile extends Coding {
  Owner owner;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);
    this.owner = object.decodeObject("owner", () => Owner());
  }

  @override
  void encode(KeyedArchive object) {
    object.encode("owner", owner);
  }
}

class Owner extends Coding {
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
