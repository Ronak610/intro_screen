import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intro_scrren/Intro_Scrren/view/Intro_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:sizer/sizer.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final hasSeenIntro = await _hasSeenIntro();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(
        MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vibration Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/':(context)=>Intro_Page(),
          'intro':(context) => hasSeenIntro ?
          Home_Screen()
              : Intro_Screen(),


        },
    ));

}
Future<bool> _hasSeenIntro() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('has_seen_intro') ?? false;
}



class Intro_Screen extends StatefulWidget {
  const Intro_Screen({super.key});

  @override
  State<Intro_Screen> createState() => _Intro_ScreenState();
}

class _Intro_ScreenState extends State<Intro_Screen> with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int currentPage = 0;
  bool Skip_Button  = false;
 bool GetStart_Button = false;
 bool  Next_Button = false;
  late AnimationController _controller;


  List<Widget> _buildPageContent() {
    return [
      Image.asset("assets/Design/Screen_1/ic_sc2.png"),
      Image.asset("assets/Design/Screen_1/ic_sc3.png"),
      Image.asset("assets/Design/Screen_1/ic_sc4.png"),
    ];
  }

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page;
    });
  }

  Future<void> _onNext() async {
    if (currentPage < _buildPageContent().length - 1) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home_Screen(),
          ));
    }
  }

  Future<void> _onSkip() async {

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home_Screen(),
        ));
    await _setHasSeenIntro();
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  Future<void> _setHasSeenIntro() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_intro', true);
  }
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 150));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              children: _buildPageContent(),
            ),
  currentPage == _buildPageContent().length-1?Container(): Padding(
                padding:  EdgeInsets.only(bottom: 2.5.h),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_buildPageContent().length, (index) {
                      return AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        margin: EdgeInsets.symmetric(horizontal: 3),
                        height: 8,
                        width: currentPage == index ? 23 : 8,
                        decoration: BoxDecoration(
                          color:currentPage == index ?Colors.black : Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      );
                    }),
                  ),
                ),
              ),

            // Align(
            //   alignment: Alignment.bottomRight,
            //   child: Positioned(
            //     top: 5.h,
            //     right: 5.w,
            //     child: _currentPage == _buildPageContent().length
            //         ? Container()
            //         : TextButton(
            //       onPressed: _onNext,
            //       child: Text('Next',
            //           style:
            //           TextStyle(color: Colors.blue, fontSize: 16)),
            //     ),
            //   ),
            // ),
            // Align(
            //   alignment: Alignment.bottomLeft,
            //   child: Positioned(
            //     right: 5.w,
            //     child: _currentPage == _buildPageContent().length - 1
            //         ? Container()
            //         : TextButton(
            //       onPressed: _onSkip,
            //       child: Text('Skip',
            //           style:
            //           TextStyle(color: Colors.blue, fontSize: 16)),
            //     ),
            //   ),
            // ),
            currentPage == _buildPageContent().length-1?Container():Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding:  EdgeInsets.only(left: 6.w),
                  child: GestureDetector(
                    onTap: () {
                      _controller.forward();
                      Skip_Button = true;
                      Future.delayed(Duration(milliseconds: 200), () {
                        _controller.reverse();
                        Skip_Button = false;
                      });
                      print("Next");
                      _onSkip();
                    },
                    child: ScaleTransition(
                      scale: Tween<double>(
                        begin: .7,
                        end: .7,
                      ).animate(_controller),
                      child: SizedBox(
                        width: 8.5.h,
                        child: ElevatedButton(
                          onPressed: null,
                          child: Skip_Button == true
                              ? Image.asset(
                              "assets/Design/Screen_1/ic_skip_press.png")
                              : Image.asset(
                              "assets/Design/Screen_1/ic_skip.png"),
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: Colors.transparent,
                            disabledForegroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              currentPage == _buildPageContent().length-1?
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:  EdgeInsets.only(bottom: 1.h),
                  child: GestureDetector(
                    onTap: () {
                      _controller.forward();
                      GetStart_Button = true;
                      Future.delayed(Duration(milliseconds: 200), () {
                        _controller.reverse();
                        GetStart_Button = false;
                      });
                      print("Next");
                      _onSkip();
                    },
                    child: ScaleTransition(
                      scale: Tween<double>(
                        begin: .9,
                        end: .9,
                      ).animate(_controller),
                      child: SizedBox(
                        width: 15.h,
                        child: ElevatedButton(
                          onPressed: null,
                          child: GetStart_Button == true
                              ? Image.asset(
                              "assets/Design/Screen_1/ic_get_started_press.png")
                              : Image.asset(
                              "assets/Design/Screen_1/ic_get_started.png"),
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: Colors.transparent,
                            disabledForegroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ):Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding:  EdgeInsets.only(right: 6.w),
                  child: GestureDetector(
                    onTap: () {
                      _controller.forward();
                      Next_Button = true;
                      Future.delayed(Duration(milliseconds: 200), () {
                        _controller.reverse();
                        Next_Button = false;
                      });
                      print("Next");
                      _onNext();
                    },
                    child: ScaleTransition(
                      scale: Tween<double>(
                        begin: .7,
                        end: .7,
                      ).animate(_controller),
                      child: SizedBox(
                        width: 8.5.h,
                        child: ElevatedButton(
                          onPressed: null,
                          child: Next_Button == true
                              ? Image.asset(
                              "assets/Design/Screen_1/ic_next_press.png")
                              : Image.asset(
                              "assets/Design/Screen_1/ic_next.png"),
                          style: ElevatedButton.styleFrom(
                            disabledBackgroundColor: Colors.transparent,
                            disabledForegroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Padding(
            //       padding: EdgeInsets.only(bottom: 3.h),
            //       child: _currentPage == _buildPageContent().length
            //           ? Container()
            //           : InkWell(
            //           onTap: _onNext,
            //           child: Container(
            //             height: 6.h,
            //             width: 40.w,
            //             alignment: Alignment.center,
            //             decoration: BoxDecoration(
            //                 color: Colors.blue,
            //                 borderRadius: BorderRadius.circular(50)),
            //             child: Text("Next",
            //                 style: TextStyle(
            //                     color: Colors.white,
            //                     fontWeight: FontWeight.bold,
            //                     fontSize: 19)),
            //           ))),
            // ),
          ],
        ),
      ),
    );
  }
}

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

