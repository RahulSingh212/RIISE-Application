import 'package:flutter/widgets.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:riise/providers/UserLoginProvider.dart';

class CalenderAPI extends ChangeNotifier{

  // Future<>
  static var calendar;

  addEvent(BuildContext context,String name,DateTime startTime, DateTime endTime, List<EventAttendee> attendeesList, String descp) async {
    // TODO - get access token here
    // final googleAuth = await UserLoginProvider().staticGoogleUser?.authentication;
    // final accessToken = await googleAuth?.accessToken;
    final accessToken = "ya29.a0Ael9sCOC9DN0SckxbhBP1xdo8ba5x5YabKz1XGHOEEWgTRcMM4yuEeq3Z0ci3LlNBBMfvfptn3cgXO1LrO2CUqKwJScv7hX1vo57HkZ-rX00LmbiW9XCCuARoQmEQLCkirzK7TodO_J3ccs4QLTzsxn7KbZ3aCgYKAUcSARESFQF4udJh8W5Vhaax96TQV2FDPATLyg0163";

    print("ACCESS TOKEN _> $accessToken");

    final httpClient = authenticatedClient(
        Client(),
        AccessCredentials(
            AccessToken('Bearer', accessToken!,
                DateTime.now().add(Duration(minutes: 5)).toUtc()),
            null,
            []));
    final calendar = CalendarApi(httpClient);

    print("Start Time -> $startTime");
    print("Start Time -> $endTime");
    print("Start Time -> $name");
    print("Start Time -> $descp");




    final event = Event()
      ..summary = name
      ..attendees = attendeesList
      ..description = descp
      ..start = (EventDateTime()
        ..dateTime = startTime.toUtc())
      ..end = (EventDateTime()
        ..dateTime =
        endTime.toUtc());

    print("Adding EVENT");

    try {
      print("Hello 1");
      await calendar.events.insert(event, 'primary',sendNotifications: true, sendUpdates: 'all');
      print("Hello 2");
    } catch (e) {
      print("Error -> $e");
    }
    ;
  }

}