part of 'main.dart';

class _Carousel extends StatefulWidget {
  @override
  State<_Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<_Carousel> {
  late final Size size;
  final CarouselSliderController _controller = CarouselSliderController();
  int _current = 0;

  static final List<String> _imgList = [
    'https://img.kurio.network/iU_q9ETZ3iZ-w6SfPw80coAjVv8=/1200x675/filters:quality(80)/https://kurio-img.kurioapps.com/21/02/16/f247ea21-347b-47cd-b8fa-5bfdaf6a5855.jpe',
    'https://img.kurio.network/iU_q9ETZ3iZ-w6SfPw80coAjVv8=/1200x675/filters:quality(80)/https://kurio-img.kurioapps.com/21/02/16/f247ea21-347b-47cd-b8fa-5bfdaf6a5855.jpe',
    'https://img.kurio.network/iU_q9ETZ3iZ-w6SfPw80coAjVv8=/1200x675/filters:quality(80)/https://kurio-img.kurioapps.com/21/02/16/f247ea21-347b-47cd-b8fa-5bfdaf6a5855.jpe',
    'https://img.kurio.network/iU_q9ETZ3iZ-w6SfPw80coAjVv8=/1200x675/filters:quality(80)/https://kurio-img.kurioapps.com/21/02/16/f247ea21-347b-47cd-b8fa-5bfdaf6a5855.jpe',
    'https://img.kurio.network/iU_q9ETZ3iZ-w6SfPw80coAjVv8=/1200x675/filters:quality(80)/https://kurio-img.kurioapps.com/21/02/16/f247ea21-347b-47cd-b8fa-5bfdaf6a5855.jpe',
    'https://img.kurio.network/iU_q9ETZ3iZ-w6SfPw80coAjVv8=/1200x675/filters:quality(80)/https://kurio-img.kurioapps.com/21/02/16/f247ea21-347b-47cd-b8fa-5bfdaf6a5855.jpe'
  ];

  static final List<Widget> _imageSliders = _imgList
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
                SizedBox(height: 10),
                Text(
                  'Traditional Food',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'A scenic, inviting view of Lombok Island showcasing its natural beauty, such as a beach with turquoise water',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Container(
                  width: 95,
                  height: 20,
                  decoration: BoxDecoration(color: Color(0xffF15E3E), borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  child: Text('See Details', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ))
      .toList();

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
        children: <Widget>[
          CarouselSlider(
            items: _imageSliders,
            options: CarouselOptions(
                height: size.height * 0.45,
                aspectRatio: 2.0,
                viewportFraction: 0.33,
                enlargeCenterPage: true,
                autoPlay: true,
                onPageChanged: (index, reason) => setState(() => _current = index)),
            carouselController: _controller,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black)
                        .withOpacity(_current == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
