import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/delivery/data/datasources/delivery_remote_data_source.dart';
import '../../features/delivery/data/repositories/delivery_repository_impl.dart';
import '../../features/delivery/domain/repositories/delivery_repository.dart';

class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  // Firebase
  late final FirebaseAuth _firebaseAuth;
  late final FirebaseFirestore _firestore;

  // Data Sources
  late final AuthRemoteDataSource _authRemoteDataSource;
  late final DeliveryRemoteDataSource _deliveryRemoteDataSource;

  // Repositories
  late final AuthRepository _authRepository;
  late final DeliveryRepository _deliveryRepository;

  // Initialize
  Future<void> init() async {
    // Firebase
    _firebaseAuth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;

    // ========== Auth Feature ==========
    // Data Sources
    _authRemoteDataSource = AuthRemoteDataSourceImpl(_firebaseAuth);

    // Repositories
    _authRepository = AuthRepositoryImpl(_authRemoteDataSource);

    // ========== Delivery Feature ==========
    // Data Sources
    _deliveryRemoteDataSource = DeliveryRemoteDataSourceImpl(_firestore);

    // Repositories
    _deliveryRepository = DeliveryRepositoryImpl(_deliveryRemoteDataSource);
  }

  // Getters
  AuthRepository get authRepository => _authRepository;
  DeliveryRepository get deliveryRepository => _deliveryRepository;
}

final serviceLocator = ServiceLocator();

