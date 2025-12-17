import '../../domain/entities/delivery_entity.dart';
import '../../domain/repositories/delivery_repository.dart';
import '../datasources/delivery_remote_data_source.dart';

class DeliveryRepositoryImpl implements DeliveryRepository {
  final DeliveryRemoteDataSource _remoteDataSource;

  DeliveryRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<DeliveryEntity>> getDeliveries() async {
    try {
      final models = await _remoteDataSource.getDeliveries();
      return models;
    } catch (e) {
      throw Exception('Failed to get deliveries: ${e.toString()}');
    }
  }
}

