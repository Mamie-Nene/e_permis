import 'package:flutter/material.dart';

import 'package:e_permis/src/domain/remote/Candidate.dart';
import 'package:e_permis/src/presentation/widgets/inspector_ui_kit.dart';
import 'package:e_permis/src/utils/consts/app_specifications/app_colors.dart';
import 'package:e_permis/src/utils/consts/routes/app_routes_name.dart';

class CandidateDetailsScreen extends StatelessWidget {
  const CandidateDetailsScreen({super.key, required this.candidate});

  final Candidate candidate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Fiche Candidat'),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.onBackground,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildIdentityCard(context),
              const SizedBox(height: 16),
              SectionCard(
                title: 'Dossier administratif',
                subtitle:
                    'Vérifiez les informations avant de lancer l’épreuve pratique.',
                icon: Icons.folder_copy_outlined,
                child: Column(
                  children: [
                    KeyValueRow(
                        label: 'Type de permis', value: candidate.typePermis),
                    KeyValueRow(
                        label: 'Numéro de dossier',
                        value: candidate.numeroDossier),
                    KeyValueRow(
                        label: 'Auto-école', value: candidate.autoEcole),
                    KeyValueRow(
                      label: 'Statut',
                      value: candidate.estEvalue ? 'Évalué' : 'En attente',
                      trailing: Icon(
                        candidate.estEvalue
                            ? Icons.verified_outlined
                            : Icons.schedule_outlined,
                        color: candidate.estEvalue
                            ? AppColors.primary
                            : AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ),
              SectionCard(
                title: 'Préparation',
                subtitle: 'Notes officielles laissées par le centre.',
                icon: Icons.fact_check_outlined,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Documents vérifiés : • Pièce d’identité • Certificat médical • Fiche auto-école.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Commentaires additionnels',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      candidate.estEvalue
                          ? 'Candidat vu la semaine dernière. Dernier résultat conforme.'
                          : 'Prévoir un rappel des instructions de sécurité avant départ.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              SectionCard(
                title: 'Parcours officiel',
                icon: Icons.route_outlined,
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: const [
                    StatusPill(
                      label: 'Point de rassemblement : 08h00',
                      icon: Icons.access_time,
                      backgroundColor: AppColors.backgroundMuted,
                    ),
                    StatusPill(
                      label: 'Itinéraire : Voie de dégagement nord',
                      icon: Icons.alt_route,
                      backgroundColor: AppColors.backgroundMuted,
                    ),
                    StatusPill(
                      label: 'Distance : 7,5 km',
                      icon: Icons.straighten,
                      backgroundColor: AppColors.backgroundMuted,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.calendar_today_outlined),
                      label: const Text('Replanifier'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: candidate.estEvalue
                          ? null
                          : () => Navigator.of(context)
                              .pushNamed(AppRoutesName.evaluationForm),
                      icon: const Icon(Icons.drive_eta_rounded),
                      label: const Text('Démarrer l’évaluation'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIdentityCard(BuildContext context) {
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
          CircleAvatar(
            radius: 44,
            backgroundColor: Colors.white.withOpacity(.1),
            child: Icon(
              _getLicenseIcon(candidate.typePermis),
              color: Colors.white,
              size: 36,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            candidate.nom,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            candidate.autoEcole,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          StatusPill(
            label: candidate.estEvalue ? 'Déjà évalué' : 'En attente',
            icon: candidate.estEvalue
                ? Icons.verified_user_outlined
                : Icons.timelapse,
            backgroundColor: Colors.white,
            foregroundColor:
                candidate.estEvalue ? AppColors.primary : AppColors.accent,
          ),
        ],
      ),
    );
  }

  IconData _getLicenseIcon(String licenseType) {
    switch (licenseType) {
      case 'Permis A':
        return Icons.two_wheeler_outlined;
      case 'Permis B':
        return Icons.directions_car_filled_outlined;
      case 'Permis C':
        return Icons.local_shipping_outlined;
      case 'Permis D':
        return Icons.directions_bus_outlined;
      default:
        return Icons.help_outline;
    }
  }
}
