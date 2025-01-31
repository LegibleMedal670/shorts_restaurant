import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shorts_restaurant/Map/pages/MapPage.dart';
import 'package:shorts_restaurant/Shorts/pages/VideoPage.dart';

Widget BottomNavBar(BuildContext context, String page) {
  return Container(
    padding: EdgeInsets.only(bottom: 15),
    height: (Platform.isIOS)
        ? MediaQuery.of(context).size.height * (70 / 812)
        : MediaQuery.of(context).size.height * (60 / 812),
    color: Colors.black,
    child: Row(
      children: [
        // 쇼츠
        InkWell(
          onTap: () async {
            if (page != 'shorts') {
              List<ConnectivityResult> connectivityResult =
                  await Connectivity().checkConnectivity();
              if (!connectivityResult.contains(ConnectivityResult.none)) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const VideoPage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
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
            // padding: EdgeInsets.only(
            //     top: MediaQuery.of(context).size.height * (16 / 812)),
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width * 0.33,
            child: Icon(
              Icons.music_video_outlined,
              color: (page == 'shorts') ? Colors.white : Colors.grey,
              size: MediaQuery.of(context).size.height * (25 / 812),
            ),
          ),
        ),
        // 지도
        InkWell(
          onTap: () async {
            if (page != 'map') {
              List<ConnectivityResult> connectivityResult =
                  await Connectivity().checkConnectivity();
              if (!connectivityResult.contains(ConnectivityResult.none)) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        const MapPage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
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
            // padding: EdgeInsets.only(
            //     top: MediaQuery.of(context).size.height * (16 / 812)),
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width * 0.33,
            child: Icon(
              // Icons.supervisor_account,
              CupertinoIcons.map_pin_ellipse,
              color: (page == 'map') ? Colors.white : Colors.grey,
              size: MediaQuery.of(context).size.height * (25 / 812),
            ),
          ),
        ),
        //프로필
        InkWell(
          onTap: () async {
            if (page != 'profile') {
              List<ConnectivityResult> connectivityResult =
              await Connectivity().checkConnectivity();
              if (!connectivityResult.contains(ConnectivityResult.none)) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                    const MapPage(),
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
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
            // padding: EdgeInsets.only(
            //     top: MediaQuery.of(context).size.height * (16 / 812)),
            color: Colors.transparent,
            width: MediaQuery.of(context).size.width * 0.33,
            child: Icon(
              // Icons.supervisor_account,
              CupertinoIcons.profile_circled,
              color: (page == 'profile') ? Colors.white : Colors.grey,
              size: MediaQuery.of(context).size.height * (25 / 812),
            ),
          ),
        ),
      ],
    ),
  );
}
