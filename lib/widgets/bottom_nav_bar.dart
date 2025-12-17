// lib/widgets/common/bottom_nav_bar.dart

import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/delivery-list');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/qr-scanner');
        break;
      case 3:
        // Box Transfer page - not implemented
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Box Transfer page coming soon')),
        );
        break;
      case 4:
        // Account page - not implemented
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account page coming soon')),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        // Bottom Navigation Bar
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: Container(
              height: 65,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    context,
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home,
                    label: AppStrings.home,
                    index: 0,
                  ),
                  _buildNavItem(
                    context,
                    icon: Icons.list_alt_outlined,
                    activeIcon: Icons.list_alt,
                    label: AppStrings.delivery,
                    index: 1,
                  ),
                  // Spacer for floating button
                  const SizedBox(width: 60),
                  _buildNavItem(
                    context,
                    icon: Icons.inventory_2_outlined,
                    activeIcon: Icons.inventory_2,
                    label: AppStrings.boxTrf,
                    index: 3,
                  ),
                  _buildNavItem(
                    context,
                    icon: Icons.person_outline,
                    activeIcon: Icons.person,
                    label: AppStrings.account,
                    index: 4,
                  ),
                ],
              ),
            ),
          ),
        ),
        
        // Floating QR Scanner Button
        Positioned(
          bottom: 20,
          child: GestureDetector(
            onTap: () => _onItemTapped(context, 2),
            child: Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryBlue.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
  }) {
    final isActive = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => _onItemTapped(context, index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? AppColors.primaryBlue : AppColors.iconGrey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isActive ? AppColors.primaryBlue : AppColors.iconGrey,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}