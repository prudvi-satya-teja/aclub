class RoleService {
  final ApiService apiService;

  RoleService(this.apiService);

  Future<List<String>> getUserRoles(String userId) async {
    final response = await apiService.get('/users/$userId/roles');
    return List<String>.from(response['roles']);
  }
}
