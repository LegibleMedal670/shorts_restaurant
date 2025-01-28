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
          bottom: 5,
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
          bottom: 5,
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
                          width: 10,
                        ),
                        Text(
                          storeName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
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
                    GestureDetector(
                      onTap: () {
                        showModalPopUp(context);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        color: Colors.transparent,
                        child: Text(
                          storeCaption,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
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

  void showModalPopUp(BuildContext context) {
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
                            '음식점이름',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text(
                            '음식점유형',
                            style: TextStyle(
                              color: Colors.black54
                            ),
                          ),
                          SizedBox(width: 15,),
                          Text(
                            '거리',
                            style: TextStyle(
                                color: Colors.black54
                            ),
                          ),
                          Spacer(
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: Colors.black, width: 0.5)
                            ),
                            child: Text('북마크'),
                          ),
                        ],
                      ),
                      SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.28,
                            height: MediaQuery.of(context).size.width * 0.28,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.28,
                            height: MediaQuery.of(context).size.width * 0.28,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.28,
                            height: MediaQuery.of(context).size.width * 0.28,
                            decoration: BoxDecoration(
                              color: Colors.black26,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      SizedBox(height: 15,),
                    ],
                  ),
                ),
              ),
            )
        );
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
            size: 35,
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
