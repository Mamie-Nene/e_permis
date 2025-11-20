import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:e_permis/src/presentation/widgets/inspector_ui_kit.dart';
import 'package:e_permis/src/utils/consts/app_specifications/app_colors.dart';
import 'package:e_permis/src/utils/consts/routes/app_routes_name.dart';
import 'package:signature/signature.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({super.key});

  @override
  State<SignatureScreen> createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: AppColors.onSurface,
    exportBackgroundColor: AppColors.surface,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Signature de l’inspecteur'),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.onBackground,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const ProcessTimeline(
                steps: ['Fiche', 'Évaluation', 'Résultat', 'Signature'],
                currentIndex: 3,
              ),
              const SizedBox(height: 16),
              SectionCard(
                title: 'Validation officielle',
                subtitle:
                    'Apposer votre signature numérique pour clôturer le dossier.',
                icon: Icons.edit_document,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1. Vérifiez à nouveau le dossier\n2. Signez dans l’encart ci-dessous\n3. Confirmez pour générer l’attestation.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 220,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.outlineSoft),
                      ),
                      child: Signature(
                        controller: _controller,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: const [
                  StatusPill(
                    label: 'Signature horodatée',
                    icon: Icons.schedule_outlined,
                    backgroundColor: AppColors.backgroundMuted,
                  ),
                  SizedBox(width: 12),
                  StatusPill(
                    label: 'Archivage automatique',
                    icon: Icons.cloud_done_outlined,
                    backgroundColor: AppColors.backgroundMuted,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: _buildActionButtons(),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            icon: const Icon(Icons.refresh),
            onPressed: () => _controller.clear(),
            label: const Text('Effacer'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.check),
            label: const Text('Signer et valider'),
            onPressed: () async {
              if (_controller.isNotEmpty) {
                final Uint8List? signature = await _controller.toPngBytes();
                if (signature != null) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutesName.confirmation,
                    (Route<dynamic> route) => false,
                  );
                }
              }
            },
          ),
        ),
      ],
    );
  }
}
