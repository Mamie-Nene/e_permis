import 'package:flutter/material.dart';
import 'package:e_permis/src/data/models/candidate_model.dart';
import 'package:e_permis/src/utils/consts/routes/app_routes_name.dart';
import 'package:intl/intl.dart';

class InspectionDashboardPage extends StatefulWidget {
  const InspectionDashboardPage({Key? key}) : super(key: key);

  @override
  State<InspectionDashboardPage> createState() => _InspectionDashboardPageState();
}

class _InspectionDashboardPageState extends State<InspectionDashboardPage> {
  String selectedFilter = 'Tous';
  String selectedPermitType = 'Tous permis';
  final TextEditingController _searchController = TextEditingController();
  
  // Liste complète des candidats
  final List<Candidate> _allCandidates = [
    Candidate(name: 'Moussa Diop', drivingSchool: 'Auto-école Prestige', licenseType: 'Permis B', fileNumber: '2024-00123', evaluated: true),
    Candidate(name: 'Awa Fall', drivingSchool: 'Conduite Facile', licenseType: 'Permis A', fileNumber: '2024-00124', evaluated: true),
    Candidate(name: 'Ibrahima Gueye', drivingSchool: 'Volant d\'Or', licenseType: 'Permis C', fileNumber: '2024-00125', evaluated: false),
    Candidate(name: 'Fatou Ndiaye', drivingSchool: 'Sénégal Conduite', licenseType: 'Permis D', fileNumber: '2024-00126', evaluated: false),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filtrer les candidats selon les critères
  List<Candidate> get _filteredCandidates {
    return _allCandidates.where((candidate) {
      // Filtre par statut d'évaluation
      bool matchesStatus = true;
      if (selectedFilter == 'À évaluer') {
        matchesStatus = !candidate.evaluated;
      } else if (selectedFilter == 'Évalués') {
        matchesStatus = candidate.evaluated;
      }

      // Filtre par type de permis
      bool matchesPermitType = true;
      if (selectedPermitType != 'Tous permis') {
        matchesPermitType = candidate.licenseType == selectedPermitType;
      }

      // Filtre par recherche (nom ou auto-école)
      bool matchesSearch = true;
      if (_searchController.text.isNotEmpty) {
        final searchLower = _searchController.text.toLowerCase();
        matchesSearch = candidate.name.toLowerCase().contains(searchLower) ||
            candidate.drivingSchool.toLowerCase().contains(searchLower);
      }

      return matchesStatus && matchesPermitType && matchesSearch;
    }).toList();
  }

  // Calculer les statistiques
  int get _totalEvaluations => _allCandidates.length;
  int get _validatedFiles => _allCandidates.where((c) => c.evaluated).length;
  int get _remainingFiles => _totalEvaluations - _validatedFiles;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy').format(now);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0D4D3D), Color(0xFF1B7A63)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Bar
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.shield_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Inspection Permis · Dakar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Planning du $formattedDate',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.access_time, size: 16, color: Color(0xFF0D4D3D)),
                            SizedBox(width: 4),
                            Text(
                              '${_allCandidates.length} RDV',
                              style: TextStyle(
                                color: Color(0xFF0D4D3D),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  
                  // Greeting Text
                  Text(
                    'Bonjour Inspecteur,',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'voici la tournée officielle du jour.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  // Info Chips
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.coffee_outlined, color: Colors.white, size: 16),
                            SizedBox(width: 6),
                            Text(
                              'Briefing à 07h30',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.edit_outlined, color: Colors.white, size: 16),
                            SizedBox(width: 6),
                            Text(
                              'Signature numérique active',
                              style: TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Stats Cards
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Évaluations du jour',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.calendar_today, color: Color(0xFF1B7A63), size: 16),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            '$_totalEvaluations',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0D4D3D),
                            ),
                          ),
                          Text(
                            '$_totalEvaluations créneaux confirmés',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Dossiers validés',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.verified_outlined, color: Colors.amber, size: 16),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            '$_validatedFiles',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber[700],
                            ),
                          ),
                          Text(
                            '$_remainingFiles restants',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Filters Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Filtres rapides',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D4D3D),
                    ),
                  ),
                  SizedBox(height: 12),
                  
