import 'package:flutter/material.dart';
import 'package:recording/pages/drive.dart';
import 'package:recording/pages/record.dart';
import 'package:recording/utils/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Record",
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.red,
          bottom: TabBar(
            indicatorColor: AppColors.white,
            tabs: [
              Tab(
                  icon: Icon(
                Icons.mic,
                color: AppColors.white,
              )),
              Tab(
                  icon: Icon(
                Icons.play_arrow,
                color: AppColors.white,
              )),
              Tab(
                  icon: Icon(
                Icons.settings,
                color: AppColors.white,
              )),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const Record(),
            const RecordDrive(),
            Container(),
          ],
        ),
      ),
    );
  }
}
