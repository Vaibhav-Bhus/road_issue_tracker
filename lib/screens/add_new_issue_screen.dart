import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test_aqua_cart/models/issue_model.dart';
import 'package:test_aqua_cart/services/auth_services.dart';
import 'package:test_aqua_cart/services/issue_service.dart';
import 'package:test_aqua_cart/services/location_service.dart';
import 'package:test_aqua_cart/utils/image_picker.dart';
import 'package:test_aqua_cart/widgets/custom_toast.dart';
import 'package:test_aqua_cart/widgets/vb_button.dart';
import 'package:test_aqua_cart/widgets/vb_carousel_slide.dart';
import 'package:test_aqua_cart/widgets/vb_form_field.dart';

class AddNewIssueScreen extends StatefulWidget {
  const AddNewIssueScreen({super.key});

  @override
  State<AddNewIssueScreen> createState() => _AddNewIssueScreenState();
}

class _AddNewIssueScreenState extends State<AddNewIssueScreen> {
  final TextEditingController _shortDescriptionController =
      TextEditingController();
  bool loading = false;
  List<String> selectedImageUrls = [];
  Future<void> selectImages() async {
    await imagePickerUtil().then((imageList) async {
      if (imageList != null) {
        List<String> newImageUrls =
            await context.read<IssuesService>().uploadIssueImages(imageList);
        selectedImageUrls.addAll(newImageUrls);
        log(selectedImageUrls.toString());
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.sp),
        child: Column(
          children: [
            VBFormField(
              controller: _shortDescriptionController,
              label: 'Short Description',
              enabled: true,
              hint: 'Road jam due to car accident',
              inputType: TextInputType.text,
              maxLines: 5,
              minLines: 3,
              margin: EdgeInsets.symmetric(horizontal: 25.sp),
            ),
            selectedImageUrls.isEmpty
                ? SizedBox(
                    height: 200.sp,
                  )
                : VBImageSlider(
                    imageUrls: selectedImageUrls,
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                VBButton(
                  width: 150.w,
                  onTap: () async {
                    await selectImages();
                  },
                  text: 'Add Images',
                  // dense: true,
                ),
                VBButton(
                  width: 150.w,

                  // dense: true,
                  text: 'Add an Issue',
                  onTap: () async {
                    if (_shortDescriptionController.text.trim().isEmpty) {
                      customToast('please fill the short description');
                    } else if (selectedImageUrls.isEmpty) {
                      customToast('please Select atleast 1 image');
                    } else {
                      setState(() {
                        loading = !loading;
                      });
                      await context
                          .read<LocationService>()
                          .checkForLocationPermission()
                          .then((status) async {
                        if (status) {
                          await context
                              .read<LocationService>()
                              .getCurrentLocation()
                              .then((position) async {
                            if (position != null) {
                              log("message");
                              await context
                                  .read<IssuesService>()
                                  .createNewIssue(
                                    IssuesModel(
                                      images: selectedImageUrls,
                                      latitude: position.latitude,
                                      longitude: position.longitude,
                                      shortDescription:
                                          _shortDescriptionController.text
                                              .trim(),
                                      reportedTime: Timestamp.now(),
                                      uid: context
                                          .read<AuthService>()
                                          .currentUser!
                                          .uid,
                                    ),
                                  )
                                  .then((value) {
                                if (value == 'success') {
                                  customToast('Issue Created successfully');
                                  setState(() {
                                    selectedImageUrls = [];
                                    _shortDescriptionController.clear();
                                    loading = !loading;
                                  });
                                }
                              });
                              setState(() {
                                loading = !loading;
                              });
                            } else {
                              setState(() {
                                loading = !loading;
                              });
                              customToast('unable to fetch current location');
                            }
                          });
                        } else {
                          setState(() {
                            loading = !loading;
                          });
                          customToast(
                              'Location Permission denied please manually allow from settings');
                        }
                      });
                    }
                  },
                  isLoading: loading,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
