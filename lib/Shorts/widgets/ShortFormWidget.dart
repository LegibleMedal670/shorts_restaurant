import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shorts_restaurant/Shorts/pages/SorryPage.dart';
import 'package:shorts_restaurant/Shorts/widgets/ShimmerWidget.dart';
import 'package:video_player/video_player.dart';
import 'dart:js' as js;

class ShortFormWidget extends StatefulWidget {
  final String storeName;
  final String videoURL;
  final String storeCaption;
  final String storeLocation;
  final double viewCount;
  final String sourceURL;
  final String openTime;
  final String closeTime;
  final double rating;
  final String category;
  final String uid;
  final int index;
  final String browserName;

  const ShortFormWidget({
    required this.storeName,
    required this.videoURL,
    required this.storeCaption,
    required this.storeLocation,
    required this.viewCount,
    required this.sourceURL,
    required this.openTime,
    required this.closeTime,
    required this.rating,
    required this.category,
    required this.uid,
    required this.index,
    required this.browserName,
    super.key,
  });

  @override
  State<ShortFormWidget> createState() => _ShortFormWidgetState();
}

class _ShortFormWidgetState extends State<ShortFormWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  late VideoPlayerController _playerController;
  IconData _currentIcon = Icons.pause;
  double _iconOpacity = 0.0;
  String platformIcon = 'images/Instagram_icon.png';
  IconData restaurantCategory = Icons.restaurant_outlined;
  bool _isExpanded = false;
  bool _volumeOn = false;

  @override
  void initState() {
    super.initState();

    ///url감지해서 사진 정하는데 지금은 인스타그램만 있어서 주석처리
    // detectPlatformFromUrl(widget.sourceURL);
    getRestaurantCategory(widget.category);
    _playerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoURL))
          ..initialize().then((value) {
            _playerController.setLooping(true);

            if(widget.browserName == 'BrowserName.safari'){
              _playerController.setVolume(0);
            } else {
              if (widget.index == 0) _playerController.setVolume(0);
            }

            // Future.delayed(const Duration(milliseconds: 500), () {
            //   _playerController.play();
            // });

            _playerController.play();

            // // 0.5초 후 비디오 재생
            // if (widget.index == 1) {
            //   Future.delayed(const Duration(milliseconds: 500), () {
            //     _playerController.play();
            //   });
            // } else {
            //   Future.delayed(const Duration(milliseconds: 700), () {
            //     _playerController.play();
            //   });
            // }
          });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 700), () {
        showModal(widget.index);
      });
    });
  }

  @override
  void dispose() {
    _logData();
    _playerController.dispose();
    super.dispose();
  }

  void showModal(int index) {
    if (index == 7) {
      showDialog(
        context: context,
        barrierDismissible: false, // 모달 바깥을 탭해도 닫히지 않게 설정
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 타이틀
                  Text(
                    'Find Osaka Restaurant On App',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      _firestore.collection('userData').doc(widget.uid).update({
                        'modalButton': FieldValue.arrayUnion([
                          {
                            'buttonType': 'Google',
                            'time': Timestamp.now(),
                          }
                        ])
                      });
                      _analytics.logEvent(
                        name: "modal_view",
                        parameters: {
                          'buttonType': 'Google',
                          'time': Timestamp.now(),
                        },
                      );
                      _playerController.pause();
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SorryPage(
                                    uid: widget.uid,
                                  )));
                    },
                    child: Container(
                      width: 190,
                      // height: 85,
                      color: Colors.white,
                      child: Image.asset(
                        'images/playstore_jp.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _firestore.collection('userData').doc(widget.uid).update({
                        'modalButton': FieldValue.arrayUnion([
                          {
                            'buttonType': 'Apple',
                            'time': Timestamp.now(),
                          }
                        ])
                      });
                      _analytics.logEvent(
                        name: "modal_view",
                        parameters: {
                          'buttonType': 'Apple',
                          'time': Timestamp.now(),
                        },
                      );
                      _playerController.pause();
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => SorryPage(
                                    uid: widget.uid,
                                  )));
                    },
                    child: Container(
                      width: 190,
                      height: 85,
                      color: Colors.white,
                      child: SvgPicture.asset('images/appstore_jp.svg'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    height: 1,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      _firestore.collection('userData').doc(widget.uid).update({
                        'modalButton': FieldValue.arrayUnion([
                          {
                            'buttonType': 'Web',
                            'time': Timestamp.now(),
                          }
                        ])
                      });
                      _analytics.logEvent(
                        name: "modal_view",
                        parameters: {
                          'buttonType': 'Web',
                          'time': Timestamp.now(),
                        },
                      );
                      Navigator.pop(context);
                    },
                    child: Text(
                      'I\'ll just keep looking web',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }

  void _logData() {
    _firestore.collection('userData').doc(widget.uid).update({
      'viewedVideo': FieldValue.arrayUnion([
        {
          'storeName': widget.storeName,
          'viewedSeconds': _playerController.value.position.inSeconds,
          'time': Timestamp.now(),
        }
      ])
    });
    _analytics.logEvent(
      name: "video_view",
      parameters: {
        'storeName': widget.storeName,
        'viewedSeconds': _playerController.value.position.inSeconds,
        'time': Timestamp.now(),
      },
    );
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

  void detectPlatformFromUrl(String url) {
    if (url.contains("instagram.com")) {
      getPlatformIcon("instagram");
    } else if (url.contains("youtube.com/shorts")) {
      getPlatformIcon("shorts");
    } else if (url.contains("tiktok.com")) {
      getPlatformIcon("tiktok");
    } else {
      // 기본값: 인스타그램 아이콘
      getPlatformIcon("instagram");
    }
  }

  void getPlatformIcon(String platform) {
    switch (platform) {
      case "instagram":
        setState(() {
          platformIcon = 'images/Instagram_icon.png';
        });
        break;
      case "tiktok":
        setState(() {
          platformIcon = 'images/tiktok_icon.png';
        });
        break;
      case "shorts":
        setState(() {
          platformIcon = 'images/shorts_icon.png';
        });
        break;
      default:
        setState(() {
          platformIcon = 'images/Instagram_icon.png';
        });
        break;
    }
  }

  void getRestaurantCategory(String category) {
    switch (category) {
      case "kr":
        setState(() {
          restaurantCategory = Icons.rice_bowl;
        });
        break;
      case "jp":
        setState(() {
          restaurantCategory = Icons.ramen_dining;
        });
        break;
      case "cn":
        setState(() {
          restaurantCategory = Icons.soup_kitchen;
        });
        break;
      case "we":
        setState(() {
          restaurantCategory = Icons.local_pizza;
        });
        break;
      case "cf":
        setState(() {
          restaurantCategory = Icons.local_cafe;
        });
        break;
      case "bs":
        setState(() {
          restaurantCategory = Icons.kebab_dining;
        });
        break;
      case "br":
        setState(() {
          restaurantCategory = Icons.sports_bar;
        });
        break;
      case "et":
        setState(() {
          restaurantCategory = Icons.dining;
        });
        break;
      default:
        setState(() {
          restaurantCategory = Icons.dining;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index == 0) {
      return Stack(children: [
        SizedBox.shrink(child: VideoPlayer(_playerController),),
        ShimmerWidget(mode: 'done',),
      ]);
      // return ShimmerWidget(mode: 'done');
    } else {
      return Stack(
        children: [
          GestureDetector(
            onTap: () {
              _toggleVideo();
            },
            // onDoubleTap: () {
            //   print('doubletap');
            // },
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
                        IgnorePointer(child: VideoPlayer(_playerController)),
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
                        playedColor: Color.fromRGBO(220, 20, 60, 1),
                        // 재생된 부분 색상
                        bufferedColor: Colors.grey,
                        // 버퍼링된 부분 색상
                        backgroundColor: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            GestureDetector(
              onTap: () {
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
                ), // 어두운 투명 레이어
              ),
            ),
          // Positioned(
          //   top: 55,
          //   child: SizedBox(
          //     width: MediaQuery.of(context).size.width,
          //     child: Row(
          //       children: [
          //         Spacer(),
          //         IconButton(
          //           icon: Icon(
          //             Icons.search,
          //             color: Colors.white,
          //             size: 35,
          //           ),
          //           onPressed: () {},
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(right: 10),
          //           child: IconButton(
          //             icon: Icon(
          //               Icons.more_vert,
          //               color: Colors.white,
          //               size: 35,
          //             ),
          //             onPressed: () {},
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.03,
            bottom: MediaQuery.of(context).size.height * 0.02,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (widget.browserName == 'BrowserName.safari')
                  GestureDetector(
                  onTap: (){
                    if (_volumeOn){
                      _playerController.setVolume(0.0);
                      setState(() {
                        _volumeOn = false;
                      });
                    } else {
                      _firestore.collection('userData').doc(widget.uid).update({
                        'clickedButton': FieldValue.arrayUnion([
                          {
                            'storeName': widget.storeName,
                            'viewedSeconds':
                            _playerController.value.position.inSeconds,
                            'buttonType': '볼륨ON',
                            'time': Timestamp.now(),
                          }
                        ])
                      });
                      _analytics.logEvent(
                        name: "volume_button_click",
                        parameters: {
                          'storeName': widget.storeName,
                          'viewedSeconds':
                          _playerController.value.position.inSeconds,
                          'buttonType': '볼륨',
                          'time': Timestamp.now(),
                        },
                      );
                      _playerController.setVolume(1.0);
                      setState(() {
                        _volumeOn = true;
                      });
                    }
                  },
                  child: Container(
                    width: 55,
                    height: 55,
                    color: Colors.transparent,
                    child: Icon(
                      _volumeOn ? Icons.volume_up : Icons.volume_off,
                      color: Colors.white,
                      size: 42,
                    )
                  ),
                ),
                if (widget.browserName == 'BrowserName.safari')
                  SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    js.context.callMethod('open', [widget.storeLocation]);
                    _firestore.collection('userData').doc(widget.uid).update({
                      'clickedButton': FieldValue.arrayUnion([
                        {
                          'storeName': widget.storeName,
                          'viewedSeconds':
                              _playerController.value.position.inSeconds,
                          'buttonType': '네이버지도',
                          'time': Timestamp.now(),
                        }
                      ])
                    });
                    _analytics.logEvent(
                      name: "naver_button_click",
                      parameters: {
                        'storeName': widget.storeName,
                        'viewedSeconds':
                            _playerController.value.position.inSeconds,
                        'buttonType': '네이버지도',
                        'time': Timestamp.now(),
                      },
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 55,
                      height: 55,
                      color: Colors.white,
                      child: Image.asset(
                        'images/naver_icon.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    js.context.callMethod('open', [widget.sourceURL]);
                    _firestore.collection('userData').doc(widget.uid).update({
                      'clickedButton': FieldValue.arrayUnion([
                        {
                          'storeName': widget.storeName,
                          'viewedSeconds':
                              _playerController.value.position.inSeconds,
                          'buttonType': '원본링크',
                          'time': Timestamp.now(),
                        }
                      ])
                    });
                    _analytics.logEvent(
                      name: "insta_button_click",
                      parameters: {
                        'storeName': widget.storeName,
                        'viewedSeconds':
                            _playerController.value.position.inSeconds,
                        'buttonType': '원본링크',
                        'time': Timestamp.now(),
                      },
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 55,
                      height: 55,
                      color: Colors.transparent,
                      child: Image.asset(
                        platformIcon,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.015,
            bottom: MediaQuery.of(context).size.height * 0.065,
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
                        child: Icon(
                          restaurantCategory,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        color: Colors.transparent,
                        child: Text(
                          widget.storeName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // SizedBox(
                      //   width: 10,
                      // ),
                      // GestureDetector(
                      //   onTap: () {
                      //     js.context.callMethod('open', [widget.storeLocation]);
                      //     _firestore
                      //         .collection('userData')
                      //         .doc(widget.uid)
                      //         .update({
                      //       'clickedButton': FieldValue.arrayUnion([
                      //         {
                      //           'storeName': widget.storeName,
                      //           'viewedSeconds':
                      //               _playerController.value.position.inSeconds,
                      //           'buttonType': '더보기',
                      //           'time': Timestamp.now(),
                      //         }
                      //       ])
                      //     });
                      //     _analytics.logEvent(
                      //       name: "more_button_click",
                      //       parameters: {
                      //         'storeName': widget.storeName,
                      //         'viewedSeconds':
                      //             _playerController.value.position.inSeconds,
                      //         'buttonType': '더보기',
                      //         'time': Timestamp.now(),
                      //       },
                      //     );
                      //     // showInfoModal(context);
                      //   },
                      //   child: Container(
                      //     width: 70,
                      //     height: 30,
                      //     padding: EdgeInsets.only(bottom: 3),
                      //     child: Center(
                      //       child: Text(
                      //         '더보기',
                      //         style: TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 16,
                      //             color: Colors.white),
                      //       ),
                      //     ),
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(3),
                      //         border:
                      //             Border.all(width: 0.5, color: Colors.white)),
                      //   ),
                      // ),
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
                          maxHeight: _isExpanded
                              ? MediaQuery.of(context).size.height * (320 / 812)
                              : 25,
                          minHeight: _isExpanded
                              ? MediaQuery.of(context).size.height * (100 / 812)
                              : 25,
                        ),
                        duration: const Duration(milliseconds: 200),
                        child: _isExpanded
                            ? SingleChildScrollView(
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  color: Colors.transparent,
                                  child: Text(
                                    widget.storeCaption,
                                    style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.045,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                color: Colors.transparent,
                                child: Text(
                                  widget.storeCaption,
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.045,
                                    color: Colors.white,
                                  ),
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
            left: MediaQuery.of(context).size.width * 0.015,
            bottom: MediaQuery.of(context).size.height * 0.015,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(243, 244, 246, 1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 18,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${widget.openTime} ~ ${widget.closeTime}',
                          style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.035),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(243, 244, 246, 1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.rating.toString(),
                          style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.035),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(243, 244, 246, 1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Icon(
                          Icons.groups,
                          size: 18,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          widget.viewCount.toString() + '만',
                          style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.width * 0.035),
                        )
                      ],
                    ),
                  ),
                  // Container(
                  //   height: 30,
                  //   padding: EdgeInsets.symmetric(horizontal: 8),
                  //   decoration: BoxDecoration(
                  //       color: Colors.blue,
                  //       borderRadius: BorderRadius.circular(8)
                  //   ),
                  //   child: Text(
                  //     '조회수 · 123만',
                  //     style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 16
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   bottom: 15,
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: [
          //         Container(
          //           width: 150,
          //           height: 41,
          //           padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Icon(
          //                 Icons.pin_drop_outlined,
          //                 color: Colors.white,
          //               ),
          //               SizedBox(
          //                 width: 6,
          //               ),
          //               Text(
          //                 'Los Angeles',
          //                 style: TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 15,
          //                     color: Colors.white),
          //               ),
          //             ],
          //           ),
          //           decoration: BoxDecoration(
          //               color: Colors.black.withOpacity(0.4),
          //               borderRadius: BorderRadius.circular(18),
          //               border: Border.all(width: 0.5, color: Colors.white)),
          //         ),
          //         Container(
          //           width: 150,
          //           height: 41,
          //           padding: EdgeInsets.symmetric(vertical: 3, horizontal: 6),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Icon(
          //                 Icons.restaurant_outlined,
          //                 color: Colors.white,
          //               ),
          //               SizedBox(
          //                 width: 6,
          //               ),
          //               Text(
          //                 'Food:Steak',
          //                 style: TextStyle(
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 15,
          //                     color: Colors.white),
          //               ),
          //             ],
          //           ),
          //           decoration: BoxDecoration(
          //               color: Colors.black.withOpacity(0.4),
          //               borderRadius: BorderRadius.circular(18),
          //               border: Border.all(width: 0.5, color: Colors.white)),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      );
    }
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
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 5),
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
