// To parse this JSON data, do
//
//     final pages = pagesFromJson(jsonString);

import 'dart:convert';

Pages pagesFromJson(String str) => Pages.fromJson(json.decode(str));

String pagesToJson(Pages data) => json.encode(data.toJson());

class Pages {
  String object;
  List<Result> results;
  dynamic nextCursor;
  bool hasMore;
  String type;
  PageOrDatabase pageOrDatabase;
  String requestId;

  Pages({
    required this.object,
    required this.results,
    required this.nextCursor,
    required this.hasMore,
    required this.type,
    required this.pageOrDatabase,
    required this.requestId,
  });

  factory Pages.fromJson(Map<String, dynamic> json) => Pages(
    object: json["object"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    nextCursor: json["next_cursor"],
    hasMore: json["has_more"],
    type: json["type"],
    pageOrDatabase: PageOrDatabase.fromJson(json["page_or_database"]),
    requestId: json["request_id"],
  );

  Map<String, dynamic> toJson() => {
    "object": object,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "next_cursor": nextCursor,
    "has_more": hasMore,
    "type": type,
    "page_or_database": pageOrDatabase.toJson(),
    "request_id": requestId,
  };
}

class PageOrDatabase {
  PageOrDatabase();

  factory PageOrDatabase.fromJson(Map<String, dynamic> json) =>
      PageOrDatabase();

  Map<String, dynamic> toJson() => {};
}

class Result {
  String object;
  String id;
  DateTime createdTime;
  DateTime lastEditedTime;
  TedBy createdBy;
  TedBy lastEditedBy;
  dynamic cover;
  dynamic icon;
  Parent parent;
  bool archived;
  bool inTrash;
  bool isLocked;
  Properties properties;
  String url;
  dynamic publicUrl;

  Result({
    required this.object,
    required this.id,
    required this.createdTime,
    required this.lastEditedTime,
    required this.createdBy,
    required this.lastEditedBy,
    required this.cover,
    required this.icon,
    required this.parent,
    required this.archived,
    required this.inTrash,
    required this.isLocked,
    required this.properties,
    required this.url,
    required this.publicUrl,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    object: json["object"],
    id: json["id"],
    createdTime: DateTime.parse(json["created_time"]),
    lastEditedTime: DateTime.parse(json["last_edited_time"]),
    createdBy: TedBy.fromJson(json["created_by"]),
    lastEditedBy: TedBy.fromJson(json["last_edited_by"]),
    cover: json["cover"],
    icon: json["icon"],
    parent: Parent.fromJson(json["parent"]),
    archived: json["archived"],
    inTrash: json["in_trash"],
    isLocked: json["is_locked"],
    properties: Properties.fromJson(json["properties"]),
    url: json["url"],
    publicUrl: json["public_url"],
  );

  Map<String, dynamic> toJson() => {
    "object": object,
    "id": id,
    "created_time": createdTime.toIso8601String(),
    "last_edited_time": lastEditedTime.toIso8601String(),
    "created_by": createdBy.toJson(),
    "last_edited_by": lastEditedBy.toJson(),
    "cover": cover,
    "icon": icon,
    "parent": parent.toJson(),
    "archived": archived,
    "in_trash": inTrash,
    "is_locked": isLocked,
    "properties": properties.toJson(),
    "url": url,
    "public_url": publicUrl,
  };
}

class TedBy {
  Object object;
  String id;

  TedBy({required this.object, required this.id});

  factory TedBy.fromJson(Map<String, dynamic> json) =>
      TedBy(object: objectValues.map[json["object"]]!, id: json["id"]);

  Map<String, dynamic> toJson() => {
    "object": objectValues.reverse[object],
    "id": id,
  };
}

enum Object { USER }

final objectValues = EnumValues({"user": Object.USER});

class Parent {
  String type;
  String? databaseId;
  bool? workspace;

  Parent({required this.type, this.databaseId, this.workspace});

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
    type: json["type"],
    databaseId: json["database_id"],
    workspace: json["workspace"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "database_id": databaseId,
    "workspace": workspace,
  };
}

class Properties {
  ResidentInCharge? residentInCharge;
  Status? status;
  Name? name;
  Name? title;

