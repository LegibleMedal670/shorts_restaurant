import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShortFormWidget extends StatefulWidget {
  final String storeName;
  final String videoURL;
  final String storeProfileImage;
  final String storeCaption;
  final String storeLocation;
  final int bookmarkAmount;
  final int shareAmount;
  final int reviewAmount;

  const ShortFormWidget({
    required this.storeName,
    required this.videoURL,
    required this.storeProfileImage,
    required this.storeCaption,
    required this.storeLocation,
    required this.bookmarkAmount,
    required this.shareAmount,
    required this.reviewAmount,
    super.key,
  });

  @override
  State<ShortFormWidget> createState() => _ShortFormWidgetState();
}

class _ShortFormWidgetState extends State<ShortFormWidget> {
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
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: (){
            _toggleVideo();
          },
          onDoubleTap: () {
            print('doubletap');
          },
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
                  padding: EdgeInsets.zero,
                  allowScrubbing: true, // 스크럽 허용
                  colors: const VideoProgressColors(
                      playedColor: Color.fromRGBO(220, 20, 60, 1), // 재생된 부분 색상
                      bufferedColor: Colors.grey, // 버퍼링된 부분 색상
                      backgroundColor: Colors.grey
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded)
          GestureDetector(
            onTap: (){
              setState(() {
                _isExpanded = false;
              });
            },
            child: Container(
              // color: Colors.black.withOpacity(0.2),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2), // 상단은 투명
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.4), // 중간은 약간 어두움
                    Colors.black.withOpacity(0.6), // 하단은 더 어두움
                  ],
                ),
              ),// 어두운 투명 레이어
            ),
          ),
        Positioned(
          top: 55,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 35,
                  ),
                  onPressed: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 15,
          bottom: 65,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ItemButton(
                icon: Icons.bookmark_outline,
                amount: widget.bookmarkAmount,
              ),
              ItemButton(
                icon: Icons.comment,
                amount: widget.reviewAmount,
              ),
              ItemButton(
                icon: CupertinoIcons.reply,
                amount: widget.shareAmount,
              ),
            ],
          ),
        ),
        Positioned(
          left: 25,
          bottom: 70,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      // backgroundImage: NetworkImage('https://img.freepik.com/free-photo/handsome-man-smiling-happy-face-portrait-close-up_53876-145493.jpg')
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.storeName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        showInfoModal(context);
                      },
                      child: Container(
                        width: 60,
                        height: 30,
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                        child: Center(
                          child: Text(
                            'More',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border:
                                Border.all(width: 0.5, color: Colors.white)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                    onTap: () => setState(() {
                          _isExpanded = !_isExpanded;
                        }),
                    child: AnimatedContainer(
                      padding: EdgeInsets.only(top: _isExpanded ? 5 : 0),

                      constraints: BoxConstraints(
                        maxHeight: _isExpanded ? MediaQuery.of(context).size.height * (320 / 812) : 19,
                        minHeight: _isExpanded ? MediaQuery.of(context).size.height * (100 / 812) : 19,
                      ),
                      duration: const Duration(milliseconds: 200),
                      child: _isExpanded
                          ? SingleChildScrollView(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                color: Colors.transparent,
                                child: Text(
                                  widget.storeCaption,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white,),
                                ),
                              ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              color: Colors.transparent,
                              child: Text(
                                widget.storeCaption,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white,),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                    )),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 150,
                  height: 41,
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.pin_drop_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'Los Angeles',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(width: 0.5, color: Colors.white)),
                ),
                Container(
                  width: 150,
                  height: 41,
                  padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.restaurant_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'Food:Burgers',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(width: 0.5, color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showLocationModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        builder: (BuildContext context) {
          return Container();
        });
  }

  void showInfoModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      showDragHandle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
            maxChildSize: 0.9,
            initialChildSize: 0.4,
            minChildSize: 0.3999,
            expand: false,
            snap: true,
            snapSizes: const [0.4, 0.9],
            builder: (context, scrollController) => SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    // physics: const ClampingScrollPhysics(),
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.storeName,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                '음식점유형',
                                style: TextStyle(color: Colors.black54),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                '거리',
                                style: TextStyle(color: Colors.black54),
                              ),
                              Spacer(),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Colors.black, width: 0.5)),
                                child: Text('북마크'),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.28,
                                height:
                                    MediaQuery.of(context).size.width * 0.28,
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.28,
                                height:
                                    MediaQuery.of(context).size.width * 0.28,
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.28,
                                height:
                                    MediaQuery.of(context).size.width * 0.28,
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ));
      },
    );
  }

  Widget ItemButton({IconData icon = Icons.bookmark, int? amount}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        children: [
          Icon(
            icon,
            size: 40,
            color: Colors.white,
          ),
          SizedBox(
            height: 5,
          ),
          (amount != null)
              ? Text(
                  amount.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}
