import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/validators.dart';
import 'email_event.dart';
import 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  EmailBloc() : super(EmailState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<TogglePasswordVisibility>(_onToggleVisibility);
    on<SubmitPressed>(_onSubmit);
  }

  void _onEmailChanged(EmailChanged event, Emitter<EmailState> emit) async {
    final email = event.email;
    final isValid = Validators.isEmailFormatValid(email);
    final domain = email.split('@').length > 1 ? email.split('@').last : '';
    final domainValid = await Validators.isDomainReachable(domain);
    final suggestions = Validators.suggestDomains(email);
    emit(state.copyWith(
      email: email,
      isEmailValid: isValid,
      isDomainValid: domainValid,
      emailSuggestions: suggestions,
    ));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<EmailState> emit) {
    final password = event.password;
    final isValid = Validators.isPasswordValid(password);
    emit(state.copyWith(password: password, isPasswordValid: isValid));
  }

  void _onToggleVisibility(TogglePasswordVisibility event, Emitter<EmailState> emit) {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void _onSubmit(SubmitPressed event, Emitter<EmailState> emit) {
    if (state.email.isEmpty || state.password.isEmpty) {
      emit(state.copyWith(error: 'Заполните все поля'));
    } else if (!state.isEmailValid) {
      emit(state.copyWith(error: 'Неверный формат email'));
    } else if (!state.isDomainValid) {
      emit(state.copyWith(error: 'Домен не существует'));
    } else if (!state.isPasswordValid) {
      emit(state.copyWith(error: 'Пароль не соответствует требованиям'));
    } else {
      emit(state.copyWith(error: null)); // valid
    }
  }
}
