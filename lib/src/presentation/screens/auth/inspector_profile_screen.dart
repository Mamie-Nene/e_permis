import 'package:e_permis/src/utils/consts/routes/app_routes_name.dart';
import 'package:flutter/material.dart';

import '/src/data/remote/inspecteur/inspecteur_api.dart';
import '/src/domain/remote/Inspecteur.dart';
import '/src/utils/api/api_url.dart';

import '/src/methods/signout.dart';
import '/src/presentation/widgets/inspector_ui_kit.dart';
import '/src/utils/consts/app_specifications/app_colors.dart';

class InspectorProfileScreen extends StatefulWidget {
  const InspectorProfileScreen({super.key});

  @override
  State<InspectorProfileScreen> createState() => _InspectorProfileScreenState();
}

class _InspectorProfileScreenState extends State<InspectorProfileScreen> {

 Inspecteur? inspecteurInfo;

 bool _infoLoader= true;

  getInfoUser() async {
    await InspecteurApi().getInspecteurDetails( ApiUrl().getDetailsInspecteurUrl).then((value) {
      setState(() {
        inspecteurInfo = value;
        _infoLoader=false;
      });
    }).catchError((error) {
      setState(() {
        _infoLoader=false;
      });
    });
  }

  @override
  void initState() {
    getInfoUser();
    super.initState();
  }
  //BOUTON RETROUR PAGE D'ACCUEIL
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _infoLoader?
            const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            )
            :
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  spacing: 16,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: _buildProfileHeader(context),
                    ),
                    const SizedBox(height: 8),
                    _buildAccountInfoSection(context),
                    const SizedBox(height: 7),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BackButton(color: Colors.white,onPressed:()=>Navigator.of(context).popAndPushNamed(AppRoutesName.inspectorHome) ,),
          Center(
            child: Column(
              spacing: 4,
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
                const SizedBox(height: 12),
                Text(inspecteurInfo!.grade,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 2),
                Text(
                  '${inspecteurInfo!.prenom} ${inspecteurInfo!.nom}',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: Colors.white70),
                ),

                Text(
                  'Matricule: ${inspecteurInfo!.matricule}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white70),
                ),
              ],
            ),
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
            value: inspecteurInfo!.matricule,
          ),
          KeyValueRow(
            label: 'Grade',
            value: inspecteurInfo!.grade,
          ),
          KeyValueRow(
            label: 'Zone d\'affectation',
            value: inspecteurInfo!.zoneAffectation,
          ),
          KeyValueRow(
            label: 'Email',
            value: inspecteurInfo!.email,
          ),
          KeyValueRow(
            label: 'Téléphone',
            value: inspecteurInfo!.telephone,
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
