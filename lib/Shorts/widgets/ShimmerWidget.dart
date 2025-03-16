import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final String mode;

  const ShimmerWidget({Key? key, this.mode = 'loading'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (mode == 'error')
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Something went wrong',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Restart App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        if (mode == 'done')
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BounceArrow(), // 애니메이션 아이콘 위젯
                const SizedBox(height: 20),
                Text(
                  '아래로 내려서 영상 보기',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        if (mode == 'loading')
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
                                const SizedBox(width: 13),
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
                            const SizedBox(height: 17),
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
}

/// 위아래로 튀는 애니메이션을 위한 StatefulWidget
class BounceArrow extends StatefulWidget {
  const BounceArrow({Key? key}) : super(key: key);

  @override
  _BounceArrowState createState() => _BounceArrowState();
}

class _BounceArrowState extends State<BounceArrow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 700), // 애니메이션 주기
      vsync: this,
    )..repeat(reverse: true); // 반복 애니메이션 (정방향/역방향)
    _animation = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: Icon(
        Icons.arrow_downward,
        size: 50,
        color: Colors.white.withOpacity(0.8),
      ),
    );
  }
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
