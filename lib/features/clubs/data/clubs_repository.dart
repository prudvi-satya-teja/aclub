import '../model/clubs_model.dart';
import '../api/club_api.dart';

class ClubRepository {
  final ClubAPI clubAPI;

  ClubRepository({required this.clubAPI});

  Future<List<Club>> fetchClubs() async {
    return await clubAPI.fetchClubs();
  }

  Future<Club> fetchClubDetails(String clubId) async {
    return await clubAPI.fetchClubDetails(clubId);
  }

  Future<void> addClub(Club club) async {
    await clubAPI.addClub(club);
  }

  Future<void> updateClub(Club club) async {
    await clubAPI.updateClub(club);
  }

  Future<void> deleteClub(String clubId) async {
    await clubAPI.deleteClub(clubId);
  }
}
