import 'package:flutter/material.dart';
import 'package:graduation/InstructionPage.dart';
import 'package:graduation/app_styles.dart';
import 'package:flutter_blue_classic/flutter_blue_classic.dart';
import 'dart:async';
import 'dart:typed_data';
import 'navBar.dart';

class ControllerPage extends StatefulWidget {
  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  int _currentIndex = 2;
  BluetoothDevice? _selectedDevice;
  bool _isConnected = false;
  BluetoothConnection? _connection;
  List<BluetoothDevice> _bondedDevices = [];
  final _flutterBlue = FlutterBlueClassic();
  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;
    VoidCallback? _onDisconnectedCallback;
  StreamSubscription<bool>? _connectionSubscription;

  @override
  void initState() {
    super.initState();
    _initBluetooth();
  }

  @override
  void dispose() {
    _adapterStateSubscription?.cancel();
    _connection?.dispose();
    super.dispose();
  }

  Future<void> _initBluetooth() async {
    try {
      // Get updated bonded devices list
      await _refreshDevices();

      // Listen for Bluetooth state changes
      _adapterStateSubscription = _flutterBlue.adapterState.listen((state) {
        if (state == BluetoothAdapterState.on) {
          _refreshDevices();
        }
      });
    } catch (e) {
      print("Bluetooth error: $e");
    }
  }

  Future<void> _refreshDevices() async {
    final devices = await _flutterBlue.bondedDevices;
    setState(() {
      _bondedDevices = devices ?? []; // Handle null case
    });
  }


  Future<bool> selectDevice() async {
    bool deviceSelected = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select HC-05"),
          content: Column(
            children: [
              ElevatedButton(
                onPressed: _refreshDevices,
                child: Text("Refresh Devices"),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: _bondedDevices.map((device) {
                      return ListTile(
                        title: Text(device.name ?? "Unknown"),
                        subtitle: Text(device.address),
                        onTap: () async {
                          Navigator.pop(context);
                          await _connectToDevice(device);
                          deviceSelected = true;
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    return deviceSelected;
  }


Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      _connection = await _flutterBlue.connect(device.address);
      if (_connection == null) {
        throw Exception("Failed to establish connection.");
      }

      // Ensure _connection.input is not null before listening
      if (_connection!.input != null) {
        _connection!.input!.listen(_handleIncomingData);
      } else {
        print("Warning: _connection.input is null. No data received.");
      }

      // Instead of connectionState, check isConnected directly
      setState(() {
        _selectedDevice = device;
        _isConnected = _connection!.isConnected;
      });

      print("Connected to ${device.name}");
    } catch (e) {
      print("Connection failed: $e");
      _cleanupConnection();
    }
  }



  void _handleIncomingData(Uint8List data) {
    print("Received: ${String.fromCharCodes(data)}");
  }

  void _cleanupConnection() {
    setState(() {
      _isConnected = false;
      _selectedDevice = null;
      _connection = null;
    });
  }

void disconnect() async {
    if (_connection != null) {
      _connection!.dispose();
      _cleanupConnection();
      print("Disconnected");
    }
  }

  void sendCommand(String command) {
    if (_isConnected && _connection != null && _connection!.isConnected) {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppStyles.primarybackground,
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentDirectional(-1, -1),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: Text("Controller",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w500)),
              ),
            ),
            Flexible(
              child: Align(
                alignment: Alignment(1, -1),
                child: IconButton(
                  icon: Icon(
                    Icons.help_outline,
                    color: AppStyles.textLight,
                    size: 30,
                  ),
                  style: IconButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      fixedSize: Size(60, 60)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InstructionPage()),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
                child: Container(
                  width: 300,
                  height: 260,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset("assets/controller.jpg").image,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Connect to Bluetooth',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        letterSpacing: 0.0,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(1, -1),
                        child: Switch(
                          value: _isConnected,
                          activeColor: Colors.orange,
                          onChanged: (bool value) async {
                            if (value) {
                              bool deviceSelected = await selectDevice();
                              if (!deviceSelected) {
                                setState(() => _isConnected = false);
                              }
                            } else {
                              disconnect();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_selectedDevice != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Connected to: ${_selectedDevice!.name}"),
                ),
              SizedBox(height: 20),
              Column(
                children: [
                  _arrowButton(Icons.arrow_upward, () => sendCommand("F")),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _arrowButton(Icons.arrow_back, () => sendCommand("L")),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                      _arrowButton(Icons.arrow_forward, () => sendCommand("R")),
                    ],
                  ),
                  _arrowButton(Icons.arrow_downward, () => sendCommand("B")),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ButtomNavbar(currentIndex: 2),
    );
  }

  // Arrow Button Widget
  Widget _arrowButton(IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppStyles.buttonColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.all(15),
          minimumSize: Size(60, 60),
        ),
        onPressed: onPressed,
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }
}
