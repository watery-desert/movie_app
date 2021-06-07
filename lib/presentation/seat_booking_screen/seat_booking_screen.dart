import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../widget/app_bar/transparent_appbar.dart';
import '../../models/movie.dart';
import 'build_seats.dart';
import 'build_time_picker.dart';
import '../widget/button/movie_button.dart';
import '../check_out_screen/check_out_screen.dart';

TextStyle defaultTextStyle = TextStyle(color: Colors.white);

class SeatBookingScreen extends StatefulWidget {
  final Movie movie;
  SeatBookingScreen(this.movie);

  @override
  _SeatBookingScreenState createState() => _SeatBookingScreenState();
}

class _SeatBookingScreenState extends State<SeatBookingScreen> {
  late YoutubePlayerController _controller;
  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.movie.trailerURL);

    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
        loop: true,
        enableCaption: false,
        hideControls: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: DefaultTextStyle(
          style: defaultTextStyle,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                TransparentAppBar(
                  onTapLeading: () => Navigator.of(context).pop(),
                ),
                SizedBox(
                  height: 180,
                  child: YoutubePlayer(
                    controller: _controller,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),
                BuildSeats(),
                SizedBox(
                  height: 24.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Available',
                    ),
                    Text(
                      'Taken',
                    ),
                    Text(
                      'Selected',
                    ),
                  ],
                ),
                BuildDateTimePicker(),
                SizedBox(
                  height: 32,
                ),
                MovieButton(
                  padding: EdgeInsets.zero,
                  title: 'PAY',
                  onPressed: () {
                    Navigator.of(context).push(
                      CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => CheckOutScreen(),
                      ),
                    );
                  },
                  color: Colors.redAccent,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
