class AppResCode {
  static String resCode(String statusCode) {
    switch (statusCode) {
      case '0000':
        return 'RES_SUCCESS';
      case '0001':
        return 'RES_UNAUTHORIZED';
      case '0002':
        return 'RES_BAD_REQUEST';
      case '0003':
        return 'RES_SERVICE_UNAVAILABLE';
      case '0004':
        return 'RES_NOT_FOUND';
      case '0005':
        return 'RES_INTERNAL_SERVER_ERROR';
      case '0006':
        return 'RES_TOKEN_EXPIRED';
      case '0007':
        return 'RES_INVALID_CREDENTIALS';
      case '0008':
        return 'RES_VALIDATION_FAILED';
      case '0009':
        return 'RES_REFRESH_TOKEN_EXPIRED';
      case '0010':
        return 'RES_NO_FILE_UPLOADED';
      case '0020':
        return 'RES_SOMETHING_WENT_WRONG';
      case '0030':
        return 'RES_NO_PERMISSION';
      case '0040':
        return 'RES_USER_NOT_ACTIVE';
      case '0042':
        return 'RES_DUPLICATE_DEVICE';
      case '0050':
        return 'RES_LOCATION_NOT_ALLOWED';
      default:
        return 'Unknown Warning';
    }
  }
  
  static bool isSuccess(String statusCode) {
    return statusCode == '0000';
  }

  static String getErrorMessage(String statusCode) {
    switch (statusCode) {
      case '0000':
        return 'Success';
      case '0001':
        return 'Unauthorized access. Please check your credentials.';
      case '0002':
        return 'Invalid request. Please try again.';
      case '0003':
        return 'Service temporarily unavailable. Please try again later.';
      case '0004':
        return 'Resource not found.';
      case '0005':
        return 'Internal server error. Please try again later.';
      case '0006':
        return 'Your session has expired. Please login again.';
      case '0007':
        return 'Invalid username or password. Please try again.';
      case '0008':
        return 'Validation failed. Please check your input.';
      case '0009':
        return 'Session expired. Please login again.';
      case '0010':
        return 'No file uploaded.';
      case '0020':
        return 'Something went wrong. Please try again.';
      case '0030':
        return 'You do not have permission to perform this action.';
      case '0040':
        return 'Your account is not active. Please contact administrator.';
      case '0042':
        return 'This device is already registered with another account.';
      case '0050':
        return 'Location not allowed for this operation.';
      default:
        return 'Unknown error occurred. Please try again.';
    }
  }
}
