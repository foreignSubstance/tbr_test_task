import 'package:flutter/material.dart';
import 'package:tbr_test_task/widgets/carousel_widget.dart';

import 'package:tbr_test_task/widgets/launches_widget.dart';

import '../widgets/subtitle_widget.dart';
import 'models/update_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _model = UpdateWidgetViewModel();
  @override
  Widget build(BuildContext context) {
    return UpdateViewProvider(
      model: _model,
      child: const Column(children: [
        Carousel(),
        SubtitleWidget(subtitle: 'Missions'),
        LaunchesList(),
      ]),
    );
  }
}
