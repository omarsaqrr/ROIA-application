import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:frontend/screens/register_check_email.dart';
import '../constants/colors.dart';
import '../themes/theme_default.dart'; // Ensure this file contains the color palette definitions

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()), // Navigate to OnboardingScreen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.asset(
            'assets/images/Splash_Screen.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'imagePath': 'assets/images/onboard2.jpg',
      'text': 'Welcome to\nWhere Investment Meets Vision',
      'buttonText': 'Next'
    },
    {
      'imagePath': 'assets/images/onBoard1.jpg',
      'text': 'Discover the best properties\nfor investment',
      'buttonText': 'Next'
    },
    {
      'imagePath': 'assets/images/onBoard3.jpg',
      'text': 'Start your journey\nwith us today!',
      'buttonText': 'Get Started!'
    },
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Precache the images
    _onboardingData.forEach((data) {
      precacheImage(AssetImage(data['imagePath']!), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: _onboardingData.length,
            itemBuilder: (context, index, realIndex) {
              final data = _onboardingData[index];
              return OnboardingPage(
                imagePath: data['imagePath']!,
                text: data['text']!,
                buttonText: data['buttonText']!,
                buttonAction: () {
                  if (index == _onboardingData.length - 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterCheckEmailScreen()), // Navigate to your desired screen
                    );
                  } else {
                    _carouselController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                isLast: index == _onboardingData.length - 1,
              );
            },
            options: CarouselOptions(
              height: double.infinity,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _onboardingData.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _carouselController.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == entry.key
                          ? paletteYellow
                          : Colors.grey,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_currentIndex == _onboardingData.length - 1) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterCheckEmailScreen()), // Navigate to your desired screen
                    );
                  } else {
                    _carouselController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Text(
                  _currentIndex == _onboardingData.length - 1
                      ? 'Get Started!'
                      : 'Next',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: paletteBlue,
                  backgroundColor: paletteYellow, // Text color
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String imagePath;
  final String text;
  final String buttonText;
  final VoidCallback buttonAction;
  final bool isLast;

  OnboardingPage({
    required this.imagePath,
    required this.text,
    required this.buttonText,
    required this.buttonAction,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        if (isLast)
          Positioned(
            top: 40,
            left: 20,
            child: Text(
              text,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: paletteYellow,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.left,
            ),
          )
        else
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                    color: paletteYellow,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
