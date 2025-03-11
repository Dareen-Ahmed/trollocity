// import 'package:flutter/material.dart';
// import 'package:graduation/InstructionPage.dart';
// import 'package:graduation/app_styles.dart';
// import 'dart:typed_data';
// import 'navBar.dart';

// class ControllerPage extends StatefulWidget {
//   @override
//   _ControllerPageState createState() => _ControllerPageState();
// }

// class _ControllerPageState extends State<ControllerPage> {
//   int _currentIndex = 2;
//   BluetoothDevice? selectedDevice;
//   bool isConnected = false; // Default selected index for the Controller screen
//   BluetoothCharacteristic? characteristic;
//   List<BluetoothDevice> bondedDevices = [];

//   @override
//    void initState(){
//     super.initState();
//     _initBluetooth();
//    }

//   Future<void> _initBluetooth() async{
//      // Check if Bluetooth is available
//     bool isAvailable = await FlutterBluePlus.instance.isAvailable;
//     if (!isAvailable) {
//       print("Bluetooth not available");
//       return;
//     }
//      // Get bonded devices
//     bondedDevices = await FlutterBluePlus.instance.bondedDevices;
//     setState(() {});

//      // Listen for connection changes
//     FlutterBluePlus.instance.connectionState.listen((state) {
//       if (state == BluetoothConnectionState.disconnected && isConnected) {
//         setState(() {
//           isConnected = false;
//           selectedDevice = null;
//           characteristic = null;
//         });
//       }
//     });
//   }

//     Future<bool> selectDevice() async {
//     bool deviceSelected = false;

//     await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Select the bluetooth device"),
//           content: SingleChildScrollView(
//             child: Column(
//               children: bondedDevices.map((device) {
//                 return ListTile(
//                   title: Text(device.platformName),
//                   subtitle: Text(device.remoteId.toString()),
//                   onTap: () async {
//                     Navigator.pop(context);
//                     await connectToDevice(device);
//                     deviceSelected = true;
//                   },
//                 );
//               }).toList(),
//             ),
//           ),
//         );
//       },
//     );

//     return deviceSelected;
//   }

//   Future<void> connectToDevice(BluetoothDevice device) async {
//     try {
//       await device.connect(timeout: Duration(seconds: 5));
//       List<BluetoothService> services = await device.discoverServices();

//       // Replace these UUIDs with your actual service/characteristic UUIDs
//       var service = services.firstWhere(
//         (s) => s.serviceUuid == Guid("00001101-0000-1000-8000-00805f9b34fb"),
//       );

//       characteristic = service.characteristics.firstWhere(
//         (c) =>
//             c.characteristicUuid ==
//             Guid("00001101-0000-1000-8000-00805f9b34fb"),
//       );

//       setState(() {
//         selectedDevice = device;
//         isConnected = true;
//       });
//       print("Connected to ${device.platformName}");
//     } catch (e) {
//       print("Connection failed: $e");
//       await device.disconnect();
//     }
//   }

//   void disconnect() async {
//     if (selectedDevice != null) {
//       await selectedDevice!.disconnect();
//       setState(() {
//         isConnected = false;
//         selectedDevice = null;
//         characteristic = null;
//       });
//       print("Disconnected");
//     }
//   }

//   void sendCommand(String command) async {
//     if (isConnected && characteristic != null) {
//       try {
//         await characteristic!.write(command.codeUnits);
//         print("Sent: $command");
//       } catch (e) {
//         print("Error sending command: $e");
//       }
//     } else {
//       print("Not connected to any device");
//     }
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
//               // Updated Image
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
//                         color: Colors.black, // Add appropriate color
//                       ),
//                     ),
//                     Expanded(
//                       child: Align(
//                         alignment: AlignmentDirectional(1, -1),
//                         child: Switch(
//                           value: isConnected,
//                           activeColor: Colors.orange,
//                           onChanged: (bool value) async {
//                             if (value) {
//                               bool deviceSelected = await selectDevice();
//                               if (!deviceSelected) {
//                                 setState(() {
//                                   isConnected = false;
//                                 });
//                               }
//                             } else {
//                               disconnect();
//                             }
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               if (selectedDevice != null)
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text("Connected to: ${selectedDevice!.platformName}"),
//                 ),

