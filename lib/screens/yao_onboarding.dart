import 'package:belajar_onboarding/screens/yao_home.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

// data screen
final List<Map<String, String>> screenData = [
  {
    'title': 'Page 1',
    'subtitle':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore',
    'imgUrl':
        'https://images.unsplash.com/photo-1542451313056-b7c8e626645f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1527&q=80',
  },
  {
    'title': 'Page 2',
    'subtitle':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore',
    'imgUrl':
        'https://images.unsplash.com/photo-1542480118439-cbba7870f6f7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1588&q=80',
  },
  {
    'title': 'Page 3',
    'subtitle':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore',
    'imgUrl':
        'https://images.unsplash.com/photo-1542641734-3b824eaabad0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=435&q=80',
  },
];

class YaoOnboarding extends StatefulWidget {
  const YaoOnboarding({super.key});

  @override
  State<YaoOnboarding> createState() => _YaoOnboardingState();
}

class _YaoOnboardingState extends State<YaoOnboarding> {
  late int _currentPage = 0;
  int _lastIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _lastIndex = screenData.length - 1;
  }

  void nextPage() {
    if (_currentPage < _lastIndex) {
      _pageController.nextPage(
          duration: const Duration(seconds: 2), curve: Curves.ease);
    }
  }

  void lastPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const YaoHome(),
      ),
    );
  }

  void changePage(int page) {
    setState(() {
      _currentPage = page.toInt();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: changePage,
              itemCount: screenData.length,
              itemBuilder: (context, index) {
                var data = screenData[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(16.0),
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          data['imgUrl']!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      data['title']!,
                      style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Text(
                      data['subtitle']!,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    DotsIndicator(
                      dotsCount: screenData.length,
                      position: _currentPage,
                      decorator: DotsDecorator(
                        size: const Size.square(10),
                        activeSize: const Size(20, 10),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_currentPage == _lastIndex) {
                          lastPage();
                        } else {
                          nextPage();
                        }
                      },
                      child: Text(
                          (_currentPage == _lastIndex) ? 'Finish' : 'Next'),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
