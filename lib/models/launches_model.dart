import 'package:intl/intl.dart';

class LaunchesInfo {
  String missionName;
  String missionDate;
  String missionTime;
  String missionSite;
  String missionWiki;
  List missionImages;

  LaunchesInfo.fromJson(Map<String, dynamic> json)
      : missionName = json['mission_name'] ?? 'Mission Name not avalaible',
        missionDate = json['launch_date_utc'] == null
            ? 'Mission Date not avalaible'
            : dateParser(json['launch_date_utc']),
        missionTime = json['launch_date_utc'] == null
            ? 'Mission Time not avalaible'
            : timeParser(json['launch_date_utc']),
        missionSite = json['launch_site']['site_name_long'] ??
            'Mission Site not avalaible',
        missionWiki = json['links']['wikipedia'] ?? 'https://flutter.dev/',
        missionImages = json['links']['flickr_images'] ?? [];
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
