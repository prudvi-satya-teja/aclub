import '../data/club_model.dart';
import '../data/club_repository.dart';

class ClubsController {
  final ClubRepository clubRepository;

  ClubsController({required this.clubRepository});

  Future<List<Club>> fetchClubs() async {
    try {
      return await clubRepository.fetchClubs();
    } catch (e) {
      throw Exception('Failed to fetch clubs: $e');
    }
  }

  Future<Club> fetchClubDetails(String clubId) async {
    try {
      return await clubRepository.fetchClubDetails(clubId);
    } catch (e) {
      throw Exception('Failed to fetch club details: $e');
    }
  }

  Future<void> addClub(Club club) async {
    try {
      await clubRepository.addClub(club);
    } catch (e) {
      throw Exception('Failed to add club: $e');
    }
  }

  Future<void> updateClub(Club club) async {
    try {
      await clubRepository.updateClub(club);
    } catch (e) {
      throw Exception('Failed to update club: $e');
    }
  }

  Future<void> deleteClub(String clubId) async {
    try {
      await clubRepository.deleteClub(clubId);
    } catch (e) {
      throw Exception('Failed to delete club: $e');
    }
  }
}
