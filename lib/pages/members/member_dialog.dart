import 'package:cpm/models/member/member.dart';
import 'package:flutter/material.dart';

class MemberDialog extends StatefulWidget {
  const MemberDialog({super.key, this.member});

  final Member? member;

  @override
  State<StatefulWidget> createState() => _MemberDialogState();
}

class _MemberDialogState extends State<MemberDialog> {
  late final bool edit;

  late final String title;

  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController phoneController;

  @override
  void initState() {
    super.initState();

    edit = widget.member != null;

    title = edit ? 'edit.upper' : 'new.masc.eau.upper';

    firstNameController = TextEditingController(text: widget.member?.firstName);
    lastNameController = TextEditingController(text: widget.member?.lastName);
    phoneController = TextEditingController(text: widget.member?.phone);
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
              ],
            ),
          ],
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
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
                          labelText: 'attributes.firstname.upper',
                          errorText: firstNameController.text.trim().isEmpty ? 'error.empty' : null,
                          border: const OutlineInputBorder(),
                          isDense: true,
                        ),
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
                      labelText: 'attributes.lastname.upper',
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                    onEditingComplete: () {
                      submit();
                    },
                  ),
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
                      labelText: 'attributes.phone.upper',
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                    onEditingComplete: () {
                      submit();
                    },
                  ),
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
                    child: Text('cancel'),
                  ),
                  TextButton(onPressed: submit, child: Text('confirm')),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void submit() {
    final Member member = edit
        ? Member(
            id: widget.member!.id,
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            phone: phoneController.text,
          )
        : Member.insert(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            phone: phoneController.text,
          );

    Navigator.pop(context, member);
  }
}
