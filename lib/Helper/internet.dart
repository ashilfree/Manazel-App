
import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';


Connectivity connectivity;
ConnectionStatusSingleton connectionStatus;
StreamSubscription _connectionChangeStream;
bool _isOffline = false;
bool _init = false;

void initConnected() {
  if(_init){
    return;
  }
  _init = true;
  if(connectivity != null){return;}
  connectionStatus.initialize();
  _connectionChangeStream = connectionStatus.connectionChange.listen(_connectionChanged);
}

connect(){
  if(connectivity == null){
    connectivity = Connectivity();
    connectionStatus = ConnectionStatusSingleton.getInstance();
    // connectionStatus.initialize();
  }
  return connectivity;
}

Future<bool> loopCheckInternet({Function onErrorListener,Function onInterNetAvailAbility})async{
  Completer<bool> completer = Completer<bool>();
  Timer.periodic(Duration(seconds: 1), (timer) async{
    try {
      final result = await InternetAddress.lookup('google.com');
      print(result[0]);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        timer.cancel();
        print('connected');
        if(completer.isCompleted){
          return null;
        }else{
          if(onInterNetAvailAbility!=null){
            onInterNetAvailAbility();
          }
          completer.complete(true);
        }
      }
    } on SocketException catch (_) {
      if(onErrorListener!=null){
        onErrorListener();
      }
    }
  });
  return completer.future;
}

void _connectionChanged(dynamic hasConnection) {
  _isOffline = !hasConnection;
}

dispose(){
  connectionStatus?.dispose();
  _connectionChangeStream?.cancel();
}

Future<bool> connection() async {
  connect();
  bool sss = await connectionStatus.isConnectivity();
  return sss;
}

class ConnectionStatusSingleton {
  //This creates the single instance by calling the `_internal` constructor specified below
  static final ConnectionStatusSingleton _singleton = new ConnectionStatusSingleton._internal();
  ConnectionStatusSingleton._internal();

  //This is what's used to retrieve the instance through the app
  static ConnectionStatusSingleton getInstance() => _singleton;

  //This tracks the current connection status
  bool hasConnection = false;

  //This is how we'll allow subscribing to connection changes
  StreamController connectionChangeController = new StreamController.broadcast();

  //flutter_connectivity
  final Connectivity _connectivity = Connectivity();

  //Hook into flutter_connectivity's Stream to listen for changes
  //And check the connection status out of the gate
  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  Stream get connectionChange => connectionChangeController.stream;

  //A clean up method to close our StreamController
  //   Because this is meant to exist through the entire application life cycle this isn't
  //   really an issue
  void dispose() {
    connectionChangeController.close();
  }

  //flutter_connectivity's listener
  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  //The test to actually see if there is a connection
  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch(_) {
      hasConnection = false;
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }
    return hasConnection;
  }


  Future<bool> isConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }


}