import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:test_aqua_cart/models/issue_model.dart';
import 'package:test_aqua_cart/services/issue_service.dart';
import 'package:test_aqua_cart/services/location_service.dart';
import 'package:test_aqua_cart/utils/date_util.dart';

class IssuesScreen extends StatefulWidget {
  const IssuesScreen({Key? key}) : super(key: key);

  @override
  State<IssuesScreen> createState() => _IssuesScreenState();
}

class _IssuesScreenState extends State<IssuesScreen> {
  Position? position;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  getLocation() async {
    position = await context.read<LocationService>().getCurrentLocation();
    setState(() {}); // Trigger a rebuild after obtaining the location
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<IssuesModel>>(
        stream: position != null
            ? context
                .read<IssuesService>()
                .getAllNearbyIssues(context, position!)
            : null,
        builder: (context, issueList) {
          if (issueList.hasError) {
            log(issueList.error.toString(), name: "Error here");
            return Container();
          }

          if (issueList.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (issueList.hasData && issueList.data != null) {
            return ListView.separated(
              itemBuilder: (context, index) {
                IssuesModel model = issueList.data![index];
                return ListTile(
                  onTap: () {
                    context.push('/homescreen/issuedetails', extra: model);
                  },
                  title: Text(model.shortDescription.toString()),
                  subtitle: Text(
                      "Reported Time: ${timestampToDateTimeString(model.reportedTime)}"),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10.sp,
                );
              },
              itemCount: issueList.data?.length ?? 0,
            );
          }

          return const Center(
            child: Text('No issues found.'),
          );
        },
      ),
    );
  }
}
