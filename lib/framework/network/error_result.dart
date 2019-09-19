/// 网络请求统一错误结果

class ErrorResult {
  /// error message
  String errorMessage;

  /// error code
  int errorCode;

  /// show toast
  bool showToast;

  ErrorResult(this.errorMessage, this.errorCode, [this.showToast = true]);

  @override
  String toString() {
    return 'ErrorResult{errorMessage: $errorMessage, errorCode: $errorCode, showToast: $showToast}';
  }

}