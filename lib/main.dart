import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageSliderScreen(),
    );
  }
}

class ImageSliderScreen extends StatefulWidget {
  @override
  _ImageSliderScreenState createState() => _ImageSliderScreenState();
}

class _ImageSliderScreenState extends State<ImageSliderScreen> {
  final PageController _pageController = PageController();
  final List<String> images = [
    'assets/images/haechan.jpg',
    'assets/images/jay.jpg',
    'assets/images/mark.jpg',
  ];
  final List<String> captions = [
    'Haechan NCT',
    'Jay Enhypen',
    'Mark Lee NCT',
  ];
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < images.length - 1) {
      setState(() {
        _currentPage++;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Album'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 15,
                          offset: Offset(0, 5),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        images[index],
                        fit: BoxFit.cover,
                        height: 400,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    captions[index],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: 16,
            left: MediaQuery.of(context).size.width / 2 -
                (images.length * 15 / 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  height: 12,
                  width: _currentPage == index ? 24 : 12,
                  decoration: BoxDecoration(
                    color:
                        _currentPage == index ? Colors.deepPurple : Colors.grey,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: MediaQuery.of(context).size.height / 2 - 40,
            child: GestureDetector(
              onTap: _previousPage,
              child: CircleAvatar(
                backgroundColor: Colors.deepPurple.withOpacity(0.7),
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            right: 16,
            top: MediaQuery.of(context).size.height / 2 - 40,
            child: GestureDetector(
              onTap: _nextPage,
              child: CircleAvatar(
                backgroundColor: Colors.deepPurple.withOpacity(0.7),
                child: Icon(Icons.arrow_forward, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
