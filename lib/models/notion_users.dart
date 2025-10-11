// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  String object;
  List<Result> results;
  dynamic nextCursor;
  bool hasMore;
  String type;
  User user;
  String requestId;

  Users({
    required this.object,
    required this.results,
    required this.nextCursor,
    required this.hasMore,
    required this.type,
    required this.user,
    required this.requestId,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    object: json["object"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    nextCursor: json["next_cursor"],
    hasMore: json["has_more"],
    type: json["type"],
    user: User.fromJson(json["user"]),
    requestId: json["request_id"],
  );

  Map<String, dynamic> toJson() => {
    "object": object,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "next_cursor": nextCursor,
    "has_more": hasMore,
    "type": type,
    "user": user.toJson(),
    "request_id": requestId,
  };
}

class Result {
  String object;
  String id;
  String name;
  String? avatarUrl;
  String type;
  Person? person;
  Bot? bot;

  Result({
    required this.object,
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.type,
    this.person,
    this.bot,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    object: json["object"],
    id: json["id"],
    name: json["name"],
    avatarUrl: json["avatar_url"],
    type: json["type"],
    person: json["person"] == null ? null : Person.fromJson(json["person"]),
    bot: json["bot"] == null ? null : Bot.fromJson(json["bot"]),
  );

  Map<String, dynamic> toJson() => {
    "object": object,
    "id": id,
    "name": name,
    "avatar_url": avatarUrl,
    "type": type,
    "person": person?.toJson(),
    "bot": bot?.toJson(),
  };
}

class Bot {
  Owner? owner;
  String? workspaceName;
  String? workspaceId;
  WorkspaceLimits? workspaceLimits;

  Bot({this.owner, this.workspaceName, this.workspaceId, this.workspaceLimits});

  factory Bot.fromJson(Map<String, dynamic> json) => Bot(
    owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
    workspaceName: json["workspace_name"],
    workspaceId: json["workspace_id"],
    workspaceLimits: json["workspace_limits"] == null ? null : WorkspaceLimits.fromJson(json["workspace_limits"]),
  );

  Map<String, dynamic> toJson() => {
    "owner": owner?.toJson(),
    "workspace_name": workspaceName,
    "workspace_id": workspaceId,
    "workspace_limits": workspaceLimits?.toJson(),
  };
}

class Owner {
  String type;
  bool workspace;

  Owner({required this.type, required this.workspace});

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(type: json["type"], workspace: json["workspace"]);

  Map<String, dynamic> toJson() => {"type": type, "workspace": workspace};
}

class WorkspaceLimits {
  int maxFileUploadSizeInBytes;

  WorkspaceLimits({required this.maxFileUploadSizeInBytes});

  factory WorkspaceLimits.fromJson(Map<String, dynamic> json) =>
      WorkspaceLimits(maxFileUploadSizeInBytes: json["max_file_upload_size_in_bytes"]);

  Map<String, dynamic> toJson() => {"max_file_upload_size_in_bytes": maxFileUploadSizeInBytes};
}

class Person {
  String email;

  Person({required this.email});

  factory Person.fromJson(Map<String, dynamic> json) => Person(email: json["email"]);

  Map<String, dynamic> toJson() => {"email": email};
}

class User {
  User();

  factory User.fromJson(Map<String, dynamic> json) => User();

  Map<String, dynamic> toJson() => {};
}
