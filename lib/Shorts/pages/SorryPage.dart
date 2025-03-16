import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'dart:js' as js;

class SorryPage extends StatelessWidget {
  final String uid;

  const SorryPage({
    required this.uid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '서비스 준비 중',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[200],
      ),
      body: Center(
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.lightbulb_circle_outlined,
                  size: 80,
                  color: Colors.pink[200],
                ),
                const SizedBox(height: 16),
                const Text(
                  '서비스 준비 중입니다',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  '현재 앱 승인절차가 진행중이에요!\n'
                  '3분 내외의 설문조사에 참여해주시면\n'
                  '감사의 표시로 커피 쿠폰을 드립니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 50),
                    minimumSize: Size.zero,
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.pink[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {
                    // TODO 설문조사링크
                    js.context.callMethod('open', ['https://forms.gle/ofvd9KMxWygFSzek6']);
                    _firestore.collection('userData').doc(uid).update({
                      'survey': FieldValue.arrayUnion([
                        {
                          'survey': true,
                          'time': Timestamp.now(),
                        }
                      ])
                    });
                    _analytics.logEvent(
                      name: "survey",
                      parameters: {
                        'survey': true,
                        'time': Timestamp.now(),
                      },
                    );
                  },
                  child: const Text('설문조사 참여하기'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
