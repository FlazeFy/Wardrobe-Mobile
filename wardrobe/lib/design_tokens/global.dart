import 'package:flutter_local_notifications/flutter_local_notifications.dart';

int selectedIndex = 0;

bool isOffline = false;

// API Fetch rest time
int clothesHeaderFetchRestTime = 60; // in second
int statsFetchRestTime = 180;
int profileFetchRestTime = 360;

// Firebase
String? token;

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);
