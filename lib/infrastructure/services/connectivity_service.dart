import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Stream<List<ConnectivityResult>> get connectivityStream =>
      _connectivity.onConnectivityChanged;

  Future<bool> get hasConnection async {
    final List<ConnectivityResult> result = await _connectivity.checkConnectivity();
    return result.isEmpty || result.first != ConnectivityResult.none;
  }
}
