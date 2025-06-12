import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_blue_classic/flutter_blue_classic.dart';
import 'dart:typed_data';

class BluetoothManager {
  // Private static instance
  static final BluetoothManager _instance = BluetoothManager._internal();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // Public factory constructor
  factory BluetoothManager() {
    return _instance;
  }

  final StreamController<String> _dataStreamController =
      StreamController<String>.broadcast();
  Stream<String> get dataStream => _dataStreamController.stream;

  // Private constructor
  BluetoothManager._internal();

  final ValueNotifier<bool> isConnectedNotifier = ValueNotifier(false);
  final FlutterBlueClassic _flutterBlue = FlutterBlueClassic();
  BluetoothDevice? _selectedDevice;
  BluetoothConnection? _connection;

  // Add public getter for FlutterBlue instance
  FlutterBlueClassic get flutterBlue => _flutterBlue;

  // Getter for connection status
  bool get isConnected => isConnectedNotifier.value;

  // Getter for selected device
  BluetoothDevice? get selectedDevice => _selectedDevice;

  // Initialize Bluetooth and set up listeners
  Future<void> initBluetooth() async {
    try {
      // Perform Bluetooth initialization tasks here
    } catch (e) {
      print("Bluetooth initialization error: $e");
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      _connection = await _flutterBlue.connect(device.address);
      if (_connection == null) throw Exception("Connection failed");

      _connection!.input?.listen(_handleIncomingData);
      _selectedDevice = device;
      isConnectedNotifier.value = true;
      print("Connected to ${device.name}");
    } catch (e) {
      print("Connection failed: $e");
      _cleanupConnection();
    }
  }

  void disconnect() {
    _connection?.dispose();
    _cleanupConnection();
    print("Disconnected");
  }

  void _cleanupConnection() {
    isConnectedNotifier.value = false; // Update notifier
    _selectedDevice = null;
    _connection = null;
  }

  void _handleIncomingData(Uint8List data) async {
    final rawString = String.fromCharCodes(data);
    final receivedString = rawString.replaceAll('"', '').trim();

    print("🟢 BluetoothService - Raw data: '$rawString'");
    print("🟢 BluetoothService - Cleaned data: '$receivedString'");
    print(
        "🟢 BluetoothService - Stream listeners: ${_dataStreamController.hasListener}");

    if (receivedString.isNotEmpty) {
      _dataStreamController.add(receivedString);
      print("🟢 BluetoothService - Data sent to stream: '$receivedString'");
    } else {
      print("🟡 BluetoothService - Empty data, not sending to stream");
    }
  }

  // Send a command to the connected Bluetooth device
  void sendCommand(String command) {
    // Change from _isConnected to isConnected
    if (isConnected && _connection != null && _connection!.isConnected) {
      try {
        _connection!.output.add(Uint8List.fromList(command.codeUnits));
        _connection!.output.allSent.then((_) => print("Sent: $command"));
      } catch (e) {
        print("Error sending command: $e");
        _cleanupConnection();
      }
    } else {
      print("Device not connected. Command not sent.");
    }
  }
}
