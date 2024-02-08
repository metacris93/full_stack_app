class UserNotLoggedInException implements Exception {
  @override
  String toString() {
    return 'User not logged in.';
  }
}
