// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:get/get.dart';

// class ConnectivityService extends GetxService {
//   static ConnectivityService get instance => Get.find<ConnectivityService>();

//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

//   final RxBool _isConnected = true.obs;
//   bool get isConnected => _isConnected.value;

//   @override
//   void onInit() {
//     super.onInit();
//     _initConnectivity();

//     // ✅ Listen to the List<ConnectivityResult>
//     _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
//       List<ConnectivityResult> results,
//     ) {
//       _updateConnectionStatus(results);
//     });
//   }

//   @override
//   void onClose() {
//     _connectivitySubscription.cancel();
//     super.onClose();
//   }

//   Future<void> _initConnectivity() async {
//     try {
//       // ✅ Now correctly receives List<ConnectivityResult>
//       final results = await _connectivity.checkConnectivity();
//       _updateConnectionStatus(results); // ✅ Pass the list directly
//     } catch (e) {
//       print('Could not check connectivity status: $e');
//     }
//   }

//   void _updateConnectionStatus(List<ConnectivityResult> results) {
//     // ✅ Check if any connection is available
//     _isConnected.value = results.any((r) => r != ConnectivityResult.none);

//     if (!_isConnected.value) {
//       _showNoInternetSnackbar();
//     }
//   }

//   void _showNoInternetSnackbar() {
//     Get.snackbar(
//       'No Internet',
//       'Please check your internet connection',
//       snackPosition: SnackPosition.BOTTOM,
//       duration: const Duration(seconds: 3),
//     );
//   }

//   Future<bool> checkConnectivity() async {
//     // ✅ Also updated to handle List<ConnectivityResult>
//     final results = await _connectivity.checkConnectivity();
//     return results.any((result) => result != ConnectivityResult.none);
//   }
// }
