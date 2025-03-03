import 'package:flutter/material.dart';
import 'package:graduation/InstructionPage.dart';
import 'package:graduation/app_styles.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'dart:typed_data';
import 'navBar.dart';

class ControllerPage extends StatefulWidget {
  @override
  _ControllerPageState createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {
  int _currentIndex = 2;
  BluetoothDevice? selectedDevice;
  BluetoothConnection? connection;
  bool isConnected = false; // Default selected index for the Controller screen

  // دالة اختيار الجهاز والاتصال به
  Future<bool> selectDevice() async {
    List<BluetoothDevice> devices =
        await FlutterBluetoothSerial.instance.getBondedDevices();
    bool deviceSelected = false;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select the bluetooth device"),
          content: SingleChildScrollView(
            child: Column(
              children: devices.map((device) {
                return ListTile(
                  title: Text(device.name ?? "unKnown"),
                  subtitle: Text(device.address),
                  onTap: () {
                    Navigator.pop(context);
                    connectToDevice(device);
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

  // دالة الاتصال بالجهاز
  void connectToDevice(BluetoothDevice device) async {
    try {
      BluetoothConnection connectionInstance =
          await BluetoothConnection.toAddress(device.address);
      setState(() {
        selectedDevice = device;
        connection = connectionInstance;
        isConnected = true;
      });
      print("Connected to ${device.name}");
    } catch (e) {
      print("Connection failed: $e");
    }
  }

  // دالة قطع الاتصال
  void disconnect() {
    connection?.close();
    setState(() {
      isConnected = false;
      selectedDevice = null;
    });
    print("Disconnected");
  }

  // إرسال الأوامر للعربة عبر البلوتوث
  void sendCommand(String command) {
    if (isConnected && connection != null) {
      connection!.output.add(Uint8List.fromList(command.codeUnits));
      connection!.output.allSent.then((_) => print("Sent: $command"));
    } else {
      print("Not connected to any device");
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
              // Updated Image
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
                        color: Colors.black, // Add appropriate color
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: AlignmentDirectional(1, -1),
                        child: Switch(
                          value: isConnected,
                          activeColor: Colors.orange,
                          onChanged: (bool value) async {
                            if (value) {
                              bool deviceSelected = await selectDevice();
                              if (!deviceSelected) {
                                setState(() {
                                  isConnected = false;
                                });
                              }
                            } else {
                              disconnect();
                            }
                          },
                        ),
                        //   Switch.adaptive(value: value, onChanged: onChanged),
                        // child: Switch.adaptive(
                        //   value: _model.switchValue!,
                        //   onChanged: (newValue) async {
                        //     safeSetState(() => _model.switchValue = newValue!);
                        //   },
                        //   activeColor: Color(0xFFDE5902),
                        //   activeTrackColor: Color(0xFFDE5902),
                        //   inactiveTrackColor: Colors.grey.shade300,
                        //   inactiveThumbColor: Colors.white,
                        // ),
                      ),
                    ),
                  ],
                ),
              ),
              if (selectedDevice != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Connected to: ${selectedDevice!.name}"),
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
        // // Arrow Buttons Layout (Cross Shape)
        // Column(
        //   children: [
        //     // Up Arrow
        //     _arrowButton(Icons.arrow_upward, () {
        //       print("Up pressed");
        //     }
        //     ),

        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         // Left Arrow
        //         _arrowButton(Icons.arrow_back, () {
        //           print("Left pressed");
        //         }),

        //         // Green Center Button (No action needed)
        //         Container(
        //           width: 60,
        //           height: 60,
        //           decoration: BoxDecoration(
        //             color: Colors.green,
        //             shape: BoxShape.circle,
        //           ),
        //         ),

        //         // Right Arrow
        //         _arrowButton(Icons.arrow_forward, () {
        //           print("Right pressed");
        //         }),
        //       ],
        //     ),

        //     // Down Arrow
        //     _arrowButton(Icons.arrow_downward, () {
        //       print("Down pressed");
        //     }),
        //   ],
        // ),
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
