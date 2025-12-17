import '../entities/delivery_entity.dart';

abstract class DeliveryRepository {
  Future<List<DeliveryEntity>> getDeliveries();
}

