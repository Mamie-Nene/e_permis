import 'package:flutter/material.dart';

import 'package:e_permis/src/domain/remote/Candidate.dart';
import 'package:e_permis/src/presentation/widgets/inspector_ui_kit.dart';
import 'package:e_permis/src/utils/consts/app_specifications/app_colors.dart';
import 'package:e_permis/src/utils/consts/routes/app_routes_name.dart';

class CandidateSelectionScreen extends StatefulWidget {
  const CandidateSelectionScreen({super.key});

  @override
  State<CandidateSelectionScreen> createState() =>
      _CandidateSelectionScreenState();
}

class _CandidateSelectionScreenState extends State<CandidateSelectionScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Candidate> _allCandidates = [

    Candidate(
      "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      'Gueye',
      'Ibrahima',
      'Volant d\'Or',
    'Permis C',
    '2024-00125',
      '2025-11-27',
      "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "Aucun",
    "Aucun",
    "2025-11-27",
      false,
      false,
    ),
    Candidate(

      "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      'Ndiaye',
      'Fatou ',
      'Sénégal Conduite',
    'Permis D',
    '2024-00126',
      '2025-11-27',
      "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "Aucun",
    "Aucun",
    "2025-11-27",
      false,
      false,
    ),
    Candidate(
      "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      'Diop',
      'Moussa',
      'Auto-école Prestige',
    'Permis B',
    '2024-00123',
      '2025-11-27',
      "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "Aucun",
    "Aucun",
    "2025-11-27",
      false,
      false,
    ),
    Candidate(

      "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      'Fall',
      'Awa',
      'Conduite Facile',
    'Permis A',
    '2024-00124',
      '2025-11-27',
      "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "Aucun",
    "Aucun",
    "2025-11-27",
      false,
      false,

    ),
    Candidate(

      "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      'Ba',
      'Ousmane',
      'Auto-école Excellence',
    'Permis B',
    '2024-00127',
      '2025-11-27',
      "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "Aucun",
    "Aucun",
    "2025-11-27",
      false,
      false,
    ),
    Candidate(
      "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      'Diallo',
      'Mariama',
      'Conduite Moderne',
    'Permis A',
    '2024-00128',
      '2025-11-27',
      "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      "Aucun",
    "Aucun",
    "2025-11-27",
      false,
      false,

    ),
  ];

  final List<String> _licenseOptions = [
    'Permis A',
    'Permis B',
    'Permis C',
    'Permis D'
  ];

  String? _licenseFilter;

  List<Candidate> get _visibleCandidates {
    return _allCandidates.where((candidate) {
      // Ne montrer que les candidats non évalués
      if (candidate.estEvalue) return false;

      final bool matchesSearch = candidate.nom
              .toLowerCase()
              .contains(_searchController.text.toLowerCase()) ||
          candidate.autoEcole
              .toLowerCase()
              .contains(_searchController.text.toLowerCase());
      final bool matchesLicense = _licenseFilter == null
          ? true
          : candidate.typePermis == _licenseFilter;
      return matchesSearch && matchesLicense;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Sélectionner un candidat'),
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.onBackground,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.primaryDark, AppColors.primary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.person_add_outlined,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nouvelle évaluation',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Sélectionnez un candidat non évalué',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Rechercher par nom ou auto-école',
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                  const SizedBox(height: 16),
                  _buildFilters(),
                ],
              ),
            ),
            Expanded(
              child: _visibleCandidates.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Aucun candidat à évaluer',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tous les candidats ont déjà été évalués',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _visibleCandidates.length,
                      itemBuilder: (context, index) {
                        final candidate = _visibleCandidates[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _buildCandidateCard(context, candidate),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Filtrer par type de permis',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              FilterChip(
                label: const Text('Tous permis'),
                selected: _licenseFilter == null,
                onSelected: (_) => setState(() => _licenseFilter = null),
              ),
              const SizedBox(width: 8),
              ..._licenseOptions.map((license) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(license),
                    selected: _licenseFilter == license,
                    onSelected: (_) {
                      setState(() {
                        _licenseFilter =
                            _licenseFilter == license ? null : license;
                      });
                    },
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCandidateCard(BuildContext context, Candidate candidate) {
    final bool isEvaluated = candidate.estEvalue;
    final Color accent = isEvaluated ? AppColors.primary : AppColors.secondary;
    final IconData icon = _getLicenseIconData(candidate.typePermis);

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutesName.candidateDetails,
            arguments: candidate,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                height: 56,
                width: 56,
                decoration: BoxDecoration(
                  color: accent.withOpacity(.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: accent),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidate.nom,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      candidate.autoEcole,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        StatusPill(
                          label: candidate.typePermis,
                          backgroundColor: AppColors.backgroundMuted,
                          foregroundColor: AppColors.onBackground,
                        ),
                        const SizedBox(width: 8),
                        StatusPill(
                          label: candidate.numeroDossier,
                          backgroundColor: AppColors.backgroundMuted,
                          foregroundColor: AppColors.onBackground,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isEvaluated)
                StatusPill(
                  label: 'Évalué',
                  icon: Icons.check_circle_outline,
                  backgroundColor: AppColors.primary.withOpacity(.1),
                  foregroundColor: AppColors.primary,
                )
              else
                Icon(
                  Icons.chevron_right,
                  color: Colors.grey[400],
                ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getLicenseIconData(String licenseType) {
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
