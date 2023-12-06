import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:healthtic/timerpage.dart';

class SliderPage extends StatefulWidget {
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  final List<TimerPage> _pages = [
    TimerPage(
      title: 'Time to eat mindfully',
      subtitle:
          "Eat slowly for ten minutes, rest for five, then finish your meal",
      duration: 10,
    ),
    TimerPage(
      title: 'Break Time',
      subtitle:
          "Take a five-minute break to check in on your level of fullness",
      duration: 7,
    ),
    TimerPage(
      title: 'Finish your meal',
      subtitle: "You can eat until you feel full",
      duration: 7,
      isLastPage: true,
    ),
  ];

  int _currentPage = 0;
  late CountDownController _controller;
  // ignore: unused_field
  late Timer _slideTimer;
  bool _isSoundEnabled = true;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _controller = CountDownController();
    _slideTimer = Timer(
        Duration(seconds: _pages[_currentPage].duration), moveToNextSlide);
    _audioPlayer = AudioPlayer();
  }

  void moveToNextSlide() {
    if (_currentPage < _pages.length - 1) {
      _slideTimer = Timer(Duration(seconds: _pages[_currentPage].duration), () {
        setState(() {
          _currentPage = (_currentPage + 1) % _pages.length;
          _slideTimer = Timer(Duration(seconds: _pages[_currentPage].duration),
              moveToNextSlide);
        });
      });
    }
  }

  void playTickSound() async {
    final player = AudioPlayer();

    await player.play('assets/countdown_tick.mp3', isLocal: true);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Widget buildIndicator(int index) {
    return Container(
      width: 10,
      height: 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.green : Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Mindful Meal Timer",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color.fromRGBO(52, 53, 65, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < _pages.length; i++) buildIndicator(i),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            _pages[_currentPage].title,
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60.0),
            child: Text(
              _pages[_currentPage].subtitle,
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20),
          TimerPage(
            title: _pages[_currentPage].title,
            subtitle: _pages[_currentPage].subtitle,
            duration: _pages[_currentPage].duration,
            isLastPage: _pages[_currentPage].isLastPage,
            controller: _controller,
            onTickSound: playTickSound,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sound',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Switch(
                value: _isSoundEnabled,
                onChanged: (value) {
                  setState(() {
                    _isSoundEnabled = value;
                  });
                },
                activeColor: Color.fromRGBO(75, 170, 88, 1),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
