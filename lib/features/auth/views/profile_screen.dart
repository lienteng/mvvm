import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../../../core/utils/dialog_utils.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: Consumer<AuthViewModel>(
        builder: (context, authViewModel, child) {
          final user = authViewModel.currentUser;
          
          if (user == null) {
            return const Center(child: Text('No user data available'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Profile Header
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: user.avatar != null
                              ? NetworkImage(user.avatar!)
                              : null,
                          child: user.avatar == null
                              ? Text(
                                  user.employee.name.substring(0, 1).toUpperCase(),
                                  style: const TextStyle(fontSize: 32),
                                )
                              : null,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          user.employee.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user.employee.empNo,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Employee Information
                _buildInfoCard(
                  'Employee Information',
                  [
                    _buildInfoRow('Position', user.employee.position.nameEn),
                    _buildInfoRow('Duties', user.employee.duties),
                    _buildInfoRow('Email', user.employee.email),
                    _buildInfoRow('Phone', user.employee.mobilePhone),
                    _buildInfoRow('Gender', user.employee.gender.nameEn),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Location Information
                _buildInfoCard(
                  'Location Information',
                  [
                    _buildInfoRow('Province', user.employee.province.nameEn),
                    _buildInfoRow('District', user.employee.district.nameEn),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Roles
                _buildInfoCard(
                  'Roles',
                  user.userRoles.map((userRole) => 
                    ListTile(
                      leading: const Icon(Icons.admin_panel_settings),
                      title: Text(userRole.role.name.toUpperCase()),
                      subtitle: userRole.role.description != null 
                          ? Text(userRole.role.description!)
                          : null,
                    ),
                  ).toList(),
                ),
                const SizedBox(height: 16),
                
                // Permissions
                _buildInfoCard(
                  'Permissions',
                  user.userPermissions.map((userPermission) => 
                    ListTile(
                      leading: const Icon(Icons.security),
                      title: Text(userPermission.permission.name),
                      subtitle: Text(userPermission.permission.description),
                    ),
                  ).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    DialogUtils.showConfirmationDialog(
      context,
      title: 'Logout',
      message: 'Are you sure you want to logout?',
      confirmText: 'Logout',
      cancelText: 'Cancel',
      onConfirm: () async {
        await context.read<AuthViewModel>().logout();
        if (context.mounted) {
          context.go('/login');
        }
      },
    );
  }
}
