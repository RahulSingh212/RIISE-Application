import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
    GoogleSignIn? googleUser =
    await GoogleSignIn(scopes: ['https://www.googleapis.com/auth/calendar']);
    final GoogleSignInAccount = await googleUser.signInSilently();

    final googleAuth = await GoogleSignInAccount?.authentication;
    // final accessToken = "ya29.a0Ael9sCNTICz8w49X6vW0a0AU6Wp-iwpgKkenAhKCbc5vCKZRRzorJOfWVHYYv6gurmSlqu6TrDA8SWsspv7cOc83fYuKezNeuVq3twbwWu9iU1c3Q26EfH9rjWf5Q7nGNmia05Y6hl0W3WbF-Xf53fNjWCD4aCgYKAc0SARESFQF4udJhWdFfWnmxoPBKiidqvPkv-g0163";
    final accessToken = googleAuth?.accessToken;

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