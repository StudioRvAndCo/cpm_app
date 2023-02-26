import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/project.dart';

class MemberDialog extends StatefulWidget {
  const MemberDialog({super.key, required this.edit, this.name, this.telephone, this.image});

  final String? name;
  final String? telephone;
  final Image? image;
  final bool edit;

  @override
  State<StatefulWidget> createState() => _MemberDialogState(edit: edit, name: name, telephone: telephone, image: image);
}

class _MemberDialogState extends State<MemberDialog> {
  _MemberDialogState({required this.edit, this.name, this.telephone, this.image});

  String? name;
  Image? image;
  String? telephone;
  final bool edit;

  late String title;
  late String subtitle;

  @override
  void initState() {
    title = edit ? 'Edit Member' : 'New Member';
    subtitle = edit ? 'Edit a member.' : 'Create a new member.';
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Padding(
        padding: const EdgeInsets.all(6.8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Text>[
                Text(title),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 12),
                )
              ],
            ),
            IconButton(
              style: IconButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              icon: Builder(builder: (BuildContext context) {
                if (image != null) {
                  return SizedBox(height: 80, width: 80, child: image!);
                } else {
                  return const Icon(Icons.add_a_photo_outlined, size: 80);
                }
              }),
              onPressed: () async {
                final FilePickerResult? result =
                    await FilePicker.platform.pickFiles(type: FileType.image, lockParentWindow: true);
                if (result != null) {
                  final File file = File(result.files.single.path!);
                  setState(() {
                    image = Image.file(file);
                  });
                }
              },
            ),
          ],
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 330,
                  child: TextFormField(
                    initialValue: name,
                    maxLength: 64,
                    decoration: const InputDecoration(labelText: 'Name', border: OutlineInputBorder(), isDense: true),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 330,
                  child: TextFormField(
                    initialValue: telephone,
                    maxLength: 12,
                    decoration:
                        const InputDecoration(labelText: 'Telephone', border: OutlineInputBorder(), isDense: true),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('OK'))
                ],
              )
            ]),
          ),
        )
      ],
    );
  }
}
