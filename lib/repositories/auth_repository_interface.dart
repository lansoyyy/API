abstract class AuthRepositoryInterface {
  Future<void> login(String email, String password);
  Future<void> logout(String email, String password);
  Future<void> register(String email, String password, String name);
}
