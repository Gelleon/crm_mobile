import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CalendarService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [CalendarApi.calendarEventsScope],
  );

  Future<void> createEvent({
    required String title,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // User canceled

      final httpClient = await _googleSignIn.authenticatedClient();
      if (httpClient == null) return;

      final calendarApi = CalendarApi(httpClient);

      final event = Event(
        summary: title,
        description: description,
        start: EventDateTime(
          dateTime: startTime,
          timeZone: 'UTC',
        ),
        end: EventDateTime(
          dateTime: endTime,
          timeZone: 'UTC',
        ),
      );

      await calendarApi.events.insert(event, 'primary');
    } catch (e) {
      print('Error creating calendar event: $e');
      rethrow;
    }
  }
}
