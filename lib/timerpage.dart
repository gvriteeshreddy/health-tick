import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  final String title;
  final String subtitle;
  final int duration;
  final bool isLastPage;
 final CountDownController? controller;
  final VoidCallback? onTickSound;

  const TimerPage({
    required this.title,
    required this.subtitle,
    required this.duration,
    this.isLastPage = false,
    this.controller,
    this.onTickSound,
  });

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late CountDownController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? CountDownController();
    _controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 40),
          CircularCountDownTimer(
            duration: widget.duration,
            controller: _controller,
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 3,
            ringColor: Colors.grey[300]!,
            fillColor: Color.fromRGBO(75, 170, 88, 1),
            backgroundColor: Color.fromRGBO(52, 53, 65, 1),
            strokeWidth: 20.0,
            strokeCap: StrokeCap.round,
            textStyle: TextStyle(
              fontSize: 33.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textFormat: CountdownTextFormat.S,
            isReverse: true,
            isReverseAnimation: false,
            isTimerTextShown: true,
            autoStart: false, 
            onComplete: () {
              debugPrint('Countdown Ended');
              if (widget.isLastPage) {
                
              } else {
                
              }
            },
            onChange: (duration) {
              if (widget.onTickSound != null && duration == 5) {
                widget.onTickSound!();
              }
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _controller.start(); 
            },
            child: Text(
              "Start",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(75, 170, 88, 1),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              
            },
            child: Text(
              "Let's stop I am full",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromRGBO(75, 170, 88, 1),
            ),
          ),
          if (widget.isLastPage) SizedBox(height: 20),
        ],
      ),
    );
  }
}
