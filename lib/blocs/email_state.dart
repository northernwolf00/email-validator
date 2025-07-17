class EmailState {
  final String email;
  final String password;
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isDomainValid;
  final bool isPasswordVisible;
  final List<String> emailSuggestions;
  final String? error;

  EmailState({
    this.email = '',
    this.password = '',
    this.isEmailValid = false,
    this.isPasswordValid = false,
    this.isDomainValid = false,
    this.isPasswordVisible = false,
    this.emailSuggestions = const [],
    this.error,
  });

  EmailState copyWith({
    String? email,
    String? password,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isDomainValid,
    bool? isPasswordVisible,
    List<String>? emailSuggestions,
    String? error,
  }) {
    return EmailState(
      email: email ?? this.email,
      password: password ?? this.password,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isDomainValid: isDomainValid ?? this.isDomainValid,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      emailSuggestions: emailSuggestions ?? this.emailSuggestions,
      error: error,
    );
  }
}
