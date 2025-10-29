import '../models/UserModel.dart';

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class AuthService {
  // Simulate a local user store
  final Map<String, UserModel> _users = {
    'test@test.com': UserModel(
      uid: '1',
      email: 'test@test.com',
      name: 'Test User',
      phoneNumber: '1234567890',
    ),
  };

  // Current user
  UserModel? _currentUser;

  // Get current user
  UserModel? get currentUser => _currentUser;

  // Sign in with email and password
  Future<UserModel?> signInWithEmailAndPassword(
    String email, 
    String password,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    try {
      // For testing purposes, accept any password for test@test.com
      if (_users.containsKey(email) && password == 'password') {
        _currentUser = _users[email];
        return _currentUser;
      }
      throw AuthException('Invalid credentials');
    } catch (e) {
      throw AuthException(e.toString());
    }
  }

  // Sign out
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }

  // Password reset
  Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1));
    
    if (!_users.containsKey(email)) {
      throw AuthException('No user found with this email');
    }
    // Simulate password reset email
    print('Password reset email sent to $email');
  }

  // Check if email is already in use
  Future<bool> isEmailInUse(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _users.containsKey(email);
  }
}