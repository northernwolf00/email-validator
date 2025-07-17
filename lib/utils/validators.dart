import 'dart:io';

class Validators {

  static bool isEmailFormatValid(String email) {
    email = email.trim();
    final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.[a-zA-Z]{2,}$');
    return regex.hasMatch(email);
  }


  static Future<bool> isDomainReachable(String email) async {
    try {
      final parts = email.trim().split('@');
      if (parts.length != 2) return false;
      final domain = parts[1];
      if (!domain.contains('.')) return false;

      final result = await InternetAddress.lookup(domain);
      return result.isNotEmpty;
    } catch (_) {
      return false;
    }
  }


  static bool isPasswordValid(String password) {
    password = password.trim();
    if (password.length < 8 || password.length > 20) return false;
    if (!RegExp(r'[A-Z]').hasMatch(password)) return false;
    if (!RegExp(r'[0-9]').hasMatch(password)) return false;
    if (!RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(password)) return false;
    return true;
  }


  static List<String> suggestDomains(String email) {
    final commonDomains = [
      'gmail.com',
      'yahoo.com',
      'hotmail.com',
      'mail.ru',
      'yandex.ru',
      'gmail.co.uk',
      'outlook.com'
    ];

    final parts = email.trim().split('@');
    if (parts.length != 2) return [];

    final username = parts[0];
    final partialDomain = parts[1];

    return commonDomains
        .where((d) => d.startsWith(partialDomain))
        .map((d) => '$username@$d')
        .toList();
  }
}
