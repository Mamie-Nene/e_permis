import 'package:flutter/material.dart';

import 'package:e_permis/src/methods/signout.dart';
import 'package:e_permis/src/presentation/widgets/inspector_ui_kit.dart';
import 'package:e_permis/src/utils/consts/app_specifications/app_colors.dart';
import 'package:e_permis/src/utils/consts/routes/app_routes_name.dart';

class InspectorProfileScreen extends StatelessWidget {
  const InspectorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    _buildProfileHeader(context),
                    const SizedBox(height: 32),
                    _buildAccountInfoSection(context),
                    const SizedBox(height: 24),
                    _buildActionsSection(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryDark, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_outline,
              color: Colors.white,
              size: 64,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Inspecteur Principal',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            'Abdoulaye Wade',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 4),
          Text(
            'Matricule: DTR-45897',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountInfoSection(BuildContext context) {
    return SectionCard(
      title: 'Informations du compte',
      icon: Icons.account_circle_outlined,
      child: Column(
        children: [
          KeyValueRow(
            label: 'Matricule',
            value: 'DTR-45897',
          ),
          KeyValueRow(
            label: 'Grade',
            value: 'Inspecteur Principal',
          ),
          KeyValueRow(
            label: 'Zone d\'affectation',
            value: 'Dakar - Centre',
          ),
          KeyValueRow(
            label: 'Email',
            value: 'a.wade@dtr.sn',
          ),
          KeyValueRow(
            label: 'Téléphone',
            value: '+221 77 123 45 67',
          ),
        ],
      ),
    );
  }

  Widget _buildActionsSection(BuildContext context) {
    return Column(
      children: [
        Card(
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.settings_outlined,
                color: AppColors.primary,
              ),
            ),
            title: const Text('Paramètres'),
            subtitle: const Text('Gérer vos préférences'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to settings
            },
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.accent.withOpacity(.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.help_outline,
                color: AppColors.accent,
              ),
            ),
            title: const Text('Aide & Support'),
            subtitle: const Text('FAQ et assistance'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navigate to help
            },
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.logout,
                color: AppColors.error,
              ),
            ),
            title: const Text(
              'Se déconnecter',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Quitter votre session'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showLogoutDialog(context),
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text('Déconnexion'),
          content: const Text(
            'Êtes-vous sûr de vouloir vous déconnecter ?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                SignOutMethod().signOut(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              child: const Text('Déconnexion'),
            ),
          ],
        );
      },
    );
  }
}
