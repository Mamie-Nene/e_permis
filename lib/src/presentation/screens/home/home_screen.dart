import 'package:flutter/material.dart';

import 'package:e_permis/src/data/models/candidate_model.dart';
import 'package:e_permis/src/presentation/widgets/inspector_ui_kit.dart';
import 'package:e_permis/src/utils/consts/app_specifications/app_colors.dart';
import 'package:e_permis/src/utils/consts/routes/app_routes_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Candidate> _candidates = [
    Candidate(
      name: 'Ibrahima Gueye',
      drivingSchool: 'Volant d\'Or',
      licenseType: 'Permis C',
      fileNumber: '2024-00125',
    ),
    Candidate(
      name: 'Fatou Ndiaye',
      drivingSchool: 'Sénégal Conduite',
      licenseType: 'Permis D',
      fileNumber: '2024-00126',
    ),
    Candidate(
      name: 'Moussa Diop',
      drivingSchool: 'Auto-école Prestige',
      licenseType: 'Permis B',
      fileNumber: '2024-00123',
      evaluated: true,
    ),
    Candidate(
      name: 'Awa Fall',
      drivingSchool: 'Conduite Facile',
      licenseType: 'Permis A',
      fileNumber: '2024-00124',
      evaluated: true,
    ),
  ];

  final List<String> _statusOptions = ['Tous', 'À évaluer', 'Évalués'];
  final List<String> _licenseOptions = [
    'Permis A',
    'Permis B',
    'Permis C',
    'Permis D'
  ];

  String _statusFilter = 'Tous';
  String? _licenseFilter;

  List<Candidate> get _visibleCandidates {
    return _candidates.where((candidate) {
      final bool matchesSearch = candidate.name
          .toLowerCase()
          .contains(_searchController.text.toLowerCase());
      final bool matchesStatus = switch (_statusFilter) {
        'Évalués' => candidate.evaluated,
        'À évaluer' => !candidate.evaluated,
        _ => true,
      };
      final bool matchesLicense = _licenseFilter == null
          ? true
          : candidate.licenseType == _licenseFilter;
      return matchesSearch && matchesStatus && matchesLicense;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final total = _candidates.length;
    final evaluated = _candidates.where((c) => c.evaluated).length;
    final pending = total - evaluated;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeroHeader(total),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: KpiTile(
                            label: 'Évaluations du jour',
                            value: '$total',
                            caption: '4 créneaux confirmés',
                            icon: Icons.calendar_today_outlined,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: KpiTile(
                            label: 'Dossiers validés',
                            value: '$evaluated',
                            caption: '$pending restants',
                            icon: Icons.verified_outlined,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildFilters(),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Filtrer par nom ou auto-école',
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Candidats programmés',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.picture_as_pdf_outlined,
                              size: 18),
                          label: const Text('Exporter le planning'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            if (_visibleCandidates.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.fact_check_outlined,
                          size: 48, color: Colors.grey[500]),
                      const SizedBox(height: 12),
                      const Text('Aucun candidat ne correspond à ce filtre'),
                    ],
                  ),
                ),
              )
            else
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final candidate = _visibleCandidates[index];
                    return Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 16,
                          index == _visibleCandidates.length - 1 ? 24 : 12),
                      child: _buildCandidateCard(context, candidate),
                    );
                  },
                  childCount: _visibleCandidates.length,
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () =>
            Navigator.of(context).pushNamed(AppRoutesName.candidateSelection),
        icon: const Icon(Icons.assignment_add),
        label: const Text('Nouvelle évaluation'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
    );
  }

  Widget _buildHeroHeader(int total) {
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
          Row(
            children: [
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.1),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(Icons.shield_moon_outlined,
                    color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Inspection Permis · Dakar',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    ),
                    Text(
                      'Planning du ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              StatusPill(
                label: '$total RDV',
                icon: Icons.schedule_outlined,
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => Navigator.of(context)
                    .pushNamed(AppRoutesName.inspectorProfile),
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.person_outline,
                      color: Colors.white, size: 20),
                ),
                tooltip: 'Mon profil',
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Bonjour Inspecteur,\nvoici la tournée officielle du jour.',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: const [
              StatusPill(
                label: 'Briefing à 07h30',
                icon: Icons.campaign_outlined,
                backgroundColor: Colors.white24,
                foregroundColor: Colors.white,
              ),
              StatusPill(
                label: 'Signature numérique active',
                icon: Icons.gesture_outlined,
                backgroundColor: Colors.white24,
                foregroundColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Filtres rapides', style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: _statusOptions.map((status) {
            final bool selected = _statusFilter == status;
            return ChoiceChip(
              label: Text(status),
              selected: selected,
              onSelected: (_) => setState(() => _statusFilter = status),
              selectedColor: AppColors.primary.withOpacity(.15),
            );
          }).toList(),
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
    final bool isEvaluated = candidate.evaluated;
    final Color accent = isEvaluated ? AppColors.primary : AppColors.secondary;
    final IconData icon = _getLicenseIconData(candidate.licenseType);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                    color: accent.withOpacity(.12),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(icon, color: accent),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        candidate.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        candidate.drivingSchool,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                StatusPill(
                  label: isEvaluated ? 'Évalué' : 'À évaluer',
                  icon: isEvaluated
                      ? Icons.verified_outlined
                      : Icons.schedule_outlined,
                  backgroundColor: isEvaluated
                      ? AppColors.primary.withOpacity(.1)
                      : AppColors.secondaryMuted,
                  foregroundColor:
                      isEvaluated ? AppColors.primary : AppColors.onSecondary,
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            KeyValueRow(
              label: 'Type de permis',
              value: candidate.licenseType,
            ),
            KeyValueRow(
              label: 'Numéro de dossier',
              value: candidate.fileNumber,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.of(context).pushNamed(
                      AppRoutesName.candidateDetails,
                      arguments: candidate,
                    ),
                    icon: const Icon(Icons.assignment_outlined),
                    label: const Text('Fiche détaillée'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isEvaluated
                        ? null
                        : () => Navigator.of(context).pushNamed(
                              AppRoutesName.evaluationForm,
                            ),
                    icon: const Icon(Icons.drive_eta_outlined),
                    label: const Text('Évaluer maintenant'),
                  ),
                ),
              ],
            ),
          ],
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