  Properties({this.residentInCharge, this.status, this.name, this.title});

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    residentInCharge: json["Resident in Charge"] == null
        ? null
        : ResidentInCharge.fromJson(json["Resident in Charge"]),
    status: json["Status"] == null ? null : Status.fromJson(json["Status"]),
    name: json["Name"] == null ? null : Name.fromJson(json["Name"]),
    title: json["title"] == null ? null : Name.fromJson(json["title"]),
  );

  Map<String, dynamic> toJson() => {
    "Resident in Charge": residentInCharge?.toJson(),
    "Status": status?.toJson(),
    "Name": name?.toJson(),
    "title": title?.toJson(),
  };
}

class Name {
  String id;
  String type;
  List<Title> title;

  Name({required this.id, required this.type, required this.title});

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    id: json["id"],
    type: json["type"],
    title: List<Title>.from(json["title"].map((x) => Title.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "title": List<dynamic>.from(title.map((x) => x.toJson())),
  };
}

class Title {
  String type;
  Text text;
  Annotations annotations;
  String plainText;
  dynamic href;

  Title({
    required this.type,
    required this.text,
    required this.annotations,
    required this.plainText,
    required this.href,
  });

  factory Title.fromJson(Map<String, dynamic> json) => Title(
    type: json["type"],
    text: Text.fromJson(json["text"]),
    annotations: Annotations.fromJson(json["annotations"]),
    plainText: json["plain_text"],
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "text": text.toJson(),
    "annotations": annotations.toJson(),
    "plain_text": plainText,
    "href": href,
  };
}

class Annotations {
  bool bold;
  bool italic;
  bool strikethrough;
  bool underline;
  bool code;
  String color;

  Annotations({
    required this.bold,
    required this.italic,
    required this.strikethrough,
    required this.underline,
    required this.code,
    required this.color,
  });

  factory Annotations.fromJson(Map<String, dynamic> json) => Annotations(
    bold: json["bold"],
    italic: json["italic"],
    strikethrough: json["strikethrough"],
    underline: json["underline"],
    code: json["code"],
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "bold": bold,
    "italic": italic,
    "strikethrough": strikethrough,
    "underline": underline,
    "code": code,
    "color": color,
  };
}

class Text {
  String content;
  dynamic link;

  Text({required this.content, required this.link});

  factory Text.fromJson(Map<String, dynamic> json) =>
      Text(content: json["content"], link: json["link"]);

  Map<String, dynamic> toJson() => {"content": content, "link": link};
}

class ResidentInCharge {
  String id;
  String type;
  List<PersonElement> people;

  ResidentInCharge({
    required this.id,
    required this.type,
    required this.people,
  });

  factory ResidentInCharge.fromJson(Map<String, dynamic> json) =>
      ResidentInCharge(
        id: json["id"],
        type: json["type"],
        people: List<PersonElement>.from(
          json["people"].map((x) => PersonElement.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "people": List<dynamic>.from(people.map((x) => x.toJson())),
  };
}

class PersonElement {
  Object object;
  String id;
  String name;
  String? avatarUrl;
  String type;
  PersonPerson person;

  PersonElement({
    required this.object,
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.type,
    required this.person,
  });

  factory PersonElement.fromJson(Map<String, dynamic> json) => PersonElement(
    object: objectValues.map[json["object"]]!,
    id: json["id"],
    name: json["name"],
    avatarUrl: json["avatar_url"],
    type: json["type"],
    person: PersonPerson.fromJson(json["person"]),
  );

  Map<String, dynamic> toJson() => {
    "object": objectValues.reverse[object],
    "id": id,
    "name": name,
    "avatar_url": avatarUrl,
    "type": type,
    "person": person.toJson(),
  };
}

class PersonPerson {
  String email;

  PersonPerson({required this.email});

  factory PersonPerson.fromJson(Map<String, dynamic> json) =>
      PersonPerson(email: json["email"]);

  Map<String, dynamic> toJson() => {"email": email};
}

class Status {
  String id;
  String type;
  Select? select;

  Status({required this.id, required this.type, required this.select});

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    id: json["id"],
    type: json["type"],
    select: json["select"] == null ? null : Select.fromJson(json["select"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "select": select?.toJson(),
  };
}

class Select {
  String id;
  String name;
  String color;

  Select({required this.id, required this.name, required this.color});

  factory Select.fromJson(Map<String, dynamic> json) =>
      Select(id: json["id"], name: json["name"], color: json["color"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "color": color};
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
