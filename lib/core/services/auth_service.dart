import 'package:injectable/injectable.dart';

@lazySingleton
class AuthService {
  // Mock current user
  String get currentUserId => 'user_1';
  bool get isAdmin => true; // For testing, set to true

  Future<bool> canEditDeal(String? authorId) async {
    if (authorId == null) return true; // New deal or no author
    if (isAdmin) return true;
    return authorId == currentUserId;
  }

  Future<bool> canDeleteDeal(String? authorId) async {
    if (authorId == null) return true;
    if (isAdmin) return true;
    return authorId == currentUserId;
  }
}
