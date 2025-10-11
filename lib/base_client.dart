import 'dart:convert';

import 'package:http/http.dart' as http;

const String _baseUrl = 'https://api.notion.com/v1';
const String olderApiVer = '2022-06-28';

class NotionClient {
  NotionClient(this.client, this.token) {
    if (token.isEmpty) {
      throw Exception('Missing Notion API Key!');
    }
  }
  final http.Client client;
  final String token;

  Future<String?> get(String endpoint, {String version = olderApiVer}) async {
    final Uri url = Uri.parse(_baseUrl + endpoint);
    final Map<String, String> _headers = <String, String>{'Authorization': 'Bearer $token', 'Notion-Version': version};
    try {
      final http.Response response = await client.get(url, headers: _headers);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        print('HTTP Error: ${response.statusCode}');
        return null;
      }
    } catch (err) {
      print('failed to send get request: $err');
    }
    return null;
  }

  Future<String?> post(String endpoint, {required Map<String, dynamic> payload, String version = olderApiVer}) async {
    final Uri url = Uri.parse(_baseUrl + endpoint);
    final _headers = {'Authorization': 'Bearer $token', 'Notion-Version': version, 'Content-Type': 'application/json'};
    String string_payload = jsonEncode(payload);
    final response = await client.post(url, headers: _headers, body: string_payload);
    if (response.statusCode == 200)
      return response.body;
    else {
      print('HTTP Error: ${response.statusCode}');
      return null;
    }
  }

  Future<dynamic> patch(String endpoint) async {}
  Future<dynamic> delete(String endpoint) async {}
}
