import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class ShortVideoWidget extends StatefulWidget {
  final String videoURL;

  const ShortVideoWidget({
    super.key,
    required this.videoURL,
  });

  @override
  State<ShortVideoWidget> createState() => _ShortVideoWidgetState();
}

class _ShortVideoWidgetState extends State<ShortVideoWidget> {
  late VideoPlayerController _playerController;
  IconData _currentIcon = Icons.pause;
  double _iconOpacity = 0.0;

  @override
  void initState() {
    super.initState();
    _playerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoURL))
          ..initialize().then((value) {
            _playerController.setLooping(true);

            // 0.5초 후 비디오 재생
            Future.delayed(const Duration(milliseconds: 700), () {
              _playerController.play();
            });
          });
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  void _toggleVideo() {
    final wasPlaying = _playerController.value.isPlaying;
    setState(() {
      _currentIcon = wasPlaying ? Icons.pause : Icons.play_arrow;
      _iconOpacity = 1.0;
    });

    if (wasPlaying) {
      _playerController.pause();
    } else {
      _playerController.play();
    }

    // 애니메이션 처리
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() => _iconOpacity = 0.0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleVideo,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_playerController),
                  AnimatedOpacity(
                    opacity: _iconOpacity,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOutCirc,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _currentIcon,
                        color: Colors.white,
                        size: 50.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            VideoProgressIndicator(
              _playerController,
              allowScrubbing: true, // 스크럽 허용
              // padding: EdgeInsets.only(top: 5.0),
              colors: VideoProgressColors(
                playedColor: Colors.red, // 재생된 부분 색상
                bufferedColor: Colors.grey, // 버퍼링된 부분 색상
              ),
            ),
          ],
        ),
      ),
    );
  }
}
