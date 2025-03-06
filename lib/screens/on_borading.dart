import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turkesh_marketer/screens/auth/login.dart';
import 'package:turkesh_marketer/screens/conta.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // index number
  int indexNum = 0;
  // ny list
  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/online-shopping.png",
      "text": "Welcome to Turkish Marketer"
    },
    {"image": "assets/images/shop.png", "text": "Grow Your Business"},
    {
      "image": "assets/images/trolley.png",
      "text": "Start Selling Now",
    },
  ];

  // my function
  void nextScreen() {
    setState(() {
      if (indexNum < onboardingData.length - 1) {
        indexNum++;
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // لون الخلفية الفاتح
      body: Column(
        children: [
          const SizedBox(height: 60),
          // الشعار
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: SvgPicture.asset(
                'assets/images/nlogo.svg',
                width: 100,
                height: 50,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // phone
          Container(
            width: 300,
            height: 400,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Colors.black,
              ),
              color: Colors.grey[400], //
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(onboardingData[indexNum]["image"]!),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    onboardingData[indexNum]["text"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          // my card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            decoration: const BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                // (Page Indicators)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(onboardingData.length,
                      (index) => buildDot(index == indexNum)),
                ),
                const SizedBox(height: 20),
                // title
                const Text(
                  "Welcome to Turkish Marketer",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "B2B e-Commerce you can trust",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                SizedBox(height: 20),
                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: MaterialButton(
                        minWidth: double.infinity,
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Conta()));
                        },
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        color: Colors.white,
                        child: const Text(
                          "Skip To Home Page",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: MaterialButton(
                        minWidth: double.infinity,
                        onPressed: nextScreen,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        color: Colors.blueGrey,
                        child: const Text(
                          "Next",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 12 : 8,
      height: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white70,
        shape: BoxShape.circle,
      ),
    );
  }
}
