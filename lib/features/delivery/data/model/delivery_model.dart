import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/delivery_entity.dart';

class DeliveryModel extends DeliveryEntity {
  const DeliveryModel({
    required super.id,
    required super.orderId,
    required super.customerName,
    required super.boxCount,
    required super.address,
    required super.dateTime,
    required super.payment,
    required super.status,
  });

  factory DeliveryModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return DeliveryModel(
      id: doc.id,
      orderId: data['orderId'] as String? ?? '#INV-${doc.id}',
      customerName: data['customerName'] as String? ?? '',
      boxCount: data['boxCount'] as String? ?? '0 Box',
      address: data['address'] as String? ?? '',
      dateTime: data['dateTime'] as String? ?? '',
      payment: data['payment'] as String? ?? 'COD',
      status: data['status'] as String? ?? 'Out of delivery',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'orderId': orderId,
      'customerName': customerName,
      'boxCount': boxCount,
      'address': address,
      'dateTime': dateTime,
      'payment': payment,
      'status': status,
    };
  }
}

