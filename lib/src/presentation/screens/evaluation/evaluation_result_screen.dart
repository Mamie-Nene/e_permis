import 'package:e_permis/src/domain/remote/evaluation/CriteriaValuForCategoryTypePermis.dart';
import 'package:e_permis/src/domain/remote/evaluation/Evaluation.dart';
import 'package:flutter/material.dart';

import 'package:e_permis/src/presentation/widgets/inspector_ui_kit.dart';
import 'package:e_permis/src/utils/consts/app_specifications/app_colors.dart';
import 'package:e_permis/src/utils/consts/routes/app_routes_name.dart';

class EvaluationResult {
  final Map<String, bool> criteria;
  final List<CriteriaValuForCategoryTypePermis> categories;
  final String comments;
  final String numeroDossierCandidat;
  final String typePermis;

  EvaluationResult(  {
    required this.categories,
    required this.numeroDossierCandidat,
    required this.typePermis,
    required this.criteria,
    required this.comments,
  });


  bool get isAdmis => !criteria.values.contains(false);
}

class EvaluationResultScreen extends StatelessWidget {
  final EvaluationResult result;

  const EvaluationResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final successCount = result.criteria.values.where((value) => value).length;
    final failedCount = result.criteria.length - successCount;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Résultat de l’évaluation'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.onBackground,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ProcessTimeline(
              steps: ['Fiche', 'Évaluation', 'Résultat', 'Signature'],
              currentIndex: 2,
            ),
            const SizedBox(height: 16),
            _buildStatusBanner(
                context, result.isAdmis, successCount, failedCount),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildCategoryPointsCard(),
                    const SizedBox(height: 16),
                    _buildSummaryCard(),
                    if (result.comments.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      _buildCommentsCard(),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBanner(
      BuildContext context, bool isAdmis, int successCount, int failedCount) {
    final Color color = isAdmis ? AppColors.primary : AppColors.accent;
    final String text = isAdmis ? 'ADMIS' : 'AJOURNÉ';
    final IconData icon =
        isAdmis ? Icons.verified_outlined : Icons.error_outline;
    final double successRate = (successCount / result.criteria.length) * 100;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withOpacity(.85), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(icon, color: Colors.white, size: 32),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Taux de réussite ${successRate.toStringAsFixed(0)}%',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              StatusPill(
                label: '$successCount critères validés',
                icon: Icons.check_circle_outline,
                backgroundColor: Colors.white,
                foregroundColor: color,
              ),
              StatusPill(
                label: '$failedCount points à revoir',
                icon: Icons.warning_amber_rounded,
                backgroundColor: Colors.white24,
                foregroundColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return SectionCard(
      title: 'Résumé des critères',
      icon: Icons.fact_check_outlined,
      child: Column(
        children: result.criteria.entries
            .map(
              (entry) => _buildResultRow(entry.key, entry.value),
            )
            .toList(),
      ),
    );
  }
  Widget _buildCategoryPointsCard() {
    final categoryResults = result.categories;

    return SectionCard(
      title: 'Points par catégorie',
      icon: Icons.category_outlined,
      child: Column(
        children: categoryResults.map((cat) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Icon(Icons.star, color: AppColors.primary, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    cat.nomCategorie,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onBackground),
                  ),
                ),
                Text(
                  '${cat.points} pts',
                  style: const TextStyle(fontSize: 16),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }


  Widget _buildCommentsCard() {
    return SectionCard(
      title: 'Commentaires',
      icon: Icons.notes_outlined,
      child: Text(
        result.comments,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }

  Widget _buildResultRow(String criterion, bool passed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(passed ? Icons.check_box_outlined : Icons.cancel_outlined,
              color: passed ? AppColors.primary : AppColors.accent, size: 22),
          const SizedBox(width: 12),
          Expanded(
              child: Text(criterion,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.onBackground)
              )
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).pop(),
              label: const Text('MODIFIER'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey[600],
                side: BorderSide(color: Colors.grey[400]!, width: 1.5),
                minimumSize: const Size(0, 55),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.arrow_forward_ios),
              label: const Text('SIGNER'),
              onPressed: () {
                Navigator.of(context).pushNamed(
                    AppRoutesName.signature,
                    arguments: result
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                minimumSize: const Size(0, 55),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
