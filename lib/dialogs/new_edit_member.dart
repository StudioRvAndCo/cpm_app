import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../models/member.dart';

class MemberDialog extends StatefulWidget {
  const MemberDialog({super.key, required this.edit, this.id, this.firstName, this.lastName, this.phone, this.image});

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final Image? image;
  final bool edit;

  @override
  State<StatefulWidget> createState() => _MemberDialogState();
}

class _MemberDialogState extends State<MemberDialog> {
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController phoneController;
  Image? image;

  late String title;
  late String subtitle;

  @override
  void initState() {
    firstNameController = TextEditingController(text: widget.firstName);
    lastNameController = TextEditingController(text: widget.lastName);
    phoneController = TextEditingController(text: widget.phone);
    image = widget.image;
    title = widget.edit
        ? '${'edit.upper'.tr()} ${widget.firstName!}'
        : '${'new.masc.eau.upper'.tr()} ${'members.member.lower'.plural(1)}';
    subtitle = widget.edit
        ? '${'edit.upper'.tr()} ${'articles.this.masc.lower'.plural(1)} ${'members.member.lower'.plural(1)}.'
        : '${'add.upper'.tr()} ${'articles.a.masc.lower'.tr()} ${'new.masc.eau.lower'.tr()} ${'members.member.lower'.plural(1)}.';
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
              style: IconButton.styleFrom(shape: const CircleBorder()),
              icon: SizedBox(
                width: 100,
                height: 100,
                child: Builder(builder: (BuildContext context) {
                  if (image != null) {
                    return Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, image: DecorationImage(image: image!.image, fit: BoxFit.cover)));
                  } else {
                    return const Icon(
                      Icons.add_a_photo_outlined,
                      size: 80,
                    );
                  }
                }),
              ),
              onPressed: () async {
                final FilePickerResult? result =
                    await FilePicker.platform.pickFiles(type: FileType.image, lockParentWindow: true, withData: kIsWeb);
                if (result != null) {
                  Image imgRes;
                  if (kIsWeb) {
                    imgRes = Image.memory(result.files.single.bytes!);
                  } else {
                    imgRes = Image.file(File(result.files.single.path!));
                  }
                  setState(() {
                    image = imgRes;
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
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 330,
                child: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: firstNameController,
                  builder: (BuildContext context, TextEditingValue value, __) {
                    return TextField(
                      autofocus: true,
                      controller: firstNameController,
                      maxLength: 64,
                      decoration: InputDecoration(
                          labelText: 'attributes.firstname.upper'.tr(),
                          errorText: firstNameController.text.trim().isEmpty ? 'error.empty'.tr() : null,
                          border: const OutlineInputBorder(),
                          isDense: true),
                      onEditingComplete: submit,
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 330,
                child: TextField(
                    controller: lastNameController,
                    maxLength: 64,
                    decoration: InputDecoration(
                        labelText: 'attributes.lastname.upper'.tr(), border: const OutlineInputBorder(), isDense: true),
                    onEditingComplete: () {
                      submit();
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 330,
                child: TextField(
                    controller: phoneController,
                    maxLength: 12,
                    decoration: InputDecoration(
                        labelText: 'attributes.phone.upper'.tr(), border: const OutlineInputBorder(), isDense: true),
                    onEditingComplete: () {
                      submit();
                    }),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('cancel'.tr())),
                TextButton(onPressed: submit, child: Text('confirm'.tr()))
              ],
            )
          ]),
        )
      ],
    );
  }

  void submit() {
    if (firstNameController.text.trim().isEmpty) {
      return;
    }
    final Member newMember = Member(
        id: widget.id ?? '',
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        phone: phoneController.text);
    Navigator.pop(context, newMember);
  }
}
