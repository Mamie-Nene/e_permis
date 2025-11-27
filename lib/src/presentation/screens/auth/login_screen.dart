import 'package:e_permis/src/data/remote/auth/auth_api.dart';
import 'package:e_permis/src/utils/api/api_url.dart';
import 'package:flutter/material.dart';

import 'package:e_permis/src/presentation/widgets/inspector_ui_kit.dart';
import 'package:e_permis/src/utils/consts/app_specifications/all_directories.dart';
import 'package:e_permis/src/utils/consts/routes/app_routes_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _matriculeController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isRunning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryDark, AppColors.primary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1080, minHeight: 520),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28)),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final bool isWide = constraints.maxWidth > 720;
                      return Row(
                        children: [
                          if (isWide) Expanded(child: _buildBrandingPanel()),
                          Expanded(
                            flex: isWide ? 1 : 2,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 40),
                              child: _buildFormCard(context),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrandingPanel() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryDark, AppColors.primary],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset(AppImages.LOGO, height: 84),
              //child: Image.asset(AppImages.APP_LOGO, height: 84),
            ),
            const SizedBox(height: 32),
            Text(
              'Portail Inspecteurs',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              'Direction des Transports Routiers · Ministère des Infrastructures.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white70),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                StatusPill(
                  label: 'Authentification sécurisée',
                  icon: Icons.shield_outlined,
                  backgroundColor: Colors.white12,
                  foregroundColor: Colors.white,
                ),
                StatusPill(
                  label: 'Suivi quotidien',
                  icon: Icons.calendar_month_outlined,
                  backgroundColor: Colors.white12,
                  foregroundColor: Colors.white,
                ),
                StatusPill(
                  label: 'Signature numérique',
                  icon: Icons.gesture_outlined,
                  backgroundColor: Colors.white12,
                  foregroundColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Connexion',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          'Identifiez-vous avec votre matricule inspecteur pour accéder aux évaluations du jour.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 32),
        _buildLoginForm(),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {},
            child: Text(
              AppText.FORGET_PWD_TEXT,
              style: const TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: _isRunning? null : () async {
            setState(() {
              _isRunning=true;
            });
            if (_formKey.currentState!.validate()) {
              await AuthApi().loginRequest(context, _matriculeController.text, _passwordController.text, ApiUrl().getLoginUrl);
            }
            setState(() {
              _isRunning=false;
            });
          },
          icon: _isRunning? CircularProgressIndicator():const Icon(Icons.login_rounded),
          label: const Text('Accéder au portail'),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.support_agent_outlined),
          label: const Text('Contacter le support'),
        ),
        const SizedBox(height: 24),
        Text(
          AppText.COPYRIGHT_TEXT,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _matriculeController,
            textInputAction: TextInputAction.next,
            decoration: _buildInputDecoration(
              label: 'Matricule Inspecteur',
              hint: 'Ex : DTR-45897',
              icon: Icons.badge_outlined,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez saisir votre matricule';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: _buildInputDecoration(
              label: 'Mot de passe',
              hint: 'Votre mot de passe',
              icon: Icons.lock_outline,
              suffix: IconButton(
                icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.primary),
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez saisir votre mot de passe';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required String label,
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: AppColors.primary),
      suffixIcon: suffix,
    );
  }

  @override
  void dispose() {
    _matriculeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
