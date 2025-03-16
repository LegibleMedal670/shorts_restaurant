import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shorts_restaurant/Shorts/widgets/ShimmerWidget.dart';
import 'package:shorts_restaurant/Shorts/widgets/ShortFormWidget.dart';
import 'package:uuid/uuid.dart';

class VideoPage extends StatefulWidget {

  final String browserName;

  const VideoPage({
    required this.browserName,
    super.key,
  });

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  final Uuid uuid = Uuid();


  String userId = '';

  Future<List<dynamic>> tempFuture() async {
    ///애널리틱스초기화
    initAnalytics();

    DocumentSnapshot documentSnapshot =
    await _firestore.collection('shortsmap_seongsu').doc('map').get();

    Map<String, dynamic> documents = documentSnapshot.data() as Map<String,dynamic>;

    List<dynamic> data = documents['dataMapList'];

    data.shuffle();

    await Future.delayed(const Duration(milliseconds: 1500));

    return data;
  }

  ///uid 만들어주고 애널리틱스 ID로 설정, 파이어베이스 문서 생성, tempFuture에서 실행
  Future<void> initAnalytics() async {
    setState(() {
      userId = uuid.v4();
    });
    await _analytics.setUserId(id: userId);

    await _firestore.collection('userData').doc(userId).set({
      'viewedVideo': [],
      'clickedButton': [],
      'modalButton': [],
      'survey': [],
      'createdTime': Timestamp.now(),
      'browser': widget.browserName,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: tempFuture(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return ShimmerWidget(mode: 'error');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ShimmerWidget(mode: 'loading');
                }

                List<dynamic> data = snapshot.data!;

                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> shortFormData = data[index];
                      return ShortFormWidget(
                        storeName: shortFormData['store_name'],
                        videoURL: shortFormData['video_link'],
                        storeCaption: shortFormData['description'],
                        storeLocation: shortFormData['naver_map_link'],
                        viewCount: shortFormData['views'],
                        sourceURL: shortFormData['instagram_link'],
                        openTime: shortFormData['open_time'],
                        closeTime: shortFormData['close_time'],
                        rating: shortFormData['rating'],
                        category: shortFormData['category'],
                        uid: userId,
                        index: index,
                        browserName: widget.browserName,
                      );
                  },
                );
              },
            ),
          ),
          // BottomNavBar(context, 'shorts'),
        ],
      ),
    );
  }
}
