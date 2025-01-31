import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shorts_restaurant/Shorts/widgets/ShortFormWidget.dart';
import 'package:shorts_restaurant/Widgets/BottomNavBar.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  List<Map<String, dynamic>> tempData = [
    {
      'storeName': 'Mc Donalds',
      'videoURL':
          'https://pub-f3e1c8748b25400eb916055e6f657e4e.r2.dev/video_1.mp4',
      'storeProfileImage': '',
      'storeCaption': 'Come and eat the most delicious burgers you\'ll ever eat! for 4.99\$',
      'storeLocation': '음식점위치1',
      'shareAmount': 123,
      'reviewAmount': 412,
      'bookmarkAmount': 118,
    },
    {
      'storeName': '음식점2',
      'videoURL':
          'https://pub-f3e1c8748b25400eb916055e6f657e4e.r2.dev/video_2.mp4',
      'storeProfileImage': '',
      'storeCaption': '음식점 2 영상입니다 안녕하세요 ~~',
      'storeLocation': '음식점위치2',
      'shareAmount': 123,
      'reviewAmount': 412,
      'bookmarkAmount': 118,
    },
    {
      'storeName': '음식점3',
      'videoURL':
          'https://pub-f3e1c8748b25400eb916055e6f657e4e.r2.dev/video_3.mp4',
      'storeProfileImage': '',
      'storeCaption': '음식점 3 영상입니다 안녕하세요 ~~',
      'storeLocation': '음식점위치4',
      'shareAmount': 123,
      'reviewAmount': 412,
      'bookmarkAmount': 118,
    },
    {
      'storeName': 'Location Shorts',
      'videoURL':
      'https://pub-f3e1c8748b25400eb916055e6f657e4e.r2.dev/video_4.mp4',
      'storeProfileImage': 'https://preview.redd.it/albert-camus-french-writer-in-1947-v0-ks34coywa1pb1.png?width=640&crop=smart&auto=webp&s=3608d8c1c4d56ac96b609e0fbefc738a84ed740e',
      'storeCaption': 'Come and eat the most delicious burgers you\'ll ever eat! for 4.99\$',
      'storeLocation': '음식점위치4',
      'shareAmount': 123,
      'reviewAmount': 412,
      'bookmarkAmount': 118,
    },
    {
      'storeName': 'Location Shorts',
      'videoURL':
      'https://pub-f3e1c8748b25400eb916055e6f657e4e.r2.dev/video_5.mp4',
      'storeProfileImage': 'https://preview.redd.it/albert-camus-french-writer-in-1947-v0-ks34coywa1pb1.png?width=640&crop=smart&auto=webp&s=3608d8c1c4d56ac96b609e0fbefc738a84ed740e',
      'storeCaption': 'Come and eat the most delicious burgers you\'ll ever eat! for 4.99\$',
      'storeLocation': '음식점위치4',
      'shareAmount': 527,
      'reviewAmount': 412,
      'bookmarkAmount': 218,
    },
    {
      'storeName': 'Location Shorts',
      'videoURL':
      'https://pub-f3e1c8748b25400eb916055e6f657e4e.r2.dev/video_6.mp4',
      'storeProfileImage': 'https://preview.redd.it/albert-camus-french-writer-in-1947-v0-ks34coywa1pb1.png?width=640&crop=smart&auto=webp&s=3608d8c1c4d56ac96b609e0fbefc738a84ed740e',
      'storeCaption': 'The most satisfying icecream cake for only \$9.99',
      'storeLocation': '음식점위치4',
      'shareAmount': 872,
      'reviewAmount': 613,
      'bookmarkAmount': 463,
    },
    {
      'storeName': 'Location Shorts',
      'videoURL':
      'https://pub-f3e1c8748b25400eb916055e6f657e4e.r2.dev/video_7.mp4',
      'storeProfileImage': 'https://preview.redd.it/albert-camus-french-writer-in-1947-v0-ks34coywa1pb1.png?width=640&crop=smart&auto=webp&s=3608d8c1c4d56ac96b609e0fbefc738a84ed740e',
      'storeCaption': 'Golden-crisp cutlets, bursting with flavor—your perfect bite awaits!',
      'storeLocation': '음식점위치4',
      'shareAmount': 672,
      'reviewAmount': 471,
      'bookmarkAmount': 264,
    }
  ];

  Future<List<Map<String, dynamic>>> tempFuture() async {
    await Future.delayed(const Duration(milliseconds: 1000));

    return tempData;
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

                List<Map<String, dynamic>> data = snapshot.data!;

                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> shortFormData = data[index];

                    return ShortFormWidget(
                      storeName: shortFormData['storeName'],
                      videoURL: shortFormData['videoURL'],
                      storeProfileImage: shortFormData['storeProfileImage'],
                      storeCaption: shortFormData['storeCaption'],
                      storeLocation: shortFormData['storeLocation'],
                      bookmarkAmount: shortFormData['bookmarkAmount'],
                      shareAmount: shortFormData['shareAmount'],
                      reviewAmount: shortFormData['reviewAmount'],
                    );
                  },
                );
              },
            ),
          ),
          BottomNavBar(context, 'shorts'),
        ],
      ),
    );
  }

  Widget ShimmerWidget({String mode = 'loading'}) {
    return Stack(
      children: [
        if (mode == 'error')
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Something went wrong',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Restart App',
                  style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ],
            ),
          ),
        Shimmer.fromColors(
          baseColor: Colors.grey[700] as Color,
          highlightColor: Colors.grey[800]!.withOpacity(0.8),
          child: Stack(
            children: [
              Positioned(
                right: 15,
                bottom: 15,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ShimmerIcon(),
                    ShimmerIcon(),
                    ShimmerIcon(),
                    ShimmerIcon(),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 14),
                    //   child: CircleAvatar(
                    //     radius: 25,
                    //     backgroundColor: Colors.grey[700],
                    //   ),
                    // ),
                  ],
                ),
              ),
              Positioned(
                left: 25,
                bottom: 23,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.grey[700],
                              ),
                              SizedBox(
                                width: 13,
                              ),
                              Container(
                                width: 150,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: Colors.grey[700],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 17,
                          ),
                          Container(
                            width: 230,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget ShimmerIcon() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[700],
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 40,
            height: 10,
            color: Colors.grey[700],
          )
        ],
      ),
    );
  }
}
