import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';

class DeliveryCard extends StatelessWidget {
  final String orderId;
  final String customerName;
  final String boxCount;
  final String address;
  final String dateTime;
  final String payment;
  final String status;

  const DeliveryCard({
    super.key,
    required this.orderId,
    required this.customerName,
    required this.boxCount,
    required this.address,
    required this.dateTime,
    required this.payment,
    required this.status,
  });

  // Helper function to format address into 2 lines
  String _formatAddress(String addr) {
    // If address already has line break, return as is
    if (addr.contains('\n')) return addr;
    
    // Split at common patterns (Blvd, Ave, St, Road, etc.)
    final patterns = ['Blvd,', 'Ave,', 'St,', 'Street,', 'Road,', 'Dr,'];
    
    for (var pattern in patterns) {
      if (addr.contains(pattern)) {
        return addr.replaceFirst(pattern, '$pattern\n');
      }
    }
    
    // If no pattern found, just return as is (will wrap naturally)
    return addr;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.borderGrey.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order ID and Customer Name Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order ID
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.orderId,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    orderId,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              
              // Customer Name
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline,
                        size: 14,
                        color: AppColors.iconBlue,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        AppStrings.customerName,
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    customerName,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Divider Line
          Divider(
            color: AppColors.borderGrey.withOpacity(0.3),
            thickness: 1,
            height: 1,
          ),
          
          const SizedBox(height: 12),
          
          // Box Count and Status Badge Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.inventory_2_outlined,
                    size: 16,
                    color: AppColors.iconBlue,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    boxCount,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              // Status Badge - "Out of delivery"
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.statusOutOfDelivery, // #16A24929 (16% opacity)
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  status,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.statusTextGreen,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Address (automatically formatted to 2 lines)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 16,
                color: AppColors.iconBlue,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  _formatAddress(address), // Use helper function
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textPrimary,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Date & Time and Payment Row
          Row(
            children: [
              Expanded(
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.dateTime,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateTime,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.payment,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      payment,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}