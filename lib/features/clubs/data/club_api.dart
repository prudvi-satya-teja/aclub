import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/clubs_model.dart';

class ClubAPI {
  final String baseUrl;

  ClubAPI({required this.baseUrl});

  Future<List<Club>> fetchClubs() async {
    final response = await http.get(Uri.parse('$baseUrl/clubs'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((club) => Club.fromJson(club)).toList();
    } else {
      throw Exception('Failed to fetch clubs');
    }
  }

  Future<Club> fetchClubDetails(String clubId) async {
    final response = await http.get(Uri.parse('$baseUrl/clubs/$clubId'));

    if (response.statusCode == 200) {
      return Club.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch club details');
    }
  }

  Future<void> addClub(Club club) async {
    final response = await http.post(
      Uri.parse('$baseUrl/clubs'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(club.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add club');
    }
  }

  Future<void> updateClub(Club club) async {
    final response = await http.put(
      Uri.parse('$baseUrl/clubs/${club.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(club.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update club');
    }
  }

  Future<void> deleteClub(String clubId) async {
    final response = await http.delete(Uri.parse('$baseUrl/clubs/$clubId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete club');
    }
  }
}
