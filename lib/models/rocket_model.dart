class Rocket {
  String rocketId;

  Rocket.fromJson(Map<String, dynamic> json) : rocketId = json['rocket_id'];
}
