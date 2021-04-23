class Environment {
  static const bool isDevelopment = true;
  static const String baseUrl =
      isDevelopment ? 'https://10.0.2.2:5001/api' : 'https://moviephile.com.co';
}
