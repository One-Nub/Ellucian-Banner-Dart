import 'meeting_time.dart';

/// Reduced course representation.
///
/// The actual API returns far more variables than what was outlined here, but I only included
/// what I consider as useful/necessary information for the time being.
class Course {
  /// Ellucian ID
  late final int id;

  /// Public facing ID of course
  late final String courseReferenceNumber;

  /// Appears to be 1 of 3 values... "1" (full semester), "H2H" (first half), "P1H" (second half)
  late final String partOfTerm;

  /// Commonly known course ID (but not as specific as CRN)
  late final String courseNumber;

  /// The section for this course.
  late final String sequenceNumber;

  /// Class subject (ITSY, CYBR, PHYS, etc...)
  late final String subject;

  /// Campus name usually, Web if other
  late final String campusDescription;

  /// Name of class
  late final String courseTitle;

  /// Web, Lecture/Lab, Lab
  late final String scheduleTypeDescription;

  /// Name of instructor, if one exists
  late final String? instructorName;

  /// Information regarding course room, dates, times, etc
  late final MeetingTime? meetingInfo;

  Course.fromJson(Map<String, dynamic> input) {
    id = input["id"];
    courseReferenceNumber = input["courseReferenceNumber"].toString();
    partOfTerm = input["partOfTerm"].toString();
    courseNumber = input["courseNumber"].toString();
    sequenceNumber = input["sequenceNumber"].toString();
    subject = input["subject"];
    campusDescription = input["campusDescription"];
    courseTitle = input["courseTitle"];
    scheduleTypeDescription = input["scheduleTypeDescription"];
    if (input["faculty"] != null && input["faculty"].isNotEmpty) {
      /// Faculty is a list, with each element being a json map, so get the first result & show.
      /// generally speaking we don't have >1 instructor (tmk), so this should be a safe assumption.
      ///
      /// If this were to be expanded past small usage, this should be changed. Of course, if I were
      /// doing that, instructors would get their own class representation.
      instructorName = input["faculty"].first["displayName"];
    }
    if (input["meetingsFaculty"] != null && input["meetingsFaculty"].isNotEmpty) {
      Map<String, dynamic> meetingData = input["meetingsFaculty"];
      if (meetingData.isNotEmpty) {
        meetingInfo = MeetingTime.fromJson(meetingData);
      }
    }
  }
}
