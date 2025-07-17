import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:email_app/blocs/email_bloc.dart';
import 'package:email_app/blocs/email_event.dart';
import 'package:email_app/blocs/email_state.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Проверка Email"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 2,
      ),
      body: BlocBuilder<EmailBloc, EmailState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Введите ваш email и пароль",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                
                TextField(
                  onChanged: (value) =>
                      context.read<EmailBloc>().add(EmailChanged(value)),
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorText: state.email.isEmpty
                        ? null
                        : !state.isEmailValid
                            ? "Неверный формат email"
                            : null,
                    suffixIcon: state.isDomainValid
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const Icon(Icons.warning, color: Colors.orange),
                  ),
                ),
                const SizedBox(height: 8),

                
                if (state.emailSuggestions.isNotEmpty)
                  ...state.emailSuggestions.map(
                    (s) => ListTile(
                      title: Text(s),
                      tileColor: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      onTap: () {
                        context.read<EmailBloc>().add(EmailChanged(s));
                      },
                    ),
                  ),
                const SizedBox(height: 24),

               
                TextField(
                  obscureText: !state.isPasswordVisible,
                  onChanged: (value) =>
                      context.read<EmailBloc>().add(PasswordChanged(value)),
                  decoration: InputDecoration(
                    labelText: "Пароль",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorText: state.password.isEmpty
                        ? null
                        : !state.isPasswordValid
                            ? "Пароль должен содержать спецсимвол, цифру, заглавную букву и быть от 8 до 20 символов"
                            : null,
                    suffixIcon: IconButton(
                      icon: Icon(
                        state.isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () => context
                          .read<EmailBloc>()
                          .add(TogglePasswordVisibility()),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

              
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () =>
                      context.read<EmailBloc>().add(SubmitPressed()),
                  child: const Text(
                    "Проверить",
                    style: TextStyle(fontSize: 16,
                    color: Colors.white),
                  ),
                ),
                const SizedBox(height: 16),

                
                if (state.error != null)
                  Center(
                    child: Text(
                      state.error!,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
