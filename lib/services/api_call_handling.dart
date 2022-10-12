class ApiCallHandling {
  putDelay(bool value) async {
    await Future.delayed(const Duration(seconds: 3));
    value = true;
  }
}
