import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import 'package:test_aqua_cart/models/issue_model.dart';

class IssuesService {
  final FirebaseStorage storage;
  final FirebaseFirestore firebaseFirestore;
  IssuesService({
    required this.storage,
    required this.firebaseFirestore,
  });
  Future<List<String>> uploadIssueImages(List<XFile> imageList) async {
    List<String> imageUrls = [];
    for (var imageFile in imageList) {
      Reference storageReference = storage
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}');
      storageReference.getDownloadURL();
      UploadTask uploadTask = storageReference.putFile(File(imageFile.path));

      await uploadTask.whenComplete(() => log('Image uploaded'));
      String imageUrl = await storageReference.getDownloadURL();
      imageUrls.add(imageUrl);
    }
    return imageUrls;
  }

  Future<String> createNewIssue(IssuesModel issuesModel) async =>
      await FirebaseFirestore.instance
          .collection('Issues')
          .doc(issuesModel.reportedTime.millisecondsSinceEpoch.toString())
          .set(issuesModel.toMap())
          .then((value) => 'scuccess');

  Stream<List<IssuesModel>> getAllNearbyIssues(
      BuildContext context, Position position) {
    GeoPoint center = GeoPoint(position.latitude, position.longitude);
    double lat = position.latitude;
    double lon = position.longitude;
    double lowerLat = center.latitude - (lat * 5);
    double upperLat = center.latitude + (lat * 5);
    return firebaseFirestore
        .collection('Issues')
        .where('latitude', isGreaterThanOrEqualTo: lowerLat)
        .where('latitude', isLessThanOrEqualTo: upperLat)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<IssuesModel> issuesList =
          _createIssueModelListFromQuerySnapshot(querySnapshot);

      // Filter by longitude in Dart code
      issuesList = issuesList.where((issue) {
        double lowerLon = center.longitude - (lon * 5);
        double upperLon = center.longitude + (lon * 5);
        return issue.longitude >= lowerLon && issue.longitude <= upperLon;
      }).toList();

      // Now, the issuesList is filtered based on both latitude and longitude
      return issuesList;
    });
  }

  List<IssuesModel> _createIssueModelListFromQuerySnapshot(
      QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) => IssuesModel.fromDocument(doc)).toList();
  }
}
