import 'package:flutter/material.dart';
import '../ControllerPage.dart';
import '../app_styles.dart';

class InstructionPage extends StatefulWidget {
  @override
  _InstructionPageState createState() => _InstructionPageState();
}

class _InstructionPageState extends State<InstructionPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0; // Track current page for the indicator

  void _goToNextStep() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppStyles.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppStyles.buttonColor),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ControllerPage()),
            );
          },
        ),
        title:
            Text("Instruction", style: TextStyle(color: AppStyles.buttonColor)),
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
                // Step One
                InstructionStep(
                  stepTitle: "Step One",
                  imagePath: "assets/stepone.jpg",
                  description:
                      "Make sure that your Bluetooth is on to connect with the car.",
                  onNext: _goToNextStep,
                ),

                // Step Two
                InstructionStep(
                  stepTitle: "Step Two",
                  imagePath: "assets/steptwo.jpg",
                  description:
                      "Connect your phone to the car by pairing HC-05 then enter the password 1234",
                  onNext: _goToNextStep,
                ),

                // Step Three
                InstructionStep(
                  stepTitle: "Step Three",
                  imagePath: "assets/check.png",
                  description:
                      "Turn on the controller switch, select HC-05, and once the switch turns orange and the Bluetooth light stop glitching, your connection is successful",
                  onNext: _goToNextStep,
                ),

                // Step Four
               InstructionStep(
                  stepTitle: "Step Three",
                  imagePath:
                      "assets/shopping.png",
                  description: "We hope you have a wonderful shopping experience!",
                  onNext: () {
                    // Navigate to ControllerPage when clicking "Start Now"
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ControllerPage()),
                    );
                  },
                ),
              ],
            ),
          ),

          // Page Indicator (4 Dots)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == index ? 12 : 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? AppStyles.buttonColor
                      : Colors.grey,
                ),
              );
            }),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}

class InstructionStep extends StatelessWidget {
  final String stepTitle;
  final String imagePath;
  final String description;
  final VoidCallback onNext;

  const InstructionStep({
    required this.stepTitle,
    required this.imagePath,
    required this.description,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(stepTitle,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppStyles.buttonColor)),
          SizedBox(height: 20),
          Image.asset(imagePath, width: 150, height: 150,
              errorBuilder: (context, error, stackTrace) {
            return Icon(Icons.broken_image,
                size: 150,
                color: Colors.grey); // Fallback if image fails to load
          }),
          SizedBox(height: 20),
          Text(description,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54)),
          // SizedBox(height: 30),ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: AppStyles.buttonColor,
          //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          //     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          //   ),
          //   onPressed: onNext,
          //   child: Text("Start Now", style: TextStyle(color: Colors.white, fontSize: 16)),
          // ),
          
        ],
      ),
    );
  }
}
