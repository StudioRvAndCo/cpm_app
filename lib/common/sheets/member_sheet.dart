import 'package:cpm/common/placeholders/custom_placeholder.dart';
import 'package:cpm/models/member/member.dart';
import 'package:cpm/providers/members/members.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MemberSheet extends ConsumerStatefulWidget {
  const MemberSheet({super.key});

  @override
  ConsumerState<MemberSheet> createState() => _MemberSheetState();
}

class _MemberSheetState extends ConsumerState<MemberSheet> with SingleTickerProviderStateMixin {
  final formKey = GlobalKey<FormState>();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();

  @override
  void initState() {
    super.initState();

    final member = ref.read(currentMemberProvider).value;
    firstName.text = member?.firstName ?? '';
    lastName.text = member?.lastName ?? '';
    phone.text = member?.phone ?? '';
    email.text = member?.email ?? '';
  }

  void _onSubmitted(Member member) {
    if (firstName.text == member.firstName &&
            lastName.text == member.lastName &&
            phone.text == member.phone &&
            email.text == member.email ||
        !formKey.currentState!.validate()) return;

    _edit(member);
  }

  void _edit(Member member) {
    member.firstName = firstName.text;
    member.lastName = lastName.text;
    member.phone = phone.text;
    member.email = email.text;

    ref.read(membersProvider.notifier).edit(member);
    ref.read(currentMemberProvider.notifier).set(member);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentMemberProvider).when(
      data: (member) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Focus(
                      onFocusChange: (hasFocus) => !hasFocus ? _onSubmitted(member) : null,
                      child: TextField(
                        controller: firstName,
                        textInputAction: TextInputAction.next,
                        style: Theme.of(context).textTheme.titleMedium,
                        decoration: InputDecoration.collapsed(
                          hintText: localizations.dialog_field_first_name,
                        ),
                        onSubmitted: (_) => _onSubmitted(member),
                      ),
                    ),
                  ),
                  Padding(padding: Paddings.padding4.horizontal),
                  Flexible(
                    child: Focus(
                      onFocusChange: (hasFocus) => !hasFocus ? _onSubmitted(member) : null,
                      child: TextField(
                        controller: lastName,
                        textInputAction: TextInputAction.next,
                        style: Theme.of(context).textTheme.titleMedium,
                        decoration: InputDecoration.collapsed(
                          hintText: localizations.dialog_field_last_name,
                        ),
                        onSubmitted: (_) => _onSubmitted(member),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(padding: Paddings.padding8.vertical),
              Focus(
                onFocusChange: (hasFocus) => !hasFocus ? _onSubmitted(member) : null,
                child: TextFormField(
                  controller: phone,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration.collapsed(
                    hintText: localizations.dialog_field_phone,
                  ),
                  validator: validatePhone,
                  onFieldSubmitted: (_) => _onSubmitted(member),
                ),
              ),
              Padding(padding: Paddings.padding8.vertical),
              Focus(
                onFocusChange: (hasFocus) => !hasFocus ? _onSubmitted(member) : null,
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration.collapsed(
                    hintText: localizations.dialog_field_email,
                  ),
                  validator: validateEmail,
                  onFieldSubmitted: (_) => _onSubmitted(member),
                ),
              ),
            ],
          ),
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return CustomPlaceholder.error();
      },
      loading: () {
        return CustomPlaceholder.loading();
      },
    );
  }
}
