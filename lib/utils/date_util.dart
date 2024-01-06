import 'package:cloud_firestore/cloud_firestore.dart';

String timestampToDateTimeString(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();
 String formattedDateTime = "${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute}";
   return formattedDateTime;
}