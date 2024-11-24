import 'dart:developer';

import 'package:creative_status/cubit/status_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helper/contstants/my_colors.dart';
import '../widgets/settingt_text_widget.dart';
import '../widgets/status_text_widget.dart';
import '../widgets/text_to_image_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                onPressed: () async {
                  await showDialog(
                      useSafeArea: true,
                      context: context,
                      builder: (_) => TextToImageWidget());
                },
                child: Icon(Icons.share),
              ),
            ),
          ],
        ),
        expandedTitleScale: 1.3,
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
        [StatusTextWidget()],
      ),
    );
  }

  //
}
