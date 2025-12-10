// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:gibas/core/service/dio_service.dart';
// import 'package:get/get_state_manager/get_state_manager.dart';

// class NetworkService extends GetxService {
//   final DioService dioService;
//   final Connectivity connectivity;

//   NetworkService({
//     required this.dioService,
//     required this.connectivity,
//   });
//   final _connectionController = StreamController<bool>.broadcast();
//   Timer? _checkIntervalTimer;
//   late Timer _timerSync;

//   Stream<bool> get connectionStatus => _connectionController.stream;

//   @override
//   void onReady() {
//     _startMonitoring();
//     super.onReady();
//   }

//   @override
//   void onClose() {
//     dispose();
//     super.onClose();
//   }

//   Future<bool> get isConnected async {
//     final connectivityResult = await connectivity.checkConnectivity();

//     if (connectivityResult.first == ConnectivityResult.none) {
//       return false;
//     }

//     try {
//       await dioService.head();
//       return true;
//     } catch (_) {
//       return false;
//     }
//   }

//   void _startMonitoring() {
//     _checkConnection();

//     _checkIntervalTimer = Timer.periodic(
//       const Duration(seconds: 5),
//       (_) => _checkConnection(),
//     );

//     connectivity.onConnectivityChanged.listen((_) => _checkConnection());
//   }

//   Future<void> _checkConnection() async {
//     final currentStatus = await isConnected;
//     if (!_connectionController.isClosed) {
//       _connectionController.add(currentStatus);
//     }
//   }

//   Future<void> dispose() async {
//     _checkIntervalTimer?.cancel();
//     _timerSync.cancel();
//     await _connectionController.close();
//   }
// }
