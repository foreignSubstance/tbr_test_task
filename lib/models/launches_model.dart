import 'package:intl/intl.dart';

class LaunchesInfo {
  String missionName = '';
  String missionDate = '';
  String missionTime = '';
  String missionSite = '';
  String missionWiki = '';

  LaunchesInfo.fromJson(Map<String, dynamic> json)
      : missionName = json['mission_name'],
        missionDate = dateParser(json['launch_date_utc']),
        missionTime = timeParser(json['launch_date_utc']),
        missionSite = json['launch_site']['site_name_long'],
        missionWiki = json['links']['wikipedia'];
}

String dateParser(String rawDate) {
  DateTime timeAndDate = DateTime.parse(rawDate);
  DateFormat formatter = DateFormat('dd/MM/y');
  String formatedDate = formatter.format(timeAndDate);
  return formatedDate;
}

String timeParser(String rawDate) {
  DateTime timeAndDate = DateTime.parse(rawDate);
  DateFormat formatter = DateFormat('jm');
  String formatedTime = formatter.format(timeAndDate);
  return formatedTime;
}