                  // First Filter Row (Statut)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('Tous', selectedFilter == 'Tous', () {
                          setState(() => selectedFilter = 'Tous');
                        }),
                        SizedBox(width: 8),
                        _buildFilterChip('À évaluer', selectedFilter == 'À évaluer', () {
                          setState(() => selectedFilter = 'À évaluer');
                        }),
                        SizedBox(width: 8),
                        _buildFilterChip('Évalués', selectedFilter == 'Évalués', () {
                          setState(() => selectedFilter = 'Évalués');
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  
                  // Second Filter Row (Type de permis)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('Tous permis', selectedPermitType == 'Tous permis', () {
                          setState(() => selectedPermitType = 'Tous permis');
                        }),
                        SizedBox(width: 8),
                        _buildFilterChip('Permis A', selectedPermitType == 'Permis A', () {
                          setState(() => selectedPermitType = 'Permis A');
                        }),
                        SizedBox(width: 8),
                        _buildFilterChip('Permis B', selectedPermitType == 'Permis B', () {
                          setState(() => selectedPermitType = 'Permis B');
                        }),
                        SizedBox(width: 8),
                        _buildFilterChip('Permis C', selectedPermitType == 'Permis C', () {
                          setState(() => selectedPermitType = 'Permis C');
                        }),
                        SizedBox(width: 8),
                        _buildFilterChip('Permis D', selectedPermitType == 'Permis D', () {
                          setState(() => selectedPermitType = 'Permis D');
                        }),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  
                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Filtrer par nom ou auto-école',
                        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                        prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 16),
            
            // Candidates List Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Candidats programmés',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0D4D3D),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      // TODO: Implémenter l'export
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Export du planning en cours...')),
                      );
                    },
                    icon: Icon(Icons.upload_outlined, size: 16, color: Color(0xFF1B7A63)),
                    label: Text(
                      'Exporter le planning',
                      style: TextStyle(color: Color(0xFF1B7A63), fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            
            // Candidates List
            Expanded(
              child: _filteredCandidates.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                          SizedBox(height: 16),
                          Text(
                            'Aucun candidat trouvé',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filteredCandidates.length,
                      itemBuilder: (context, index) {
                        final candidate = _filteredCandidates[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12),
                          child: _buildCandidateCard(candidate),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      
      // Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutesName.evaluationForm);
        },
        backgroundColor: Color(0xFF0D4D3D),
        icon: Icon(Icons.add_circle_outline),
        label: Text('Nouvelle évaluation'),
      ),
    );
  }
  
  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFD4E8E3) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Color(0xFF1B7A63) : Colors.grey[300]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(right: 6),
                child: Icon(
                  Icons.check,
                  size: 16,
                  color: Color(0xFF0D4D3D),
                ),
              ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Color(0xFF0D4D3D) : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCandidateCard(Candidate candidate) {
    final icon = _getLicenseIcon(candidate.licenseType);
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(0xFFD4E8E3),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Color(0xFF0D4D3D),
                    size: 24,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        candidate.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0D4D3D),
                        ),
                      ),
                      Text(
                        candidate.drivingSchool,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                if (candidate.evaluated)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Color(0xFFD4F4E8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 14,
                          color: Color(0xFF0D4D3D),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Évalué',
                          style: TextStyle(
                            color: Color(0xFF0D4D3D),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          
          Divider(height: 1, color: Colors.grey[200]),
          
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Type de permis',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      candidate.licenseType,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Numéro de dossier',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      candidate.fileNumber,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            AppRoutesName.candidateDetails,
                            arguments: candidate,
                          );
                        },
                        icon: Icon(Icons.description_outlined, size: 16),
                        label: Text('Fiche détaillée'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Color(0xFF0D4D3D),
                          side: BorderSide(color: Colors.grey[300]!),
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: candidate.evaluated
                            ? null
                            : () {
                                Navigator.of(context).pushNamed(
                                  AppRoutesName.evaluationForm,
                                );
                              },
                        icon: Icon(Icons.drive_eta, size: 16),
                        label: Text('Évaluer maintenant'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: candidate.evaluated
                              ? Colors.grey[300]
                              : Color(0xFF0D4D3D),
                          foregroundColor: candidate.evaluated
                              ? Colors.grey[600]
                              : Colors.white,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getLicenseIcon(String licenseType) {
    switch (licenseType) {
      case 'Permis A':
        return Icons.two_wheeler;
      case 'Permis B':
        return Icons.directions_car;
      case 'Permis C':
        return Icons.local_shipping;
      case 'Permis D':
        return Icons.directions_bus;
      default:
        return Icons.help_outline;
    }
  }
}
