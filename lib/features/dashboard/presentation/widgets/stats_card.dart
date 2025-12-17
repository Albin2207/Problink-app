import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/responsive.dart';

class StatsCard extends StatelessWidget {
  final String title;
  final String value;
  final Color backgroundColor;
  final IconData icon;
  final Color textColor;

  const StatsCard({
    super.key,
    required this.title,
    required this.value,
    required this.backgroundColor,
    required this.icon,
    this.textColor = AppColors.textWhite, // Default to white
  });

  @override
  Widget build(BuildContext context) {
    final cardHeight = Responsive.isMobile(context) ? 100.0 : 120.0;
    final titleSize = Responsive.fontSize(context, 12);
    final valueSize = Responsive.fontSize(context, 24);
    final iconSize = Responsive.fontSize(context, 24);
    final padding = Responsive.padding(context);
    
    return Container(
      width: double.infinity,
      height: cardHeight,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: titleSize,
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: Responsive.spacing(context, 8)),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: valueSize,
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(Responsive.spacing(context, 12)),
            decoration: BoxDecoration(
              color: textColor == AppColors.textWhite 
                  ? Colors.white.withOpacity(0.3)
                  : Colors.white.withOpacity(0.3), // White background for blue card
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.textWhite, // Always white icon
              size: iconSize,
            ),
          ),
        ],
      ),
    );
  }
}