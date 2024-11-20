import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

part 'carousel.dart';

void main() => runApp(_MyApp());

class _MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
    7: 'Search',
  };

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  void _changePage(int? index) {
    setState(() {
      if (index == 7) return;
      _currentIndex = index ?? 0;
      _pageController.jumpToPage(_currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: _changePage,
        children: [
          if (_currentIndex != 7) ...[
            _homeView(),
            _gastronomyView(),
            _restaurantView(),
            _cultureView(),
            _referenceVillageView(),
            _aboutView(),
            _profileView(),
          ] else
            _searchView()
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
        onTap: () => setState(() => _currentIndex = 7),
        child: Container(
          width: 185,
          height: 50,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(color: _secondaryColor, borderRadius: BorderRadius.circular(30)),
          alignment: Alignment.center,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.adf_scanner, color: Colors.white),
              SizedBox(width: 5),
              Text('Scan Food', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      )
    ];
  }

  List<Widget> _titleAppBar() {
    return [
      SizedBox(width: size.width * 0.2),
      _buildTitleAppBar(0),
      _buildTitleAppBar(1),
      _buildTitleAppBar(2),
      _buildTitleAppBar(3),
      _buildTitleAppBar(4),
      _buildTitleAppBar(5),
      _buildTitleAppBar(6),
      SizedBox(width: size.width * 0.2),
    ];
  }

  Widget _buildTitleAppBar(int index) {
    final title = _listTitleAppBar[index]!;
    final isEnable = _currentIndex == index && index != 7;

    return GestureDetector(
      onTap: () => _changePage(index),
      child: Column(
        children: [
          if (isEnable) SizedBox(height: kToolbarHeight - 35),
          Text(title),
          if (isEnable) SizedBox(height: kToolbarHeight - 40),
          if (isEnable) Container(width: title.length * 5 + 55, height: 2, color: _secondaryColor),
        ],
      ),
    );
  }

  Widget _homeView() {
    return Container(color: Colors.red);
  }

  Widget _gastronomyView() {
    Widget gastronomyLombok() {
      return Container(
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
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: _secondaryColor),
                        children: [
                          TextSpan(
                            text: 'Experience Extraordinary\nCulture Through Food',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "A scenic, inviting view of Lombok Island showcasing its natural beauty,\nsuch as a beach with turquoise water, lush greenery, and perhaps a\ntraditional Lombok boat in the foreground. This sets the tone for\nexploring Lombok's culture and culinary delights.",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
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
                          Icon(Icons.adf_scanner, color: Colors.white),
                          SizedBox(width: 5),
                          Text(
                            'Scan Food',
                            style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ],
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
      return Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15, vertical: size.height * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Culinary Stories to Savor', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            _Carousel(),
          ],
        ),
      );
    }

    Widget line() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: size.height * 0.1),
        child: Image.asset('assets/line.png', fit: BoxFit.contain),
      );
    }

    Widget popularDishes() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15, vertical: size.height * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'Most',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                    text: ' Popular ',
                    style: TextStyle(color: _secondaryColor),
                  ),
                  TextSpan(text: 'Dishes')
                ],
              ),
            ),
            _Carousel(),
          ],
        ),
      );
    }

    Widget culinarySpecials() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.15, vertical: size.height * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'Culinary',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: _secondaryColor),
                children: [
                  TextSpan(text: ' Specials', style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
                'Sample authentic Lombok dishes like Beberuk Terong, Sate Pusut,\nPlecing Kangkung, Ayam Taliwang and Sate Rembiga - each offering a\ntaste of local tradition and cultural heritage.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            _Carousel(),
          ],
        ),
      );
    }

    Widget allGoods() {
      return Container(
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
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: 'Good Experience',
                        style: TextStyle(color: _secondaryColor),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
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
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white),
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
                      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      children: [TextSpan(text: 'Village', style: TextStyle(color: _secondaryColor))])),
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 6,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.15),
              itemBuilder: (context, index) {
                return Stack(
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
                );
              },
            ),
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
    return Container(
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
                  SizedBox(height: 20),
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
                  SizedBox(height: 20),
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
}
