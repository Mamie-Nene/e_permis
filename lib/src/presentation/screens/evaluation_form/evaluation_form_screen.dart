import 'package:flutter/material.dart';

import 'package:e_permis/src/presentation/screens/evaluation_result/evaluation_result_screen.dart';
import 'package:e_permis/src/presentation/widgets/inspector_ui_kit.dart';
import 'package:e_permis/src/utils/consts/app_specifications/app_colors.dart';
import 'package:e_permis/src/utils/consts/routes/app_routes_name.dart';

class EvaluationFormScreen extends StatefulWidget {
  const EvaluationFormScreen({super.key});

  @override
  State<EvaluationFormScreen> createState() => _EvaluationFormScreenState();
}

class _EvaluationFormScreenState extends State<EvaluationFormScreen> {
  // A. Contrôle du véhicule
  bool _niveauxOk = false;
  bool _pneusOk = false;
  bool _eclairageOk = false;

  // B. Installation
  bool _reglageSiegeOk = false;
  bool _retroviseursOk = false;
  bool _ceintureOk = false;

  // C. Maniement
  bool _demarrageOk = false;
  bool _maitriseVolantOk = false;
  bool _marcheArriereOk = false;
  bool _stationnementOk = false;
  bool _respectLimitesOk = false;

  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Évaluation pratique'),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.onBackground,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ProcessTimeline(
                steps: ['Fiche', 'Évaluation', 'Résultat', 'Signature'],
                currentIndex: 1,
              ),
              const SizedBox(height: 24),
              _buildSection(
                title: 'A. Contrôle du véhicule',
                icon: Icons.car_repair,
                children: [
                  _buildCheckItem('Niveaux (huile, eau, liquide frein)',
                      _niveauxOk, (val) => setState(() => _niveauxOk = val!)),
                  _buildCheckItem('Pneus', _pneusOk,
                      (val) => setState(() => _pneusOk = val!)),
                  _buildCheckItem('Éclairage / Clignotants', _eclairageOk,
                      (val) => setState(() => _eclairageOk = val!)),
                ],
              ),
              _buildSection(
                title: 'B. Installation au poste de conduite',
                icon: Icons.event_seat,
                children: [
                  _buildCheckItem('Réglage siège', _reglageSiegeOk,
                      (val) => setState(() => _reglageSiegeOk = val!)),
                  _buildCheckItem('Rétroviseurs', _retroviseursOk,
                      (val) => setState(() => _retroviseursOk = val!)),
                  _buildCheckItem('Ceinture', _ceintureOk,
                      (val) => setState(() => _ceintureOk = val!)),
                ],
              ),
              _buildSection(
                title: 'C. Maniement du véhicule',
                icon: Icons.settings_ethernet,
                children: [
                  _buildCheckItem('Démarrage', _demarrageOk,
                      (val) => setState(() => _demarrageOk = val!)),
                  _buildCheckItem('Maîtrise du volant', _maitriseVolantOk,
                      (val) => setState(() => _maitriseVolantOk = val!)),
                  _buildCheckItem('Marche arrière', _marcheArriereOk,
                      (val) => setState(() => _marcheArriereOk = val!)),
                  _buildCheckItem('Stationnement', _stationnementOk,
                      (val) => setState(() => _stationnementOk = val!)),
                  _buildCheckItem(
                      'Respect des limites / cônes',
                      _respectLimitesOk,
                      (val) => setState(() => _respectLimitesOk = val!)),
                ],
              ),
              _buildCommentsSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: ElevatedButton.icon(
          onPressed: _submitForm,
          icon: const Icon(Icons.assessment_outlined),
          label: const Text('Valider l’évaluation'),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return SectionCard(
      title: title,
      icon: icon,
      child: Column(
        children: [
          ...children,
        ],
      ),
    );
  }

  Widget _buildCheckItem(
      String title, bool value, ValueChanged<bool?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: CheckboxListTile(
        title: Text(title),
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
        controlAffinity: ListTileControlAffinity.leading,
        dense: false,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        tileColor: AppColors.background,
      ),
    );
  }

  Widget _buildCommentsSection() {
    return SectionCard(
      title: 'Commentaires de l’inspecteur',
      icon: Icons.notes_outlined,
      child: TextFormField(
        controller: _commentController,
        maxLines: 4,
        decoration: const InputDecoration(
          hintText: 'Consignez vos observations officielles…',
        ),
      ),
    );
  }

  void _submitForm() {
    final result = EvaluationResult(
      criteria: {
        'Niveaux': _niveauxOk,
        'Pneus': _pneusOk,
        'Éclairage': _eclairageOk,
        'Réglage siège': _reglageSiegeOk,
        'Rétroviseurs': _retroviseursOk,
        'Ceinture': _ceintureOk,
        'Démarrage': _demarrageOk,
        'Maîtrise du volant': _maitriseVolantOk,
        'Marche arrière': _marcheArriereOk,
        'Stationnement': _stationnementOk,
        'Respect des limites': _respectLimitesOk,
      },
      comments: _commentController.text,
    );
    Navigator.of(context)
        .pushNamed(AppRoutesName.evaluationResult, arguments: result);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
