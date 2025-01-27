import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shorts_restaurant/Shorts/widgets/ShortVideoWidget.dart';

class ShortFormWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShortVideoWidget(videoURL: videoURL),
        Positioned(
          top: 55,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    icon: Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                    onPressed: () {},
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: Icon(
                      Icons.tune,
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
          bottom: 30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ItemButton(
                icon: Icons.bookmark_outline,
                amount: bookmarkAmount,
              ),
              ItemButton(
                icon: Icons.comment,
                amount: reviewAmount,
              ),
              ItemButton(
                icon: CupertinoIcons.reply,
                amount: shareAmount,
              ),
              ItemButton(
                icon: Icons.more_horiz,
              )
            ],
          ),
        ),
        Positioned(
          left: 25,
          bottom: 45,
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
                          backgroundColor: Colors.white,
                          // backgroundImage: NetworkImage(widget.storeProfileImage)
                        ),
                        SizedBox(
                          width: 13,
                        ),
                        Text(
                          storeName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 60,
                          height: 30,
                          padding:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                          child: Center(
                            child: Text(
                              'Ping',
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
                        )
                      ],
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Text(
                      storeCaption,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget ItemButton({IconData icon = Icons.bookmark, int? amount}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        children: [
          Icon(
            icon,
            size: 43,
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
