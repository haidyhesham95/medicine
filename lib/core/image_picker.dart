import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage {
  static PickImage get init => PickImage._();

  PickImage._();

  Future imagePickerDialog(
      {Function(File file,String name)? onSubmit,
      bool withCrop = false,
      bool isMulti = false,
      Function(List<File> file,List<String> names)? onSubmitMulti,
      required BuildContext context}) async {
    ImagePicker pick = ImagePicker();
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          cancelButton: CupertinoButton(
            child: const Text('cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            CupertinoButton(
              child: const Row(
                children: <Widget>[
                  Icon(
                    CupertinoIcons.photo_camera_solid,
                  ),
                  SizedBox(width: 20),
                  Text('camera'),
                ],
              ),
              onPressed: () async {
                XFile? pickedFile = await pick.pickImage(
                    source: ImageSource.camera, maxWidth: 400);
                if (pickedFile != null) {
                  Navigator.pop(context);
                  if (onSubmit != null) onSubmit(File(pickedFile.path),pickedFile.name);
                  if (onSubmitMulti != null) {
                    onSubmitMulti([File(pickedFile.path)],[pickedFile.name]);
                  }
                }
              },
            ),
            CupertinoButton(
              child: const Row(
                children: <Widget>[
                  Icon(Icons.insert_photo),
                  SizedBox(width: 20),
                  Text('gallery'),
                ],
              ),
              onPressed: () async {
                if (isMulti) {
                  List<XFile>? pickedFile =
                      await pick.pickMultiImage(maxWidth: 400);
                  if (pickedFile != null) {
                    if (onSubmitMulti != null) {
                      List<File> files = [];
                      List<String> names = [];
                      for (int i = 0; i < pickedFile.length; i++) {
                        files.add(File(pickedFile[i].path));
                        names.add(pickedFile[i].name);
                      }
                      onSubmitMulti(files,names);
                    }
                    if (onSubmit != null) onSubmit(File(pickedFile[0].path),pickedFile[0].name);
                  }
                } else {
                  XFile? pickedFile = await pick.pickImage(
                      source: ImageSource.gallery, maxWidth: 400);
                  if (pickedFile != null) {
                    Navigator.pop(context);
                    if (onSubmit != null) onSubmit(File(pickedFile.path),pickedFile.name);
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}
