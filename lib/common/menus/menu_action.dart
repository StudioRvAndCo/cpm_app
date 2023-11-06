import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

enum MenuAction {
  edit(Icons.edit),
  delete(Icons.delete),
  call(Icons.phone, _call),
  message(Icons.message, _message),
  email(Icons.mail, _email),
  map(Icons.map, _map),
  ;

  final IconData icon;
  final Function(String)? function;

  const MenuAction(this.icon, [this.function]);

  static void _call(String phone) {
    launchUrlString('tel:$phone');
  }

  static void _message(String message) {
    launchUrlString('sms:$message');
  }

  static void _email(String email) {
    launchUrlString('mailto:$email');
  }

  static void _map(String position) {
    MapsLauncher.launchQuery(position);
  }

  static List<MenuAction> get defaults => [
        MenuAction.edit,
        MenuAction.delete,
      ];

  PopupMenuItem<MenuAction> get popupMenuItem {
    return PopupMenuItem<MenuAction>(
      value: this,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        contentPadding: Paddings.custom.zero,
      ),
    );
  }

  String get title {
    switch (this) {
      case edit:
        return localizations.menu_edit;
      case delete:
        return localizations.menu_delete;
      case MenuAction.call:
        return localizations.menu_call;
      case MenuAction.message:
        return localizations.menu_message;
      case MenuAction.email:
        return localizations.menu_email;
      case MenuAction.map:
        return localizations.menu_map;
    }
  }
}
