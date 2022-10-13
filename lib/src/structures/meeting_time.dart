/// Greatly reduced representation of the data representing when a class is meeting, and where, if any.
class MeetingTime {
  /// What time the class officially starts a meeting/
  late final String? beginTime;

  /// What time the class officially ends a meeting.
  late final String? endTime;

  /// What day the class starts meeting.
  late final String startDate;

  /// What day the class stops meeting.
  late final String endDate;

  /// Building description
  ///
  /// In my case this is usually defined as "Campus - Building name",
  /// web just shows up as "Web".
  late final String? buildingDescription;

  /// Room number
  late final String? room;

  /// Representation of the days of the week the class meets
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
