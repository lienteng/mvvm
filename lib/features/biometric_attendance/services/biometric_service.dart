import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

// // enum BiometricType { none, fingerprint, face, iris }
enum AppBiometricType { none, fingerprint, face, iris, weak, strong }

enum BiometricStatus { unknown, available, notAvailable, notEnrolled }

class BiometricService {
  final LocalAuthentication _localAuth = LocalAuthentication();

  // Check if biometric authentication is available
  Future<BiometricStatus> getBiometricStatus() async {
    try {
      final bool isAvailable = await _localAuth.canCheckBiometrics;
      if (!isAvailable) {
        return BiometricStatus.notAvailable;
      }

      final List<AppBiometricType> availableBiometrics =
          await getAvailableBiometrics();
      if (availableBiometrics.isEmpty) {
        return BiometricStatus.notEnrolled;
      }

      return BiometricStatus.available;
    } catch (e) {
      print('BiometricService: Error checking biometric status: $e');
      return BiometricStatus.unknown;
    }
  }

  // Get available biometric types
  Future<List<AppBiometricType>> getAvailableBiometrics() async {
    try {
      final List<BiometricType> biometrics = await _localAuth
          .getAvailableBiometrics();

      return biometrics.map((b) {
        switch (b) {
          case BiometricType.face:
            return AppBiometricType.face;
          case BiometricType.fingerprint:
            return AppBiometricType.fingerprint;
          case BiometricType.iris:
            return AppBiometricType.iris;
          default:
            return AppBiometricType.none;
        }
      }).toList();
    } catch (e) {
      print('BiometricService: Error getting available biometrics: $e');
      return [];
    }
  }

  // Authenticate with biometrics
  Future<BiometricAuthResult> authenticate({
    required String reason,
    bool useErrorDialogs = true,
    bool stickyAuth = true,
  }) async {
    try {
      final BiometricStatus status = await getBiometricStatus();

      if (status != BiometricStatus.available) {
        return BiometricAuthResult(
          success: false,
          errorMessage: _getStatusMessage(status),
          errorType: BiometricErrorType.notAvailable,
        );
      }

      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: reason,
        options: AuthenticationOptions(
          useErrorDialogs: useErrorDialogs,
          stickyAuth: stickyAuth,
          biometricOnly: true,
        ),
      );
      if (didAuthenticate) {
        return BiometricAuthResult(success: true);
      } else {
        return BiometricAuthResult(
          success: false,
          errorMessage: 'Authentication was cancelled or failed',
          errorType: BiometricErrorType.userCancel,
        );
      }
    } on PlatformException catch (e) {
      return BiometricAuthResult(
        success: false,
        errorMessage: _handlePlatformException(e),
        errorType: _getErrorType(e.code),
      );
    } catch (e) {
      return BiometricAuthResult(
        success: false,
        errorMessage: 'An unexpected error occurred: ${e.toString()}',
        errorType: BiometricErrorType.unknown,
      );
    }
  }

  // Get user-friendly status message
  String _getStatusMessage(BiometricStatus status) {
    switch (status) {
      case BiometricStatus.notAvailable:
        return 'Biometric authentication is not available on this device';
      case BiometricStatus.notEnrolled:
        return 'No biometrics enrolled. Please set up fingerprint or face recognition in device settings';
      case BiometricStatus.unknown:
        return 'Unable to determine biometric availability';
      case BiometricStatus.available:
        return 'Biometric authentication is available';
    }
  }

  // Handle platform exceptions
  String _handlePlatformException(PlatformException e) {
    switch (e.code) {
      case auth_error.notEnrolled:
        return 'No biometrics enrolled. Please set up fingerprint or face recognition in device settings';
      case auth_error.lockedOut:
        return 'Biometric authentication is locked out. Please try again later';
      case auth_error.notAvailable:
        return 'Biometric authentication is not available on this device';
      case auth_error.passcodeNotSet:
        return 'Please set up a passcode or pattern lock first';
      case auth_error.permanentlyLockedOut:
        return 'Biometric authentication is permanently locked. Please use device passcode';
      default:
        return e.message ?? 'Biometric authentication failed';
    }
  }

  // Get error type from platform exception code
  BiometricErrorType _getErrorType(String? code) {
    switch (code) {
      case auth_error.notEnrolled:
        return BiometricErrorType.notEnrolled;
      case auth_error.lockedOut:
      case auth_error.permanentlyLockedOut:
        return BiometricErrorType.lockedOut;
      case auth_error.notAvailable:
        return BiometricErrorType.notAvailable;
      case auth_error.passcodeNotSet:
        return BiometricErrorType.passcodeNotSet;
      default:
        return BiometricErrorType.unknown;
    }
  }

  // Get biometric type name for display
  String getBiometricTypeName(AppBiometricType type) {
    switch (type) {
      case AppBiometricType.fingerprint:
        return 'Fingerprint';
      case AppBiometricType.weak:
        return 'Weak Biometric';
      case AppBiometricType.strong:
        return 'Strong Biometric';
      case AppBiometricType.face:
        return 'Face ID';
      case AppBiometricType.iris:
        return 'Iris';
      case AppBiometricType.none:
        return 'None';
    }
  }

  // Get available biometric names
  Future<String> getAvailableBiometricNames() async {
    final List<AppBiometricType> types = await getAvailableBiometrics();
    if (types.isEmpty) return 'None';

    return types.map((type) => getBiometricTypeName(type)).join(', ');
  }
}

class BiometricAuthResult {
  final bool success;
  final String? errorMessage;
  final BiometricErrorType? errorType;

  BiometricAuthResult({
    required this.success,
    this.errorMessage,
    this.errorType,
  });
}

enum BiometricErrorType {
  notAvailable,
  notEnrolled,
  lockedOut,
  passcodeNotSet,
  userCancel,
  unknown,
}
