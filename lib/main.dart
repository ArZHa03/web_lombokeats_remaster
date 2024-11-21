import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(_MyApp());
}

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveBreakpoints.builder(
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
        child: child!,
      ),
      theme: ThemeData(fontFamily: 'Montserrat'),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  @override
  State<_MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  final _imageLeading =
      'https://www.kemenparekraf.go.id/_next/image?url=https%3A%2F%2Fapi2.kemenparekraf.go.id%2Fstorage%2Fapp%2Fuploads%2Fpublic%2F621%2F437%2F6d3%2F6214376d3978f205929356.png&w=3840&q=75';
  late final Size size;

  final _secondaryColor = const Color(0xffF15E3E);
  final _pageController = PageController();

  int _currentIndex = 0;

  final Map<int, String> _listTitleAppBar = {
    0: 'Home',
    1: 'Gastronomy',
    2: 'Restaurant',
    3: 'Culture',
    4: 'Reference Village',
    5: 'About',
    6: 'Profile',
  };

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  void _changePage(int? index) {
    setState(() {
      if (index == 7 && index == 8) return;
      _currentIndex = index ?? 0;
      _pageController.jumpToPage(_currentIndex);
    });
  }

  void _changePageSearch() => setState(() => _currentIndex = 7);
  void _changePageDetailFood() => setState(() => _currentIndex = 8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: _changePage,
        children: [
          if (_currentIndex == 8)
            _detailFood()
          else if (_currentIndex == 7)
            _searchView()
          else ...[
            _homeView(),
            _gastronomyView(),
            _restaurantView(),
            _cultureView(),
            _referenceVillageView(),
            _aboutView(),
            _profileView(),
          ]
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Colors.black,
      leading: Image.network(_imageLeading),
      leadingWidth: 140,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: _titleAppBar()),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
      centerTitle: true,
      actions: _actionsAppBar(),
    );
  }

  List<Widget> _actionsAppBar() {
    return [
      GestureDetector(
        onTap: _changePageSearch,
        child: Container(
          width: size.width * 0.1,
          height: 50,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(color: _secondaryColor, borderRadius: BorderRadius.circular(30)),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.adf_scanner, color: Colors.white, size: size.width * 0.015),
              SizedBox(width: size.width * 0.0075),
              Text(
                'Scan Food',
                style: TextStyle(color: Colors.white, fontSize: size.width * 0.0085, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      )
    ];
  }

  List<Widget> _titleAppBar() {
    titleAppBarMobile() {
      return [
        DropdownButton<String>(
          value: _listTitleAppBar[_currentIndex],
          icon: Icon(Icons.arrow_drop_down, color: Colors.white),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.white),
          underline: Container(height: 0),
          onChanged: (String? newValue) {
            final index = _listTitleAppBar.entries.firstWhere((element) => element.value == newValue).key;
            _changePage(index);
          },
          items: _listTitleAppBar.values.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value,
                  style: TextStyle(color: value == _listTitleAppBar[_currentIndex] ? _secondaryColor : Colors.black)),
            );
          }).toList(),
        )
      ];
    }

    if (size.width < 450) return titleAppBarMobile();

    return [
      SizedBox(width: size.width * 0.1),
      _buildTitleAppBar(0),
      _buildTitleAppBar(1),
      _buildTitleAppBar(2),
      _buildTitleAppBar(3),
      _buildTitleAppBar(4),
      _buildTitleAppBar(5),
      _buildTitleAppBar(6),
      SizedBox(width: size.width * 0.1),
    ];
  }

  Widget _buildTitleAppBar(int index) {
    final title = _listTitleAppBar[index]!;
    final isEnable = _currentIndex == index && index != 7 && index != 8;

    return GestureDetector(
      onTap: () => _changePage(index),
      child: Column(
        children: [
          if (isEnable) SizedBox(height: kToolbarHeight - 35),
          Text(
            title,
            style: TextStyle(
              color: isEnable ? _secondaryColor : Colors.white,
              fontSize: size.width * 0.007,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (isEnable) SizedBox(height: kToolbarHeight - 40),
          if (isEnable)
            Container(width: (title.length * 5 + 55) - (size.width * 0.007), height: 2, color: _secondaryColor),
        ],
      ),
    );
  }

  Widget _homeView() {
    Widget welcomeLombokEats() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15, vertical: size.height * 0.1),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Gastronomy of Lombok\n',
                        style: TextStyle(
                            fontSize: size.height * 0.04, fontWeight: FontWeight.bold, color: _secondaryColor),
                        children: [
                          TextSpan(
                            text: 'Experience Extraordinary\nCulture Through Food',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "A scenic, inviting view of Lombok Island showcasing its natural beauty,\nsuch as a beach with turquoise water, lush greenery, and perhaps a\ntraditional Lombok boat in the foreground. This sets the tone for\nexploring Lombok's culture and culinary delights.",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: _changePageSearch,
                      child: Container(
                        width: 280,
                        height: 70,
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(color: _secondaryColor, borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.adf_scanner, color: Colors.white),
                            SizedBox(width: 5),
                            Text(
                              'Scan Food',
                              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                CircleAvatar(radius: size.width * 0.1, backgroundColor: Colors.grey),
              ],
            )
          ],
        ),
      );
    }

    Widget exploreLombok() {
      Widget adaDeh(String title) {
        return Column(
          children: [
            SizedBox(height: size.height * 0.01),
            Container(
              width: size.width * 0.26,
              padding: EdgeInsets.symmetric(
                vertical: size.height * 0.015,
                horizontal: size.width * 0.02,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Color(0xffE9E9E9)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(radius: size.width * 0.015, backgroundColor: Colors.grey),
                  SizedBox(width: size.width * 0.01),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontSize: size.width * 0.010, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Uncover the diverse range of\nfood and histories.',
                        style: TextStyle(fontSize: size.width * 0.006, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15, vertical: size.height * 0.1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: size.width * 0.3,
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Container(
                  width: size.width * 0.3,
                  height: size.height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Explore ',
                    style: TextStyle(fontSize: size.height * 0.04, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: 'Lombok\n', style: TextStyle(color: _secondaryColor)),
                      TextSpan(text: 'Gastronomy Treasures'),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                  "A scenic, inviting view of Lombok Island showcasing its\nnatural beauty, such as a beach with turquoise water, lush\ngreenery, and perhaps a traditional Lombok boat in the\nforeground. This sets the tone for exploring Lombok's\nculture and culinary delights.",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                adaDeh('Gastronomy'),
                adaDeh('Restaurant'),
                adaDeh('Culture'),
                adaDeh('Reference Village'),
              ],
            ),
          ],
        ),
      );
    }

    Widget lombokCulinaryBeforeLine() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15, vertical: size.height * 0.1),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Lombok’s Culinary &\nGastronomy Treasures',
                      style: TextStyle(fontSize: size.height * 0.04, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "A scenic, inviting view of Lombok Island showcasing its natural beauty,\nsuch as a beach with turquoise water, lush greenery, and perhaps a\ntraditional Lombok boat in the foreground. This sets the tone for\nexploring Lombok's culture and culinary delights.",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.white,
                                border: Border.all(color: Color(0xffE9E9E9)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.network(
                                      'https://img.kurio.network/iU_q9ETZ3iZ-w6SfPw80coAjVv8=/1200x675/filters:quality(80)/https://kurio-img.kurioapps.com/21/02/16/f247ea21-347b-47cd-b8fa-5bfdaf6a5855.jpe',
                                      fit: BoxFit.cover,
                                      width: size.width * 0.1,
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.003),
                                  Text(
                                    'Ayam Taliwang',
                                    style: TextStyle(fontSize: size.height * 0.015, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: size.height * 0.003),
                                  GestureDetector(
                                    onTap: _changePageDetailFood,
                                    child: Container(
                                      width: size.width * 0.05,
                                      height: size.height * 0.02,
                                      decoration: BoxDecoration(
                                        color: Color(0xffF15E3E),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text('See Details',
                                          style: TextStyle(color: Colors.white, fontSize: size.height * 0.0125)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: size.width * 0.005),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.white,
                                border: Border.all(color: Color(0xffE9E9E9)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.network(
                                      'https://img.kurio.network/iU_q9ETZ3iZ-w6SfPw80coAjVv8=/1200x675/filters:quality(80)/https://kurio-img.kurioapps.com/21/02/16/f247ea21-347b-47cd-b8fa-5bfdaf6a5855.jpe',
                                      fit: BoxFit.cover,
                                      width: size.width * 0.1,
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.003),
                                  Text(
                                    'Ayam Taliwang',
                                    style: TextStyle(fontSize: size.height * 0.015, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: size.height * 0.003),
                                  GestureDetector(
                                    onTap: _changePageDetailFood,
                                    child: Container(
                                      width: size.width * 0.05,
                                      height: size.height * 0.02,
                                      decoration: BoxDecoration(
                                        color: Color(0xffF15E3E),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text('See Details',
                                          style: TextStyle(color: Colors.white, fontSize: size.height * 0.0125)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: size.width * 0.005),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.white,
                                border: Border.all(color: Color(0xffE9E9E9)),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Image.network(
                                      'https://img.kurio.network/iU_q9ETZ3iZ-w6SfPw80coAjVv8=/1200x675/filters:quality(80)/https://kurio-img.kurioapps.com/21/02/16/f247ea21-347b-47cd-b8fa-5bfdaf6a5855.jpe',
                                      fit: BoxFit.cover,
                                      width: size.width * 0.1,
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.003),
                                  Text(
                                    'Ayam Taliwang',
                                    style: TextStyle(fontSize: size.height * 0.015, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: size.height * 0.003),
                                  GestureDetector(
                                    onTap: _changePageDetailFood,
                                    child: Container(
                                      width: size.width * 0.05,
                                      height: size.height * 0.02,
                                      decoration: BoxDecoration(
                                        color: Color(0xffF15E3E),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text('See Details',
                                          style: TextStyle(color: Colors.white, fontSize: size.height * 0.0125)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                CircleAvatar(radius: size.width * 0.1, backgroundColor: Colors.grey),
              ],
            )
          ],
        ),
      );
    }

    Widget line() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.1),
        child: Image.asset('assets/line.png', fit: BoxFit.contain),
      );
    }

    Widget lombokCulinaryAfterLine() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15, vertical: size.height * 0.1),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.3,
                  height: size.height * 0.215,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.grey,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Lombok’s Culinary &\nGastronomy Treasures',
                      style: TextStyle(fontSize: size.height * 0.04, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "A scenic, inviting view of Lombok Island showcasing its natural\nbeauty, such as a beach with turquoise water, lush greenery, and\nperhaps a traditional Lombok boat in the foreground. This sets\nthe tone for exploring Lombok's culture and culinary delights.",
                      style: TextStyle(fontSize: size.height * 0.015, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget artsAndDance() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15, vertical: size.height * 0.1),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                text: 'Traditional ',
                style: TextStyle(fontSize: size.height * 0.04, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(text: 'Arts & Dance', style: TextStyle(color: _secondaryColor)),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              "A scenic, inviting view of Lombok Island showcasing its natural beauty, such as a beach with turquoise water,\nlush greenery, and perhaps a traditional Lombok boat in the foreground. This sets the tone for exploring\nLombok's culture and culinary delights.",
              style: TextStyle(fontSize: size.height * 0.015, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.01),
            _carousel(),
          ],
        ),
      );
    }

    Widget specials() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15, vertical: size.height * 0.1),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                text: 'Traditional ',
                style: TextStyle(fontSize: size.height * 0.04, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(text: 'Specials', style: TextStyle(color: _secondaryColor)),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
                "A scenic, inviting view of Lombok Island showcasing its natural beauty, such as a beach with turquoise water,\nlush greenery, and perhaps a traditional Lombok boat in the foreground. This sets the tone for exploring\nLombok's culture and culinary delights.",
                style: TextStyle(fontSize: size.height * 0.015, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center),
            SizedBox(height: size.height * 0.01),
            _carousel(),
          ],
        ),
      );
    }

    Widget experienceLombok() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15, vertical: size.height * 0.1),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: size.width * 0.3,
                  height: size.height * 0.26,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.grey,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Experience ',
                        style: TextStyle(
                            fontSize: size.height * 0.04, fontWeight: FontWeight.bold, color: _secondaryColor),
                        children: [
                          TextSpan(
                              text: ' Lombok’s\nCulinary and Cultural\nJourney', style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "Gastronomy preserves cultural traditions by exploring the\nhistory behind each dish and its connections to regional\nidentity. Lombok's unique taste and presentation celebrate the\nisland's rich heritage and vreate unforgettable culinary\nmemories",
                      style: TextStyle(fontSize: size.height * 0.015, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      );
    }

    return ListView(
      children: [
        welcomeLombokEats(),
        exploreLombok(),
        lombokCulinaryBeforeLine(),
        line(),
        lombokCulinaryAfterLine(),
        artsAndDance(),
        specials(),
        experienceLombok(),
      ],
    );
  }

  Widget _gastronomyView() {
    Widget gastronomyLombok() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15, vertical: size.height * 0.1),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Gastronomy of Lombok\n',
                        style: TextStyle(
                            fontSize: size.height * 0.04, fontWeight: FontWeight.bold, color: _secondaryColor),
                        children: [
                          TextSpan(
                            text: 'Experience Extraordinary\nCulture Through Food',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      "A scenic, inviting view of Lombok Island showcasing its natural beauty,\nsuch as a beach with turquoise water, lush greenery, and perhaps a\ntraditional Lombok boat in the foreground. This sets the tone for\nexploring Lombok's culture and culinary delights.",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: _changePageSearch,
                      child: Container(
                        width: 280,
                        height: 70,
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(color: _secondaryColor, borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.adf_scanner, color: Colors.white),
                            SizedBox(width: 5),
                            Text(
                              'Scan Food',
                              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                CircleAvatar(radius: size.width * 0.1, backgroundColor: Colors.grey),
              ],
            )
          ],
        ),
      );
    }

    Widget culinaryStories() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15, vertical: size.height * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Culinary Stories to Savor',
                style: TextStyle(fontSize: size.height * 0.04, fontWeight: FontWeight.bold)),
            _carousel(),
          ],
        ),
      );
    }

    Widget line() {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.1),
        child: Image.asset('assets/line.png', fit: BoxFit.contain),
      );
    }

    Widget popularDishes() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15, vertical: size.height * 0.1),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                text: 'Most',
                style: TextStyle(fontSize: size.height * 0.04, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: ' Popular ',
                    style: TextStyle(color: _secondaryColor),
                  ),
                  TextSpan(text: 'Dishes')
                ],
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              "A scenic, inviting view of Lombok Island showcasing its natural beauty, such as a beach with turquoise water,\nlush greenery, and perhaps a traditional Lombok boat in the foreground. This sets the tone for exploring\nLombok's culture and culinary delights.",
              style: TextStyle(fontSize: size.height * 0.015, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.01),
            _carousel(),
          ],
        ),
      );
    }

    Widget culinarySpecials() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15, vertical: size.height * 0.1),
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                text: 'Culinary',
                style: TextStyle(fontSize: size.height * 0.04, fontWeight: FontWeight.bold, color: _secondaryColor),
                children: [TextSpan(text: ' Specials', style: TextStyle(color: Colors.black))],
              ),
            ),
            SizedBox(height: size.height * 0.01),
            Text(
              "A scenic, inviting view of Lombok Island showcasing its natural beauty, such as a beach with turquoise water,\nlush greenery, and perhaps a traditional Lombok boat in the foreground. This sets the tone for exploring\nLombok's culture and culinary delights.",
              style: TextStyle(fontSize: size.height * 0.015, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.01),
            _carousel(),
          ],
        ),
      );
    }

    Widget allGoods() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15, vertical: size.height * 0.1),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Good Food, Good Mood,\n',
                    style: TextStyle(fontSize: size.height * 0.04, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: 'Good Experience',
                        style: TextStyle(color: _secondaryColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.01),
                Text(
                    "Gastronomy preserves cultural traditions by exploring the history\nbehind each dish and its connections to regional identity.\nLombok's unique taste and presentation celebrate the island's rich\nheritage and vreate unforgettable culinary memories",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                'https://img.kurio.network/iU_q9ETZ3iZ-w6SfPw80coAjVv8=/1200x675/filters:quality(80)/https://kurio-img.kurioapps.com/21/02/16/f247ea21-347b-47cd-b8fa-5bfdaf6a5855.jpe',
                fit: BoxFit.cover,
                height: 200,
                width: 450,
              ),
            )
          ],
        ),
      );
    }

    return ListView(
      children: [
        gastronomyLombok(),
        culinaryStories(),
        line(),
        popularDishes(),
        culinarySpecials(),
        allGoods(),
      ],
    );
  }

  Widget _restaurantView() {
    return Container(color: Colors.blue);
  }

  Widget _cultureView() {
    return Container(color: Colors.yellow);
  }

  Widget _imageOthers({bool onlyImage = false, int item = 6, double ratio = 1.5}) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: item,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: ratio,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      padding: onlyImage ? null : EdgeInsets.symmetric(horizontal: size.width * 0.15),
      itemBuilder: (context, index) {
        return onlyImage
            ? ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  'https://bilebante.com/wp-content/uploads/2022/11/IMG_20210315_202201_642-rotated-e1669296694727.jpg',
                  fit: BoxFit.cover,
                ),
              )
            : GestureDetector(
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(
                        'https://bilebante.com/wp-content/uploads/2022/11/IMG_20210315_202201_642-rotated-e1669296694727.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [Color.fromARGB(255, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                          begin: Alignment.bottomCenter,
                          end: Alignment.center,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Spacer(),
                          Text(
                            'Desa Bilebante',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                          Text(
                            'Bilebante Village, located in Central Lombok, West Nusa Tenggara, is known as the "Green Tourism Village.',
                            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }

  Widget _referenceVillageView() {
    Widget nusaTenggara() {
      return Container(
        alignment: Alignment.center,
        height: size.height * 0.5,
        margin: EdgeInsets.only(bottom: size.height * 0.05),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://salutbali.com/wp-content/uploads/2024/03/Santai-di-Pantai-Senggigi.webp'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
          ),
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Explore Exciting Destinations\nShrouded ',
            style: TextStyle(fontSize: size.height * 0.04, fontWeight: FontWeight.bold, color: Colors.white),
            children: [TextSpan(text: 'Nusa Tenggara', style: TextStyle(color: _secondaryColor))],
          ),
        ),
      );
    }

    Widget wonderfulVillage() {
      return Padding(
        padding: EdgeInsets.only(bottom: size.height * 0.1),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.045),
              child: RichText(
                  text: TextSpan(
                      text: 'Find Wonderful ',
                      style: TextStyle(fontSize: size.height * 0.04, fontWeight: FontWeight.bold),
                      children: [TextSpan(text: 'Village', style: TextStyle(color: _secondaryColor))])),
            ),
            _imageOthers(),
          ],
        ),
      );
    }

    return ListView(
      children: [
        nusaTenggara(),
        wonderfulVillage(),
      ],
    );
  }

  Widget _aboutView() {
    return Container(color: Colors.orange);
  }

  Widget _profileView() {
    return Container(color: Colors.pink);
  }

  Widget _searchView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.15, vertical: size.height * 0.1),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(radius: size.width * 0.1, backgroundColor: Colors.grey),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Scan your Food',
                    style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold, color: _secondaryColor),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    "Take a picture or upload your image locally\nfrom your device to search what food it is.",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 280,
                        height: 70,
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(color: _secondaryColor, borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.camera_alt_outlined, color: Colors.white, size: 45),
                            SizedBox(width: 5),
                            Text(
                              'Camera',
                              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20),
                      Container(
                        width: 280,
                        height: 70,
                        margin: EdgeInsets.only(top: 20),
                        decoration: BoxDecoration(color: _secondaryColor, borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.photo, color: Colors.white, size: 45),
                            SizedBox(width: 5),
                            Text(
                              'Upload',
                              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.01),
                  Text(
                    'Image Upload Guidelines\n • Make sure the image of Lombok speciality food so that the system can\n   recognise it accurately.\n • Maximum file size is 20MB with JPEG or PNG format.\n • Use good quality images so that the food is clearly visible.\n\n',
                    style: TextStyle(fontSize: 12, color: Color(0xff5B5B5B)),
                  ),
                  Text(
                    'Notes: Uploading unsuitable images may cause processing errors.',
                    style: TextStyle(fontSize: 12, color: Color(0xff5B5B5B), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _carousel() {
    final CarouselSliderController controller = CarouselSliderController();
    int current = 0;

    final List<String> imgList = [
      'https://img.kurio.network/iU_q9ETZ3iZ-w6SfPw80coAjVv8=/1200x675/filters:quality(80)/https://kurio-img.kurioapps.com/21/02/16/f247ea21-347b-47cd-b8fa-5bfdaf6a5855.jpe',
      'https://img.kurio.network/iU_q9ETZ3iZ-w6SfPw80coAjVv8=/1200x675/filters:quality(80)/https://kurio-img.kurioapps.com/21/02/16/f247ea21-347b-47cd-b8fa-5bfdaf6a5855.jpe',
      'https://img.kurio.network/iU_q9ETZ3iZ-w6SfPw80coAjVv8=/1200x675/filters:quality(80)/https://kurio-img.kurioapps.com/21/02/16/f247ea21-347b-47cd-b8fa-5bfdaf6a5855.jpe',
      'https://img.kurio.network/iU_q9ETZ3iZ-w6SfPw80coAjVv8=/1200x675/filters:quality(80)/https://kurio-img.kurioapps.com/21/02/16/f247ea21-347b-47cd-b8fa-5bfdaf6a5855.jpe',
      'https://img.kurio.network/iU_q9ETZ3iZ-w6SfPw80coAjVv8=/1200x675/filters:quality(80)/https://kurio-img.kurioapps.com/21/02/16/f247ea21-347b-47cd-b8fa-5bfdaf6a5855.jpe',
      'https://img.kurio.network/iU_q9ETZ3iZ-w6SfPw80coAjVv8=/1200x675/filters:quality(80)/https://kurio-img.kurioapps.com/21/02/16/f247ea21-347b-47cd-b8fa-5bfdaf6a5855.jpe'
    ];

    List<Widget> imageSliders() {
      return imgList
          .map((item) => Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                  border: Border.all(color: Color(0xffE9E9E9)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.network(item, fit: BoxFit.cover),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      'Traditional Food',
                      style: TextStyle(fontSize: size.height * 0.024, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      'A scenic, inviting view of Lombok Island showcasing its natural beauty, such as a beach with turquoise water',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: size.height * 0.014),
                    ),
                    SizedBox(height: size.height * 0.01),
                    GestureDetector(
                      onTap: _changePageDetailFood,
                      child: Container(
                        width: 95,
                        height: size.height * 0.02,
                        decoration: BoxDecoration(color: Color(0xffF15E3E), borderRadius: BorderRadius.circular(20)),
                        alignment: Alignment.center,
                        child:
                            Text('See Details', style: TextStyle(color: Colors.white, fontSize: size.height * 0.0125)),
                      ),
                    ),
                  ],
                ),
              ))
          .toList();
    }

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 358),
            blurRadius: 100,
            color: Color(0x00000000).withOpacity(0.00),
          ),
          BoxShadow(
            offset: Offset(0, 229),
            blurRadius: 92,
            color: Color(0x00000000).withOpacity(0.01),
          ),
          BoxShadow(
            offset: Offset(0, 129),
            blurRadius: 77,
            color: Color(0x00000000).withOpacity(0.03),
          ),
          BoxShadow(
            offset: Offset(0, 57),
            blurRadius: 57,
            color: Color(0x00000000).withOpacity(0.04),
          ),
          BoxShadow(
            offset: Offset(0, 14),
            blurRadius: 31,
            color: Color(0x00000000).withOpacity(0.05),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CarouselSlider(
            items: imageSliders(),
            options: CarouselOptions(
                height: size.height * 0.45,
                aspectRatio: 2.0,
                viewportFraction: 0.33,
                enlargeCenterPage: true,
                autoPlay: true,
                onPageChanged: (index, reason) => setState(() => current = index)),
            carouselController: controller,
          ),
          SizedBox(height: size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                        .withOpacity(current == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _imageWithPlay({double? width, double? height}) {
    return Container(
      height: height ?? size.height * 0.5,
      width: width ?? size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          image: NetworkImage(
              'https://bilebante.com/wp-content/uploads/2022/11/IMG_20210315_202201_642-rotated-e1669296694727.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.play_arrow_rounded, color: Colors.black, size: width ?? size.width * 0.1),
        ),
      ),
    );
  }

  Widget _detailFood() {
    Widget traditionalFood() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.005, horizontal: size.width * 0.01),
            decoration: BoxDecoration(
              color: Color(0xffEAEAEA),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Traditional Food',
              style: TextStyle(fontSize: size.width * 0.0175, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            'Plecing Kangkung',
            style: TextStyle(fontSize: size.width * 0.035, fontWeight: FontWeight.bold, color: _secondaryColor),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            "Plecing Kangkung is a traditional dish from Lombok made with fresh water\nspinach (kangkung) that is boiled and served with a spicy sambal. The sambal\ntypically consists of red chilies, tomatoes, shrimp paste, garlic, and lime, giving it a\nspicy, savory, and refreshing flavor. Plecing Kangkung is often served as a side dish\nalongside traditional Lombok dishes like Ayam Taliwang and is considered one of\nthe region's iconic culinary delights.",
            style: TextStyle(fontSize: size.width * 0.015, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.05),
          _imageWithPlay(),
        ],
      );
    }

    Widget photoGallery() {
      return Column(
        children: [
          Text('Photo Gallery', style: TextStyle(fontSize: size.width * 0.02, fontWeight: FontWeight.bold)),
          SizedBox(height: size.height * 0.01),
          _imageOthers(onlyImage: true),
        ],
      );
    }

    Widget nutritionFood() {
      return Column(
        children: [
          Text('Nutrition Food', style: TextStyle(fontSize: size.width * 0.02, fontWeight: FontWeight.bold)),
          SizedBox(height: size.height * 0.01),
          Text(
            'Bilebante Village, known as the "Green Village," is located in Central Lombok, West\nNusa Tenggara. This village offers the charm of eco-tourism with expanses of rice\nfields, fresh air, and activities such as cycling, traditional cuisine, and homestays.\nSuitable for tourists looking for tranquility and local cultural experiences.',
            style: TextStyle(fontSize: size.width * 0.01, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.03),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: size.width * 0.3,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Color(0xff989898).withOpacity(0.6)),
                ),
                child: Column(
                  children: [
                    Text(
                      'Ingredients',
                      style: TextStyle(fontSize: size.width * 0.015, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      'Main Ingredients:',
                      style: TextStyle(fontSize: size.width * 0.00725, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      'Water spinach (kangkung) - 2\nbunches, trimmed and cleaned.\nBean sprouts (optional) - 50\ngrams, cleaned.\nGrated coconut (optional) - 50 grams,\nsteamed lightly (for added savory flavor).',
                      style: TextStyle(fontSize: size.width * 0.00925, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width * 0.3,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: Color(0xff989898).withOpacity(0.6)),
                ),
                child: Column(
                  children: [
                    Text(
                      'Directions',
                      style: TextStyle(fontSize: size.width * 0.015, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      'Preparation Steps for Plecing Kangkung',
                      style: TextStyle(fontSize: size.width * 0.00725, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Text(
                      'Water spinach (kangkung) - 2\nbunches, trimmed and cleaned.\nBean sprouts (optional) - 50\ngrams, cleaned.\nGrated coconut (optional) - 50 grams,\nsteamed lightly (for added savory flavor).',
                      style: TextStyle(fontSize: size.width * 0.00925, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }

    Widget historyFood() {
      return Column(
        children: [
          Text(
            'History of Food',
            style: TextStyle(fontSize: size.width * 0.015, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: size.height * 0.01),
          Text(
            'Bilebante Village, known as the "Green Village," is located in Central Lombok, West\nNusa Tenggara. This village offers the charm of eco-tourism with expanses of rice\nfields, fresh air, and activities such as cycling, traditional cuisine, and homestays.\nSuitable for tourists looking for tranquility and local cultural experiences.',
            style: TextStyle(fontSize: size.width * 0.01, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.03),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: _imageOthers(onlyImage: true, item: 3, ratio: 2.125),
          ),
        ],
      );
    }

    return ListView(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.1, horizontal: size.width * 0.15),
      children: [
        traditionalFood(),
        SizedBox(height: size.height * 0.05),
        photoGallery(),
        SizedBox(height: size.height * 0.05),
        nutritionFood(),
        SizedBox(height: size.height * 0.05),
        historyFood(),
      ],
    );
  }
}
