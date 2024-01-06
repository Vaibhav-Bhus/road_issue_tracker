import 'package:image_picker/image_picker.dart';

Future<List<XFile>?> imagePickerUtil() async {
  final List<XFile> selectedImages = await ImagePicker().pickMultiImage();
  if (selectedImages.isNotEmpty) {
    return selectedImages;
  }
  return null;
}