//               SizedBox(height: 20),

//               Column(
//                 children: [
//                   _arrowButton(Icons.arrow_upward, () => sendCommand("F")),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _arrowButton(Icons.arrow_back, () => sendCommand("L")),
//                       Container(
//                         width: 60,
//                         height: 60,
//                         decoration: BoxDecoration(
//                           color: Colors.green,
//                           shape: BoxShape.circle,
//                         ),
//                       ),
//                       _arrowButton(Icons.arrow_forward, () => sendCommand("R")),
//                     ],
//                   ),
//                   _arrowButton(Icons.arrow_downward, () => sendCommand("B")),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         // // Arrow Buttons Layout (Cross Shape)
//         // Column(
//         //   children: [
//         //     // Up Arrow
//         //     _arrowButton(Icons.arrow_upward, () {
//         //       print("Up pressed");
//         //     }
//         //     ),

//         //     Row(
//         //       mainAxisAlignment: MainAxisAlignment.center,
//         //       children: [
//         //         // Left Arrow
//         //         _arrowButton(Icons.arrow_back, () {
//         //           print("Left pressed");
//         //         }),

//         //         // Green Center Button (No action needed)
//         //         Container(
//         //           width: 60,
//         //           height: 60,
//         //           decoration: BoxDecoration(
//         //             color: Colors.green,
//         //             shape: BoxShape.circle,
//         //           ),
//         //         ),

//         //         // Right Arrow
//         //         _arrowButton(Icons.arrow_forward, () {
//         //           print("Right pressed");
//         //         }),
//         //       ],
//         //     ),

//         //     // Down Arrow
//         //     _arrowButton(Icons.arrow_downward, () {
//         //       print("Down pressed");
//         //     }),
//         //   ],
//         // ),
//       ),
//       bottomNavigationBar: const ButtomNavbar(currentIndex: 2),
//     );
//   }

//   // Arrow Button Widget
//   Widget _arrowButton(IconData icon, VoidCallback onPressed) {
//     return Padding(
//       padding: const EdgeInsets.all(5.0),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppStyles.buttonColor,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//           padding: EdgeInsets.all(15),
//           minimumSize: Size(60, 60),
//         ),
//         onPressed: onPressed,
//         child: Icon(icon, color: Colors.white, size: 30),
//       ),
//     );
//   }
// }



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
      // Get initial adapter state
      BluetoothAdapterState initialState = await _flutterBlue.adapterStateNow;

      // Listen for adapter state changes
      _adapterStateSubscription = _flutterBlue.adapterState.listen((state) {
        print("Bluetooth Adapter State: ${state.name}");
      });

      // Get bonded devices
      _bondedDevices = await _flutterBlue.getBondedDevices();
      setState(() {});
    } catch (e) {
      print("Bluetooth error: $e");
    }
  }

  Future<bool> selectDevice() async {
    bool deviceSelected = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select HC-05"),
          content: SingleChildScrollView(
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
        );
      },
    );

    return deviceSelected;
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      _connection = await _flutterBlue.connect(device.address);

      setState(() {
        _selectedDevice = device;
        _isConnected = true;
      });

      // Handle disconnection
      _connection!.onDisconnected = () {
        _cleanupConnection();
        print("Disconnected from ${device.name}");
      };

      print("Connected to ${device.name}");
    } catch (e) {
      print("Connection failed: $e");
      _cleanupConnection();
    }
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
      await _connection!.disconnect();
      _cleanupConnection();
      print("Disconnected");
    }
  }

  void sendCommand(String command) {
    if (_isConnected && _connection != null && _connection!.isConnected) {
      try {
        _connection!.write(Uint8List.fromList(command.codeUnits));
        print("Sent: $command");
      } catch (e) {
        print("Error sending command: $e");
        _cleanupConnection();
      }
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

extension on BluetoothConnection {
  set onDisconnected(Null Function() onDisconnected) {}

  disconnect() {}

  void write(Uint8List uint8list) {}
}

extension on FlutterBlueClassic {
  getBondedDevices() {}
}
