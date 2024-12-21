import 'package:assignment/screens/Moviedetailpage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List onBoard = [
    {"image": 'assets/images/indorehp.png'},
    {"image": 'assets/images/indorehp1.png'},
    {"image": 'assets/images/indorehp2.png'},
  ];
  String? citynam;

  @override
  void initState() {
    super.initState();
    _loadCityName(); // Load city name when the widget initializes
  }

  PageController pageController = PageController();
  int currentPage = 0;

  onChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  Future<void> _loadCityName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      citynam = prefs.getString('cityname') ?? "Indore"; // Provide a default value
    });
  }
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Icon(Icons.location_on, color: Colors.black),
        title: Text(citynam!, style: TextStyle(color: Colors.black,fontSize: 19)),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 890,
          child: Stack(
            children: [
              PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: pageController,
                itemCount: onBoard.length,
                onPageChanged: onChanged,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.08,
                          vertical: screenHeight * 0.01,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: Image.asset(
                              onBoard[index]["image"],
                              fit: BoxFit.cover,
                              height: screenHeight * 0.21,
                              width: screenWidth * 0.88,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                    onBoard.length,
                        (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: screenHeight * 0.007,
                        width: screenWidth * 0.04,
                        margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.013),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: (index == currentPage) ? Colors.blueGrey : Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.26, left: screenWidth * 0.05),
                child: Row(
                  children: [
                    Text(
                      "Popular Movies",
                      style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        size: screenWidth * 0.07,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.31),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildMovieCard(
                          context, screenWidth, screenHeight, 'assets/images/harry.jpg'),
                      buildMovieCard(
                          context, screenWidth, screenHeight, 'assets/images/pushpa2.jpg'),
                      buildMovieCard(
                          context, screenWidth, screenHeight, 'assets/images/avengers.jpg'),
                      buildMovieCard(
                          context, screenWidth, screenHeight, 'assets/images/babyjohn.jpeg'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.54, left: screenWidth * 0.05),
                child: Row(
                  children: [
                    Text(
                      "Latest Movies",
                      style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        size: screenWidth * 0.07,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.59),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildMovieCard(
                          context, screenWidth, screenHeight, 'assets/images/harry.jpg'),
                      buildMovieCard(
                          context, screenWidth, screenHeight, 'assets/images/pushpa2.jpg'),
                      buildMovieCard(
                          context, screenWidth, screenHeight, 'assets/images/avengers.jpg'),
                      buildMovieCard(
                          context, screenWidth, screenHeight, 'assets/images/babyjohn.jpeg'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: screenHeight * 0.82, left: screenWidth * 0.05),
                child: Row(
                  children: [
                    Text(
                      "Upcoming Eventss",
                      style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(
                        Icons.arrow_forward,
                        size: screenWidth * 0.07,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.86),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      buildRecommendationCard(
                          context, screenWidth, screenHeight, 'assets/images/indorehp.png'),
                      buildRecommendationCard(
                          context, screenWidth, screenHeight, 'assets/images/indorehp1.png'),
                      SizedBox(width: screenWidth*0.01,)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMovieCard(BuildContext context, double screenWidth, double screenHeight, String imagePath) {
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.08,
        top: screenHeight * 0.02,
        bottom: screenHeight * 0.02,
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 4,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              width: screenWidth * 0.3,
              height: screenHeight * 0.2,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRecommendationCard(BuildContext context, double screenWidth, double screenHeight, String imagePath) {
    return Padding(
      padding: EdgeInsets.only(
        top: screenHeight * 0.02,
        left: screenWidth * 0.08,
      ),
      child:Container(
        width: screenWidth * 0.7,
        height: screenHeight*0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),

        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Image.asset(
            imagePath
          ),
        ),
      ),

    );
  }
}
