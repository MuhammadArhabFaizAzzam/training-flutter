import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Akun Saya')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildProfileSection(),
              const SizedBox(height: 30),
              _buildSettingsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4C53A5), Color(0xFF6B7CDA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              'assets/images/arhab-faiz.jpg',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.person, size: 80, color: Colors.white);
              },
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Arhab Faiz',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'arhabfaiz@siuuu.com',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Settings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 10),
        _buildSettingItem(
          context: context,
          icon: Icons.person_outline,
          title: 'Profile',
          onTap: () {
            _showComingSoon(context, 'Profile');
          },
        ),
        _buildSettingItem(
          context: context,
          icon: Icons.lock_outline,
          title: 'Change Password',
          onTap: () {
            _showComingSoon(context, 'Change Password');
          },
        ),
        _buildSettingItem(
          context: context,
          icon: Icons.notifications_outlined,
          title: 'Notifications',
          onTap: () {
            _showComingSoon(context, 'Notifications');
          },
        ),
        _buildSettingItem(
          context: context,
          icon: Icons.help_outline,
          title: 'Help & Support',
          onTap: () {
            _showComingSoon(context, 'Help & Support');
          },
        ),
        _buildSettingItem(
          context: context,
          icon: Icons.logout,
          title: 'Logout',
          onTap: () {
            _showLogoutDialog(context);
          },
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF4C53A5), size: 28),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
          size: 16,
        ),
        onTap: onTap,
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Fitur $feature dalam pengembangan'),
        backgroundColor: const Color(0xFF4C53A5),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text('Ya, Logout'),
            ),
          ],
        );
      },
    );
  }
}
