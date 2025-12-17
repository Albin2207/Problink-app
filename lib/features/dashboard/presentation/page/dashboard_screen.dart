import 'package:delivery_app/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive.dart';
import '../widgets/stats_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          AppStrings.dashboard,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: kToolbarHeight,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Responsive.maxContentWidth(context),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              Responsive.padding(context),
              0.0,
              Responsive.padding(context),
              Responsive.padding(context),
            ),
          child: Column(
            children: [
              StatsCard(
                  title: AppStrings.totalBoxesPending,
                  value: '28',
                  backgroundColor: AppColors.pendingBoxesCard,
                  icon: Icons.inventory_2_outlined,
                ),
                SizedBox(height: Responsive.spacing(context, 16)),
                StatsCard(
                  title: AppStrings.totalBoxesDelivered,
                  value: '156',
                  backgroundColor: AppColors.deliveredBoxesCard,
                  icon: Icons.check_circle_outline,
                  textColor: AppColors.textPrimary, // Black text for light blue card
                ),
                SizedBox(height: Responsive.spacing(context, 16)),
                StatsCard(
                  title: AppStrings.totalDeliveryPending,
                  value: '08',
                  backgroundColor: AppColors.pendingDeliveryCard,
                  icon: Icons.local_shipping_outlined,
                ),
                SizedBox(height: Responsive.spacing(context, 16)),
                StatsCard(
                  title: AppStrings.totalDeliveryDone,
                  value: '92',
                  backgroundColor: AppColors.deliveryDoneCard,
                  icon: Icons.check_circle_outline,
                ),
                SizedBox(height: Responsive.spacing(context, 16)),
                StatsCard(
                  title: AppStrings.totalKilometersTillDate,
                  value: '1,292',
                  backgroundColor: AppColors.kilometersCard,
                  icon: Icons.speed_outlined,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}