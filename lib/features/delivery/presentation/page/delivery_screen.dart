import 'package:delivery_app/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

import '../widgets/delivery_card.dart';

class DeliveryListPage extends StatefulWidget {
  const DeliveryListPage({Key? key}) : super(key: key);

  @override
  State<DeliveryListPage> createState() => _DeliveryListPageState();
}

class _DeliveryListPageState extends State<DeliveryListPage> {
  final _searchController = TextEditingController();
  
  // Dummy data - will be replaced with Firebase data
  final List<Map<String, String>> _deliveries = [
    {
      'orderId': '#INV-2024-1236',
      'customerName': 'Dominic John',
      'boxCount': '5 Box',
      'address': 'Downtown Miami, Biscayne Blvd, Miami, FL',
      'dateTime': '10 Nov 2026 - 9:30 AM',
      'payment': 'COD',
      'status': 'Out of delivery',
    },
    {
      'orderId': '#INV-2024-1236',
      'customerName': 'John Doe',
      'boxCount': '5 Box',
      'address': 'Downtown Miami, Biscayne Blvd, Miami, FL',
      'dateTime': '10 Nov 2026 - 9:30 AM',
      'payment': 'COD',
      'status': 'Out of delivery',
    },
    {
      'orderId': '#INV-2024-1236',
      'customerName': 'Stefan Don',
      'boxCount': '5 Box',
      'address': 'Downtown Miami, Biscayne Blvd, Miami, FL',
      'dateTime': '10 Nov 2026 - 9:30 AM',
      'payment': 'COD',
      'status': 'Out of delivery',
    },
  ];

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
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          AppStrings.orders,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                    const SizedBox(width: 4),
                    const Text(
                      '10:30 AM',
                      style: TextStyle(
                        fontSize: 14,
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
                    const SizedBox(width: 4),
                    const Text(
                      '2hr 15min',
                      style: TextStyle(
                        fontSize: 14,
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
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        AppStrings.endDelivery,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: AppStrings.search,
                    hintStyle: TextStyle(
                      color: AppColors.textSecondary.withOpacity(0.5),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppColors.iconGrey,
                    ),
                    filled: true,
                    fillColor: AppColors.backgroundColor,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _deliveries.length,
        itemBuilder: (context, index) {
          final delivery = _deliveries[index];
          return DeliveryCard(
            orderId: delivery['orderId']!,
            customerName: delivery['customerName']!,
            boxCount: delivery['boxCount']!,
            address: delivery['address']!,
            dateTime: delivery['dateTime']!,
            payment: delivery['payment']!,
            status: delivery['status']!,
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}