import '../models/UserModel.dart';

class AuthException implements Exception {
  final String message;
  AuthException(this.message);
}

class AuthService {
  // Debug flag
  static const bool _debug = true;

  // Simulate a local user store
  final Map<String, UserModel> _users = {
    'test@test.com': UserModel(
      uid: '1',
      email: 'test@test.com',
      name: 'Test User',
      phoneNumber: '1234567890',
    ),
  };

  // Add a map to store user passwords
  final Map<String, String> _userPasswords = {
    'test@test.com': 'password',
  };

  // Current user
  UserModel? _currentUser;

  // Get current user
  UserModel? get currentUser => _currentUser;

  void _debugPrint(String message) {
    if (_debug) {
      print('AuthService: $message');
    }
  }

  // Sign in with email and password
  Future<UserModel?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    try {
      _debugPrint('Attempting login for email: $email');
      _debugPrint('Registered users: ${_users.keys.toList()}');
      
      if (_users.containsKey(email)) {
        if (_userPasswords[email] == password) {
          _currentUser = _users[email];
          _debugPrint('Login successful for: $email');
          return _currentUser;
        }
        _debugPrint('Invalid password for: $email');
      } else {
        _debugPrint('No user found with email: $email');
      }
      
      throw AuthException('Invalid credentials');
    } catch (e) {
      _debugPrint('Login error: $e');
      throw AuthException('Invalid credentials');
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

  // Register with email and password
  Future<UserModel?> registerWithEmailAndPassword(
    String email,
    String password,
    String name,
    String phoneNumber,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      _debugPrint('Attempting registration for email: $email');

      if (_users.containsKey(email)) {
        _debugPrint('Email already in use: $email');
        throw AuthException('Email already in use');
      }

      final UserModel newUser = UserModel(
        uid: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        name: name,
        phoneNumber: phoneNumber,
      );

      // Store user and password
      _users[email] = newUser;
      _userPasswords[email] = password;

      _debugPrint('Registration successful for: $email');
      _debugPrint('Current users: ${_users.keys.toList()}');

      return newUser;
    } catch (e) {
      _debugPrint('Registration error: $e');
      throw AuthException(e.toString());
    }
  }
}