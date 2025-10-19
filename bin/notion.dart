import 'dart:convert';
import 'dart:io';

import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:notion/base_client.dart';
import 'package:notion/models/notion_users.dart';
import 'package:notion/models/notion_pages.dart';

const String latestApiVer = '2025-09-03';

String red(String text) => '\x1B[31m$text\x1B[0m';
String green(String text) => '\x1B[32m$text\x1B[0m';
String yellow(String text) => '\x1B[33m$text\x1B[0m';
String blue(String text) => '\x1B[34m$text\x1B[0m';

void printJson(dynamic data) {
  final object = data is String ? jsonDecode(data) : data;
  const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  print(encoder.convert(object));
}

Future<Map<String, String>?> getUsers(NotionClient client) async {
  try {
    final String? users = await client.get('/users');
    if (users == null) {
      return null;
    }
    final Users usersObject = usersFromJson(users);
    var user = usersObject.results.firstWhere((r) => r.name.toLowerCase() == 'izzuddin ahmad afif');
    print('Fetched user: ${blue(user.name)} with id: ${yellow(user.id)}');
    var user2 = usersObject.results.firstWhere((r) => r.name.toLowerCase().startsWith('devy'));
    print('Fetched user: ${green(user2.name)} with id: ${red(user2.id)}');

    final usersMap = <String, String>{};
    for (final u in usersObject.results) {
      if (u.type == 'bot') continue;
      usersMap[u.id] = u.name;
    }
    return usersMap;
  } catch (err) {
    print('Error fetching users: $err');
    return null;
  }
}

Future<Map<String, Map<String, dynamic>>?> getPatientPages(NotionClient client) async {
  Map<String, dynamic> payload = {
    'filter': {'value': "page", 'property': 'object'},
  };
  try {
    final String? pages = await client.post('/search', payload: payload);
    if (pages == null) {
      return null;
    }
    // printJson(pages);
    final pagesObject = pagesFromJson(pages);
    Map<String, Map<String, dynamic>> patientPagesMap = {};

    for (final p in pagesObject.results) {
      if (p.properties.name == null ||
          p.parent.type == 'workspace' ||
          p.properties.residentInCharge?.people.length == 0)
        continue;
      final patientName = p.properties.name!.title.first.plainText;
      patientPagesMap[p.id] = {
        'name': patientName,
        'url': p.url,
        'resident_in_charge': p.properties.residentInCharge?.people.first.name ?? '',
      };
    }
    return patientPagesMap;
  } catch (err) {
    print('Error fetching pages: $err');
    return null;
  }
}

String getEnvPath() {
  final scriptDir = File(Platform.script.toFilePath()).parent.path;
  return '$scriptDir\\.env';
}

Future<void> main(List<String> arguments) async {
  final DotEnv env = DotEnv()..load([getEnvPath()]);
  final String? token = env['NOTION_TOKEN'];
  if (token == null || token.isEmpty) {
    throw Exception('NOTION_TOKEN missing from .env');
  }

  final http.Client rawClient = http.Client();
  final NotionClient client = NotionClient(rawClient, token);

  try {
    Map<String, String>? users = await getUsers(client);
    if (users == null) print('No users found');
    printJson(users);
    // TODO: implement getPages with proper schema
    Map<String, Map<String, dynamic>>? patientPagesMap = await getPatientPages(client);
    if (patientPagesMap == null) print('No pages found');
    printJson(patientPagesMap);
  } finally {
    rawClient.close();
    await stdout.flush();
  }
}
