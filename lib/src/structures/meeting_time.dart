class MeetingTime {
  late final String? beginTime;
  late final String? endTime;
  late final String startDate;
  late final String endDate;

  late final String? buildingDescription;
  late final String? room;

  Map<String, bool> days = {
    "sunday": false,
    "monday": false,
    "tuesday": false,
    "wednesday": false,
    "thursday": false,
    "friday": false,
    "saturday": false
  };

  MeetingTime.fromJson(Map<String, dynamic> input) {
    if (input["beginTime"] != null) {
      beginTime = input["beginTime"].toString();
    }

    if (input["endTime"] != null) {
      endTime = input["endTime"].toString();
    }

    if (input["startDate"] != null) {
      startDate = input["startDate"];
    }

    if (input["endDate"] != null) {
      endDate = input["endDate"];
    }

    if (input["buildingDescription"] != null) {
      buildingDescription = input["buildingDescription"];
    }

    if (input["room"] != null) {
      room = input["room"].toString();
    }

    days["sunday"] = input["sunday"] ??= false;
    days["monday"] = input["monday"] ??= false;
    days["tuesday"] = input["tuesday"] ??= false;
    days["wednesday"] = input["wednesday"] ??= false;
    days["thursday"] = input["thursday"] ??= false;
    days["friday"] = input["friday"] ??= false;
    days["saturday"] = input["saturday"] ??= false;
  }
}
