import 'package:cpm/common/dialogs/model_dialog.dart';
import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/member/member.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddMemberDialog extends StatefulWidget {
  const AddMemberDialog({super.key});

  @override
  State<AddMemberDialog> createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends State<AddMemberDialog> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();

  void _cancel(BuildContext context) {
    context.pop();
  }

  void _add(BuildContext context) {
    context.pop(
      Member.insert(
        firstName: firstName.text,
        lastName: lastName.text,
        phone: phone.text,
        email: email.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModelDialog(
      cancel: () => _cancel(context),
      submit: () => _add(context),
      title: localizations.dialog_add_item(localizations.item_member, Gender.male.name),
      action: localizations.button_add,
      fields: [
        TextField(
          controller: firstName,
          textInputAction: TextInputAction.next,
          autofocus: true,
          decoration: InputDecoration(
            labelText: localizations.dialog_field_first_name,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
        ),
        Padding(padding: Paddings.padding8.vertical),
        TextField(
          controller: lastName,
          textInputAction: TextInputAction.next,
          autofocus: true,
          decoration: InputDecoration(
            labelText: localizations.dialog_field_last_name,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
        ),
        Padding(padding: Paddings.padding8.vertical),
        TextField(
          controller: phone,
          textInputAction: TextInputAction.next,
          autofocus: true,
          decoration: InputDecoration(
            labelText: localizations.dialog_field_phone,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
        ),
        Padding(padding: Paddings.padding8.vertical),
        TextField(
          controller: email,
          decoration: InputDecoration(
            labelText: localizations.dialog_field_email,
            border: const OutlineInputBorder(),
            isDense: true,
          ),
        ),
      ],
    );
  }
}
