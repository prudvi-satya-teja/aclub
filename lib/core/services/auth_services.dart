class AuthService {
  final ApiService apiService;

  AuthService(this.apiService);

  Future<bool> login(String email, String password) async {
    final data = {'email': email, 'password': password};
    final response = await apiService.post('/auth/login', data);
    return response['success'];
  }

  Future<bool> signup(Map<String, dynamic> userData) async {
    final response = await apiService.post('/auth/signup', userData);
    return response['success'];
  }

  Future<bool> logout() async {
    final response = await apiService.post('/auth/logout', {});
    return response['success'];
  }
}