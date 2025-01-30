import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shorts_restaurant/Widgets/BottomNavBar.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  List<String> searchResults = [];

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        body: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  focusNode: _focusNode,
                  controller: _textEditingController,
                  // onChanged: filterSearch,
                  cursorColor: Colors.black38,
                  decoration: InputDecoration(
                    prefixIconColor: Colors.black54,
                    prefixIcon: Icon(Icons.search),
                    hintText: '동, 지하철역, 대학교 이름으로 검색해보세요!',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
            ),
            if (searchResults.isEmpty)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.travel_explore_outlined, color: Colors.black38, size: 70,),
                        SizedBox(height: 15,),
                        Text(
                          '동, 지하철역, 대학교 이름으로 검색해보세요!',
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 18
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            if (searchResults.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: searchResults.length,
                  itemBuilder: (context, index){



                  },
                ),
              ),
            BottomNavBar(context, 'map')
          ],
        ),
      ),
    );
  }
}
