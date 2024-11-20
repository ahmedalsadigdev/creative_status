import 'dart:developer';

import 'package:flutter/material.dart';

import '../helper/contstants/my_colors.dart';

class HomePage extends StatelessWidget {
  final _textController = TextEditingController();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [buildSliverAppBar(context), buildSliverList()],
      ),
    );
  }

  Widget buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.3,
      bottom: PreferredSize(
        child: SizedBox.shrink(),
        preferredSize: Size(0, 5),
      ),
      pinned: true,
      stretch: true,
      primary: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text("What do you think?",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black54, fontWeight: FontWeight.bold)),
            SizedBox(
              height: 45,
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                foregroundColor: MyColors.buttonColor,
                shape: CircleBorder(),
                onPressed: () {
                  log(_textController.text.toString());
                },
                child: Icon(Icons.share),
              ),
            ),
          ],
        ),
        expandedTitleScale: 1.5,
        background: Image.asset(
          "assets/images/bg.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [buildText()],
      ),
    );
  }

  Widget buildText() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: _textController,
        onChanged: (value) {
          log(value);
        },
        keyboardType: TextInputType.multiline,
        maxLines: null, // <-- SEE HERE
        decoration: InputDecoration(
            // labelText: 'What are you thinking?',
            hintText: 'Type here...',
            border: InputBorder.none),
      ),
    );
  }

  //
}
