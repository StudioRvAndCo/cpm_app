import 'package:flutter/material.dart';

import '../widgets/member_list_item.dart';

class Members extends StatelessWidget {
  const Members({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
      children: const <Widget>[MemberListItem(), MemberListItem()],
    ));
  }
}
