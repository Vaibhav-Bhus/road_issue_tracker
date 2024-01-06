import 'package:cloud_firestore/cloud_firestore.dart';

class IssuesModel {
  String shortDescription;
  List<String> images;
  double latitude;
  double longitude;
  Timestamp reportedTime;
  String uid;

  IssuesModel({
    required this.images,
    required this.latitude,
    required this.longitude,
    required this.shortDescription,
    required this.reportedTime,
    required this.uid,
  });

  factory IssuesModel.fromDocument(DocumentSnapshot doc) {
    return IssuesModel(
      shortDescription: doc['shortDescription'],
      latitude: doc['latitude'],
      longitude: doc['longitude'],
      reportedTime: doc['reportedTime'],
      images: (doc['images'] as List<dynamic>).cast<String>(),
      uid: doc['uid'],
    );
  }

  factory IssuesModel.fromMap(Map map) {
    return IssuesModel(
      shortDescription: map['shortDescription'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      reportedTime: map['reportedTime'],
      images: map['images'],
      uid: map['uid'],
    );
  }

  factory IssuesModel.fromQueryDocument(QueryDocumentSnapshot doc) {
    return IssuesModel(
      shortDescription: doc['shortDescription'],
      latitude: doc['latitude'],
      longitude: doc['longitude'],
      reportedTime: doc['reportedTime'],
      images: doc['images'],
      uid: doc['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return ({
      "shortDescription": shortDescription,
      "latitude": latitude,
      "longitude": longitude,
      "reportedTime": reportedTime,
      "images": images,
      "uid": uid,
    });
  }
}
