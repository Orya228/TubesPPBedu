import 'package:e_learning/styles/colors.dart';
import 'package:e_learning/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerExample extends StatefulWidget {
  final String? kelas;
  final String? Materi;
  const YoutubePlayerExample({Key? key, this.kelas, this.Materi})
      : super(key: key);

  @override
  State<YoutubePlayerExample> createState() => _YoutubePlayerExample();
}

class _YoutubePlayerExample extends State<YoutubePlayerExample> {
  final videoURL =
      "https://www.youtube.com/watch?v=nfvOSNVdaM8&pp=ygUhbWF0ZXJpIGtlbGFzIHNkIGt1cmlrdWx1bSBtZXJkZWth";

  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(videoURL);
    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Video ${widget.Materi}",
              style: kTitle2,
            ),
            Text(
              '${widget.kelas}',
              style: kSubtitle3,
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: kPutih,
        leading: GestureDetector(
          child: Image.asset('assets/icons/backbutton.png'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
            bottomActions: [
              CurrentPosition(),
              ProgressBar(
                isExpanded: true,
                colors: const ProgressBarColors(
                  playedColor: kBiru,
                  handleColor: kBiruMuda,
                ),
              ),
              const PlaybackSpeedButton(),
            ],
          )
        ],
      ),
    );
  }
}
