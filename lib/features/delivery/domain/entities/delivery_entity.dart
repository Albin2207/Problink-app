class DeliveryEntity {
  final String id;
  final String orderId; // e.g., "#INV-2024-1236"
  final String customerName; // e.g., "Dominic John"
  final String boxCount; // e.g., "5 Box"
  final String address; // e.g., "Downtown Miami, Biscayne Blvd, Miami, FL"
  final String dateTime; // e.g., "10 Nov 2026 - 9:30 AM"
  final String payment; // e.g., "COD"
  final String status; // e.g., "Out of delivery"

  const DeliveryEntity({
    required this.id,
    required this.orderId,
    required this.customerName,
    required this.boxCount,
    required this.address,
    required this.dateTime,
    required this.payment,
    required this.status,
  });
}

