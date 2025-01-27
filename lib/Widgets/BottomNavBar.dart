import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget BottomNavBar(BuildContext context, String page) {
  return Container(
    height: (Platform.isIOS)
        ? MediaQuery.of(context).size.height * (80 / 812)
        : MediaQuery.of(context).size.height * (60 / 812),
    color: Colors.black,
    child: Column(
      children: [
        Row(
          children: [
            // 홈 아이콘 및 텍스트
            InkWell(
              onTap: () async {
                if (page != 'shorts') {
                  List<ConnectivityResult> connectivityResult =
                      await Connectivity().checkConnectivity();
                  if (!connectivityResult.contains(ConnectivityResult.none)) {
                    // Navigator.pushReplacement(
                    //   context,
                    //   PageRouteBuilder(
                    //     pageBuilder: (context, animation1, animation2) =>
                    //         const FeedMainPage(),
                    //     transitionDuration: Duration.zero,
                    //     reverseTransitionDuration: Duration.zero,
                    //   ),
                    // );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('인터넷에 연결되어 있지 않습니다.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * (16 / 812)),
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Icon(
                  Icons.music_video_outlined,
                  color: (page == 'shorts') ? Colors.white : Colors.grey,
                  size: MediaQuery.of(context).size.height * (25 / 812),
                ),
              ),
            ),
            // 뉴스레터 아이콘 및 텍스트
            InkWell(
              onTap: () async {
                if (page != 'map') {
                  List<ConnectivityResult> connectivityResult =
                      await Connectivity().checkConnectivity();
                  if (!connectivityResult.contains(ConnectivityResult.none)) {
                    // Navigator.pushReplacement(
                    //   context,
                    //   PageRouteBuilder(
                    //     pageBuilder: (context, animation1, animation2) =>
                    //         const AuthorMainPage(),
                    //     transitionDuration: Duration.zero,
                    //     reverseTransitionDuration: Duration.zero,
                    //   ),
                    // );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('인터넷에 연결되어 있지 않습니다.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * (16 / 812)),
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width * 0.5,
                child: Icon(
                  // Icons.supervisor_account,
                  CupertinoIcons.map_pin_ellipse,
                  color: (page == 'map') ? Colors.white : Colors.grey,
                  size: MediaQuery.of(context).size.height * (25 / 812),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
