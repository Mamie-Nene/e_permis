
import 'package:e_permis/src/utils/consts/app_specifications/app_colors.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Mon Profil'),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.primary,
                child: Icon(Icons.person, color: AppColors.onPrimary, size: 70),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Abdoulaye Wade', // Placeholder name
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.onBackground),
              ),
            ),
            Center(
              child: Text(
                'Matricule: 12345-B', // Placeholder ID
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 40),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 2,
              child: ListTile(
                leading: const Icon(Icons.logout, color: AppColors.accent),
                title: const Text('Se déconnecter', style: TextStyle(fontWeight: FontWeight.bold)),
                onTap: () {
                  // TODO: Implement logout logic and navigate to login screen
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
