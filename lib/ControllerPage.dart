// import 'package:flutter/material.dart';
// import 'package:graduation/InstructionPage.dart';
// import 'package:graduation/app_styles.dart';
// import 'package:flutter_blue_classic/flutter_blue_classic.dart';
// import 'dart:async';
// import 'dart:typed_data';
// import 'BluetoothService.dart';
// import 'navBar.dart';

// class ControllerPage extends StatefulWidget {
//   @override
//   _ControllerPageState createState() => _ControllerPageState();
// }

// // class _ControllerPageState extends State<ControllerPage> {
// //   int _currentIndex = 2;
// //   // BluetoothDevice? _selectedDevice;
// //   // bool _isConnected = false;
// //   // BluetoothConnection? _connection;
// //   List<BluetoothDevice> _bondedDevices = [];
// //   // final _flutterBlue = FlutterBlueClassic();
// //   // StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;
// //   VoidCallback? _onDisconnectedCallback;
// //   StreamSubscription<bool>? _connectionSubscription;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initBluetooth();
// //   }
// class _ControllerPageState extends State<ControllerPage> {
//   // Keep only these Bluetooth-related variables
//   final BluetoothManager _bluetoothManager = BluetoothManager();
//   List<BluetoothDevice> _bondedDevices = [];
//   StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _initBluetooth();
//     _bluetoothManager.initBluetooth(); // Initialize the manager
//   }

//     Future<void> _initBluetooth() async {
//     try {
//       await _refreshDevices();
//       _adapterStateSubscription = _bluetoothManager.flutterBlue.adapterState.listen((state) {
//         if (state == BluetoothAdapterState.on) _refreshDevices();
//       });
//     } catch (e) {
//       print("Bluetooth error: $e");
//     }
//   }

//     Future<void> _refreshDevices() async {
//     final devices = await _bluetoothManager.flutterBlue.bondedDevices;
//     setState(() => _bondedDevices = devices ?? []);
//   }

//   Future<bool> selectDevice() async {
//     bool deviceSelected = false;

//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Select HC-05"),
//           content: Column(
//             children: [
//               ElevatedButton(
//                 onPressed: _refreshDevices,
//                 child: Text("Refresh Devices"),
//               ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: _bondedDevices.map((device) {
//                       return ListTile(
//                         title: Text(device.name ?? "Unknown"),
//                         subtitle: Text(device.address),
//                         onTap: () async {
//                           Navigator.pop(context);
//                           await _bluetoothManager.connectToDevice(device);
//                           deviceSelected = true;
//                         },
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );

