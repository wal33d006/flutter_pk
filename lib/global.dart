import 'package:firebase_auth/firebase_auth.dart';
import 'package:waqareazadi/caches/EventDate.dart';
import 'package:waqareazadi/caches/location.dart';
import 'package:waqareazadi/caches/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class Routes {
  static const String home_master = '/home_master';
  static const String main = '/main';
}

abstract class GlobalConstants {
  static const int phoneNumberMaxLength = 13;
  static const String breakId = 'break';
  static const int entryMaxLength = 50;
  static const int cnicMaxLength = 13;
  static const String qrKey = "thisisahighlyencryptedaubykhanstringthatisbeingusedforfluttermeetupqrscan";
  static const String addNumberDisplayText =
      'Add your phone number in order to receive event updates.';
  static const String editNumberDisplayText =
      'Looks like you have a number registered against your account. You can use the same number to receive event confirmations or you can update it.';
}

abstract class SharedPreferencesKeys {
  static const String firebaseUserId = 'uid';
}

abstract class FireStoreKeys {
  static const String userCollection = 'users';
  static const String dateCollection = 'dates';
  static const String sessionCollection = 'sessions';
  static const String speakerCollection = 'speakers';
  static const String attendanceCollection = 'attendance';
  static const String attendeesCollection = 'attendees';
  static const String dateReferenceString = '16032019';
}

final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;
final Future<SharedPreferences> sharedPreferences =
    SharedPreferences.getInstance();

UserCache userCache = new UserCache();

LocationCache locationCache = new LocationCache();

EventDateTimeCache eventDateTimeCache = new EventDateTimeCache();
