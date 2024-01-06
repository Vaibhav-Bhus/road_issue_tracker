import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_aqua_cart/models/issue_model.dart';
import 'package:test_aqua_cart/utils/date_util.dart';
import 'package:test_aqua_cart/widgets/vb_carousel_slide.dart';

class IssueDetailsScreen extends StatefulWidget {
  final IssuesModel issuesModel;
  const IssueDetailsScreen({
    super.key,
    required this.issuesModel,
  });

  @override
  State<IssueDetailsScreen> createState() => _IssueDetailsScreenState();
}

class _IssueDetailsScreenState extends State<IssueDetailsScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _createMarkers() {
    Marker marker = Marker(
      markerId: MarkerId(widget.issuesModel.shortDescription),
      position:
          LatLng(widget.issuesModel.latitude, widget.issuesModel.longitude),
      infoWindow: InfoWindow(
        title: 'Location',
        snippet: 'ID: ${widget.issuesModel.shortDescription}',
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );
    return {marker};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Problem: ${widget.issuesModel.shortDescription}"),
            Text(
                "Reported Time: ${timestampToDateTimeString(widget.issuesModel.reportedTime)}"),
            VBImageSlider(
              imageUrls: widget.issuesModel.images,
            ),
            Expanded(
              // height: 200,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    widget.issuesModel.latitude,
                    widget.issuesModel.longitude,
                  ),
                  zoom: 10.0,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                markers: _createMarkers(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
