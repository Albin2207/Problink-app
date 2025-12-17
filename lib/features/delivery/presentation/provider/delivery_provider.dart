import 'package:flutter/foundation.dart';
import '../../domain/entities/delivery_entity.dart';
import '../../domain/repositories/delivery_repository.dart';

class DeliveryProvider with ChangeNotifier {
  final DeliveryRepository _repository;

  DeliveryProvider(this._repository);

  // State
  bool _isLoading = false;
  String? _errorMessage;
  List<DeliveryEntity> _deliveries = [];

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<DeliveryEntity> get deliveries => _deliveries;

  // Fetch deliveries
  Future<void> fetchDeliveries() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _deliveries = await _repository.getDeliveries();
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }
}

