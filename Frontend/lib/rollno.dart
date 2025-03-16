import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  static final Shared _instance = Shared._internal();

  factory Shared() {
    return _instance;
  }

  Shared._internal();

  String rollNo = '';
  String token = '';
  String clubId = '';
  bool isAdmin = false;

  /// Initialize the stored values asynchronously
  Future<void> init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    rollNo = prefs.getString('rollNo') ?? '';
    token = prefs.getString('token') ?? '';
    clubId = prefs.getString('clubId') ?? '';
    isAdmin = prefs.getBool('isAdmin') ?? false;
  }

  /// Save clubId and isAdmin status
  Future<void> saveClubId(String clubId, bool isAdmin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('clubId', clubId);
    await prefs.setBool('isAdmin', isAdmin);

    this.clubId = clubId;
    this.isAdmin = isAdmin;
  }

  /// Save roll number
  Future<void> saveRollNo(String rollNo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('rollNo', rollNo);
    this.rollNo = rollNo;
  }

  /// Save token
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
    this.token = token;
  }

  /// Logout and clear all stored data
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clears all stored keys
    rollNo = '';
    token = '';
    clubId = '';
    isAdmin = false;
  }
}