//     return deviceSelected;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppStyles.backgroundColor,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: AppStyles.primarybackground,
//         title: Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Align(
//               alignment: AlignmentDirectional(-1, -1),
//               child: Padding(
//                 padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
//                 child: Text("Controller",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 36,
//                         fontWeight: FontWeight.w500)),
//               ),
//             ),
//             Flexible(
//               child: Align(
//                 alignment: Alignment(1, -1),
//                 child: IconButton(
//                   icon: Icon(
//                     Icons.help_outline,
//                     color: AppStyles.textLight,
//                     size: 30,
//                   ),
//                   style: IconButton.styleFrom(
//                       backgroundColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       fixedSize: Size(60, 60)),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => InstructionPage()),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         top: true,
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 20),
//                 child: Container(
//                   width: 300,
//                   height: 260,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: Image.asset("assets/controller.jpg").image,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Padding(
//                 padding: EdgeInsets.all(10),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Text(
//                       'Connect to Bluetooth',
//                       style: TextStyle(
//                         fontFamily: 'Inter',
//                         fontSize: 16,
//                         letterSpacing: 0.0,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Expanded(
//                       child: Align(
//                         alignment: AlignmentDirectional(1, -1),
//                         child: Switch(
//                           value: _bluetoothManager.isConnected,
//                           activeColor: Colors.orange,
//                           onChanged: (bool value) async {
//                             if (value) {
//                               bool deviceSelected = await selectDevice();
//                               if (!deviceSelected) {
//                                 setState(() {});
//                               }
//                             } else {
//                               _bluetoothManager.disconnect();
//                             }
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               if (_bluetoothManager.selectedDevice != null)
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text("Connected to: ${_bluetoothManager.selectedDevice!.name}"),
//                 ),
//               SizedBox(height: 20),
//               Column(
//                 children: [
//                   _arrowButton(
//                     Icons.arrow_upward,
//                     onPressed: () => _bluetoothManager.sendCommand("F"),
//                     onReleased: () => _bluetoothManager.sendCommand("S"),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _arrowButton(
//                         Icons.arrow_back,
//                         onPressed: () => _bluetoothManager.sendCommand("L"),
//                         onReleased: () => _bluetoothManager.sendCommand("S"),
//                       ),
//                       Container(
//                         width: 60,
//                         height: 60,
//                         decoration: BoxDecoration(
//                           color: _bluetoothManager.isConnected
//                               ? const Color.fromARGB(255, 0, 167, 6)
//                               : Color.fromARGB(255, 206, 14, 0),
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       _arrowButton(
//                         Icons.arrow_forward,
//                         onPressed: () => _bluetoothManager.sendCommand("R"),
//                         onReleased: () => _bluetoothManager.sendCommand("S"),
//                       ),
//                     ],
//                   ),
//                   _arrowButton(
//                     Icons.arrow_downward,
//                     onPressed: () => _bluetoothManager.sendCommand("B"),
//                     onReleased: () => _bluetoothManager.sendCommand("S"),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: const ButtomNavbar(currentIndex: 2),
//     );
//   }

//   Widget _arrowButton(IconData icon,
//       {required VoidCallback onPressed, required VoidCallback onReleased}) {
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: GestureDetector(
//         onTapDown: (_) => onPressed(),
//         onTapUp: (_) => onReleased(),
//         onTapCancel: () => onReleased(),
//         child: Container(
//           width: 60,
//           height: 60,
//           decoration: BoxDecoration(
//             color: AppStyles.buttonColor,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Icon(icon, color: Colors.white, size: 30),
//         ),
//       ),
//     );
//   }
// }

// Meee
import 'package:flutter/material.dart';
import 'package:graduation/InstructionPage.dart';
import 'package:graduation/app_styles.dart';
import 'package:flutter_blue_classic/flutter_blue_classic.dart';
import 'dart:async';
import 'dart:typed_data';
import 'services/BluetoothService.dart';
import 'navBar.dart';

class ControllerPage extends StatefulWidget {
  @override
  _ControllerPageState createState() => _ControllerPageState();
}
class _ControllerPageState extends State<ControllerPage> {
  // Keep only these Bluetooth-related variables
  final BluetoothManager _bluetoothManager = BluetoothManager();
  List<BluetoothDevice> _bondedDevices = [];
  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;

  @override
  void initState() {
    super.initState();
    _bluetoothManager.isConnectedNotifier.addListener(_updateUI);
    _initBluetooth();
    _bluetoothManager.initBluetooth(); // Initialize the manager
  }

  @override
  void dispose() {
    _bluetoothManager.isConnectedNotifier.removeListener(_updateUI);
    super.dispose();
  }

  void _updateUI() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _initBluetooth() async {
    try {
      await _refreshDevices();
      _adapterStateSubscription =
          _bluetoothManager.flutterBlue.adapterState.listen((state) {
        if (state == BluetoothAdapterState.on) _refreshDevices();
      });
    } catch (e) {
      print("Bluetooth error: $e");
    }
  }

  Future<void> _refreshDevices() async {
    final devices = await _bluetoothManager.flutterBlue.bondedDevices;
    setState(() => _bondedDevices = devices ?? []);
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
                          await _bluetoothManager.connectToDevice(device);
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
                        child: 
                        // Switch(
                        //   value: _bluetoothManager.isConnected,
                        //   activeColor: Colors.orange,
                        //   onChanged: (bool value) async {
                        //     if (value) {
                        //       bool deviceSelected = await selectDevice();
                        //       if (!deviceSelected) {
                        //         setState(() {});
                        //       }
                        //     } else {
                        //       _bluetoothManager.disconnect();
                        //     }
                        //   },
                        // ),
                        Switch(
                          value: _bluetoothManager.isConnected,
                          activeColor: Colors.orange,
                          onChanged: (bool value) async {
                            if (value) {
                              bool deviceSelected = await selectDevice();
                              if (!deviceSelected) {
                                setState(() {});
                              }
                            } else {
                              _bluetoothManager.disconnect();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (_bluetoothManager.selectedDevice != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Connected to: ${_bluetoothManager.selectedDevice!.name}"),
                ),
              SizedBox(height: 20),
              Column(
                children: [
                  _arrowButton(
                    Icons.arrow_upward,
                    onPressed: () => _bluetoothManager.sendCommand("F"),
                    onReleased: () => _bluetoothManager.sendCommand("S"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _arrowButton(
                        Icons.arrow_back,
                        onPressed: () => _bluetoothManager.sendCommand("L"),
                        onReleased: () => _bluetoothManager.sendCommand("S"),
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: _bluetoothManager.isConnected
                              ? const Color.fromARGB(255, 0, 167, 6)
                              : Color.fromARGB(255, 206, 14, 0),
                          shape: BoxShape.circle,
                        ),
                      ),
                      _arrowButton(
                        Icons.arrow_forward,
                        onPressed: () => _bluetoothManager.sendCommand("R"),
                        onReleased: () => _bluetoothManager.sendCommand("S"),
                      ),
                    ],
                  ),
                  _arrowButton(
                    Icons.arrow_downward,
                    onPressed: () => _bluetoothManager.sendCommand("B"),
                    onReleased: () => _bluetoothManager.sendCommand("S"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const ButtomNavbar(currentIndex: 2),
    );
  }

  Widget _arrowButton(IconData icon,
      {required VoidCallback onPressed, required VoidCallback onReleased}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTapDown: (_) => onPressed(),
        onTapUp: (_) => onReleased(),
        onTapCancel: () => onReleased(),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppStyles.buttonColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}
