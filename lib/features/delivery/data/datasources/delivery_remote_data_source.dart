import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/delivery_model.dart';
import '../../../../core/constants/app_constants.dart';

abstract class DeliveryRemoteDataSource {
  Future<List<DeliveryModel>> getDeliveries();
}

class DeliveryRemoteDataSourceImpl implements DeliveryRemoteDataSource {
  final FirebaseFirestore _firestore;

  DeliveryRemoteDataSourceImpl(this._firestore);

  @override
  Future<List<DeliveryModel>> getDeliveries() async {
    try {
      final querySnapshot = await _firestore
          .collection(AppConstants.deliveriesCollection)
          .get();

      return querySnapshot.docs
          .map((doc) => DeliveryModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch deliveries: ${e.toString()}');
    }
  }
}

