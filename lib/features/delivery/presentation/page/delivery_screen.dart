// lib/features/delivery/presentation/pages/delivery_list_page.dart

import 'package:delivery_app/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../provider/delivery_provider.dart';
import '../widgets/delivery_card.dart';

class DeliveryListPage extends StatefulWidget {
  const DeliveryListPage({Key? key}) : super(key: key);

  @override
  State<DeliveryListPage> createState() => _DeliveryListPageState();
}

class _DeliveryListPageState extends State<DeliveryListPage> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch deliveries when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DeliveryProvider>().fetchDeliveries();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          AppStrings.orders,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header Section with Time and Search
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: Column(
              children: [
                // Time and End Delivery Row
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: AppColors.iconBlue,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      '10:30 AM',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(
                      Icons.timer_outlined,
                      size: 16,
                      color: AppColors.iconBlue,
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      '2hr 15min',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement end delivery
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonBlue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        AppStrings.endDelivery,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: AppStrings.search,
                      hintStyle: TextStyle(
                        color: AppColors.textSecondary.withOpacity(0.5),
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.iconGrey,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: AppColors.backgroundColor,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(
                          color: AppColors.primaryBlue.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Delivery List
          Expanded(
            child: Consumer<DeliveryProvider>(
              builder: (context, deliveryProvider, child) {
                if (deliveryProvider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (deliveryProvider.errorMessage != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Error: ${deliveryProvider.errorMessage}',
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            deliveryProvider.fetchDeliveries();
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (deliveryProvider.deliveries.isEmpty) {
                  return const Center(
                    child: Text(
                      'No deliveries found',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: deliveryProvider.deliveries.length,
                  itemBuilder: (context, index) {
                    final delivery = deliveryProvider.deliveries[index];
                    return DeliveryCard(
                      orderId: delivery.orderId,
                      customerName: delivery.customerName,
                      boxCount: delivery.boxCount,
                      address: delivery.address,
                      dateTime: delivery.dateTime,
                      payment: delivery.payment,
                      status: delivery.status,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}