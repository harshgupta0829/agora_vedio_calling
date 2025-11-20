
import 'package:flutter/material.dart';
import 'package:talknearn/screens/auth/widgets/personal_register_form.dart';
import 'package:talknearn/screens/auth/widgets/professional_register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Personal'),
              Tab(text: 'Professional'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PersonalRegisterForm(),
            ProfessionalRegisterForm(),
          ],
        ),
      ),
    );
  }
}
