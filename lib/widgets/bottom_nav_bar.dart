// lib/widgets/common/bottom_nav_bar.dart

import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
  });

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
        // Account page - not implemented
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account page coming soon')),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
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
              _buildNavItem(
                context,
                icon: Icons.qr_code_scanner,
                activeIcon: Icons.qr_code_scanner,
                label: AppStrings.boxTrf,
                index: 2,
                isCenter: true,
              ),
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
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    bool isCenter = false,
  }) {
    final isActive = currentIndex == index;

    return InkWell(
      onTap: () => _onItemTapped(context, index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isCenter && isActive
              ? AppColors.primaryBlue
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isCenter)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isActive ? activeIcon : icon,
                  color: Colors.white,
                  size: 28,
                ),
              )
            else
              Icon(
                isActive ? activeIcon : icon,
                color: isActive ? AppColors.primaryBlue : AppColors.iconGrey,
                size: 24,
              ),
            if (!isCenter) ...[
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? AppColors.primaryBlue : AppColors.iconGrey,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}