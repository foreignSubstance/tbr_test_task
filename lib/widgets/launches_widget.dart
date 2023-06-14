import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../api_call.dart';
import '../models/launches_model.dart';
import '../models/rocket_model.dart';
import '../models/update_view_model.dart';

import 'package:url_launcher/url_launcher.dart';

class LaunchesList extends StatefulWidget {
  const LaunchesList({super.key});

  @override
  State<LaunchesList> createState() => _LaunchesListState();
}

class _LaunchesListState extends State<LaunchesList> {
  var launchesList = <int, List<LaunchesInfo>?>{
    0: null,
    1: null,
    2: null,
    3: null
  };

  late Future responseFuture;
  late int keyForList;

  String rocketName = 'falcon1';
  static final Future _rocketsFuture = getRocketsList();
  late List<String> allRockets;

  @override
  void initState() {
    super.initState();
    responseToRocketsList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final model = UpdateViewProvider.of(context);
    model?.addListener(() {
      setState(() {});
    });
  }

  void responseToRocketsList() async {
    _rocketsFuture.then((value) {
      setState(() {
        Iterable list = json.decode(value.body);
        allRockets =
            list.map((model) => Rocket.fromJson(model).rocketId).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    keyForList = UpdateViewProvider.of(context)?.currentPage ?? 0;
    rocketName = allRockets[keyForList];
    print(rocketName);
    responseFuture = getLaunchData(rocketId: rocketName);
    return FutureBuilder(
        future: responseFuture,
        builder: (context, dataFromServer) {
          switch (dataFromServer.connectionState) {
            case ConnectionState.waiting:
              return const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFFbafc54),
                  ),
                ),
              );
            case ConnectionState.done:
              responseToLaunchesList(
                  dataFromServer.data.body, keyForList, launchesList);
              return launchesList[keyForList]?.isEmpty == true
                  ? Expanded(
                      child: Center(
                        child: Text(
                          textAlign: TextAlign.center,
                          "There's no lauches for $rocketName in database",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 24),
                        ),
                      ),
                    )
                  : modelToContent(launchesList[keyForList], context);
            default:
              final error = dataFromServer.error;
              return Text(
                '$error',
                style: const TextStyle(color: Colors.white, fontSize: 32),
              );
          }
        });
  }
}

openInBrowser(String urlRaw) async {
  final Uri urlToLaunch = Uri.parse(urlRaw);
  bool isLaunchanble = await canLaunchUrl(urlToLaunch);
  if (isLaunchanble == false) {
    throw Exception('Could not launch $urlRaw');
  } else {
    await launchUrl(urlToLaunch);
  }
}

responseToLaunchesList(
    dynamic data, int keyForList, Map<int, List<LaunchesInfo>?> launchesList) {
  Iterable list = json.decode(data);
  launchesList[keyForList] =
      list.map((model) => LaunchesInfo.fromJson(model)).toList();
}

Widget modelToContent(List<LaunchesInfo>? list, BuildContext context) {
  return Expanded(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: list!.map((e) {
          return GestureDetector(
            onTap: () async {
              Feedback.forTap(context);
              await openInBrowser(e.missionWiki);
            },
            child: Container(
              padding: const EdgeInsets.only(left: 16),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              alignment: Alignment.center,
              height: 120,
              decoration: BoxDecoration(
                  color: const Color(0xff1c1c1c),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(e.missionDate,
                            style: const TextStyle(
                                color: Color(0xFFbafc54), fontSize: 16)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          e.missionName,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(e.missionTime,
                            style: const TextStyle(
                                color: Color(0xFFa5a5a5), fontSize: 16)),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          e.missionSite,
                          style: const TextStyle(
                              color: Color(0xFFa5a5a5), fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}
