import 'package:flutter/cupertino.dart';

class MemberListItem extends StatefulWidget {
  const MemberListItem({super.key});

  @override
  State<MemberListItem> createState() => _MemberListItemState();
}

class _MemberListItemState extends State<MemberListItem> {
  @override
  Widget build(BuildContext context) {
    return Text('Member');
  }
}
