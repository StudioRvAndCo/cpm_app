import 'package:intl/intl.dart' as intl;

import 'app_localizations.g.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_name => 'CPM';

  @override
  String get app_name_full => 'Cinema Project Manager';

  @override
  String get navigation_projects => 'Projects';

  @override
  String get navigation_members => 'Members';

  @override
  String get navigation_locations => 'Locations';

  @override
  String get navigation_settings => 'Settings';

  @override
  String get login_username => 'Username';

  @override
  String get login_password => 'Password';

  @override
  String get login_log_in => 'Log in';

  @override
  String get login_log_out => 'Log out';

  @override
  String projects_project(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Projects',
      one: 'Project',
      zero: 'No projects',
    );
    return '$_temp0';
  }

  @override
  String get projects_movie => 'Movie';

  @override
  String get projects_series => 'Series';

  @override
  String projects_episode(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Episodes',
      one: 'Episode',
      zero: 'No episodes',
    );
    return '$_temp0';
  }

  @override
  String projects_sequence(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Sequences',
      one: 'Sequence',
      zero: 'No sequences',
    );
    return '$_temp0';
  }

  @override
  String projects_shot(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Shots',
      one: 'Shot',
      zero: 'No shots',
    );
    return '$_temp0';
  }

  @override
  String projects_shots_value(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Values',
      one: 'Value',
      zero: 'No shot value',
    );
    return '$_temp0';
  }

  @override
  String get projects_shots_value_full => 'Full';

  @override
  String get projects_shots_value_medium_full => 'Medium full';

  @override
  String get projects_shots_value_cowboy => 'Cowboy';

  @override
  String get projects_shots_value_medium => 'Medium';

  @override
  String get projects_shots_value_medium_closeup => 'Medium closeup';

  @override
  String get projects_shots_value_closeup => 'Closeup';

  @override
  String get projects_shots_value_extreme_closeup => 'Extreme closeup';

  @override
  String get projects_shots_value_insert => 'Insert';

  @override
  String get projects_shots_value_sequence => 'Sequence';

  @override
  String get projects_shots_value_landscape => 'Landscape';

  @override
  String get projects_shots_value_drone => 'Drone';

  @override
  String get projects_shots_value_other => 'Other';

  @override
  String get projects_links => 'Links';

  @override
  String get projects_details => 'Details';

  @override
  String get projects_no_title => 'Untitled';

  @override
  String get projects_no_description => 'No description';

  @override
  String get projects_no_dates => 'No dates';

  @override
  String get projects_no_director => 'No director';

  @override
  String get projects_no_writer => 'No writer';

  @override
  String get projects_no_links => 'No links';

  @override
  String get projects_no_location => 'No location';

  @override
  String get projects_no_name => 'Unnamed';

  @override
  String get projects_no_value => 'No value';

  @override
  String get schedule_schedule => 'Schedule';

  @override
  String members_members(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Members',
      one: 'Member',
      zero: 'No members',
    );
    return '$_temp0';
  }

  @override
  String locations_location(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Locations',
      one: 'Location',
      zero: 'No locations',
    );
    return '$_temp0';
  }

  @override
  String get settings_account => 'Account';

  @override
  String get settings_user => 'User';

  @override
  String get settings_log_out => 'Log out';

  @override
  String settings_log_out_description(Object appName) {
    return 'Log out of $appName';
  }

  @override
  String get settings_appearance => 'Appearance';

  @override
  String get settings_theme => 'Theme';

  @override
  String get settings_theme_system => 'System';

  @override
  String get settings_theme_light => 'Light';

  @override
  String get settings_theme_dark => 'Dark';

  @override
  String get settings_dynamic_theming => 'Dynamic theming';

  @override
  String get settings_dynamic_theming_description => 'Generate colors from your background';

  @override
  String get settings_language => 'Language';

  @override
  String get settings_language_restart => 'Please restart the app for the changes to take effect.';

  @override
  String get settings_about => 'About';

  @override
  String get settings_studiorvandco => 'Studio Rv & Co';

  @override
  String get settings_studiorvandco_description => 'Visit our website';

  @override
  String get settings_github => 'GitHub';

  @override
  String get settings_github_description => 'Take a look at the source code';

  @override
  String get settings_licence => 'License';

  @override
  String get settings_licence_description => 'AGPL-3.0';

  @override
  String get button_add => 'Add';

  @override
  String get button_edit => 'Edit';

  @override
  String get button_delete => 'Delete';

  @override
  String get button_cancel => 'Cancel';

  @override
  String get menu_add => 'Add';

  @override
  String get menu_open => 'Open';

  @override
  String get menu_move_up => 'Move up';

  @override
  String get menu_move_down => 'Move down';

  @override
  String get menu_call => 'Call';

  @override
  String get menu_message => 'Send a message';

  @override
  String get menu_email => 'Send an email';

  @override
  String get menu_map => 'See on map';

  @override
  String get menu_edit => 'Edit';

  @override
  String get menu_delete => 'Delete';

  @override
  String item_project(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'projects',
      one: 'project',
      zero: 'projects',
    );
    return '$_temp0';
  }

  @override
  String item_episode(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'episodes',
      one: 'episode',
      zero: 'episodes',
    );
    return '$_temp0';
  }

  @override
  String item_sequence(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'sequences',
      one: 'sequence',
      zero: 'sequences',
    );
    return '$_temp0';
  }

  @override
  String item_shot(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'shots',
      one: 'shot',
      zero: 'shots',
    );
    return '$_temp0';
  }

  @override
  String item_member(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'members',
      one: 'member',
      zero: 'members',
    );
    return '$_temp0';
  }

  @override
  String item_location(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'locations',
      one: 'location',
      zero: 'locations',
    );
    return '$_temp0';
  }

  @override
  String placeholder_empty(Object item, String sex) {
    return 'There are no $item';
  }

  @override
  String get fab_create => 'Create';

  @override
  String get fab_import => 'Import';

  @override
  String get dialog_log_out => 'Do you really want to log out?';

  @override
  String dialog_add_item(Object item, String sex) {
    return 'New $item';
  }

  @override
  String dialog_edit_item(Object item) {
    return 'Edit $item';
  }

  @override
  String dialog_delete_item_confirmation(Object item, String sex) {
    return 'Do you really want to delete this $item?';
  }

  @override
  String get dialog_delete_cannot_be_undone => 'This action cannot be undone.';

  @override
  String get dialog_field_title => 'Title';

  @override
  String get dialog_field_description => 'Description';

  @override
  String get dialog_field_director => 'Director';

  @override
  String get dialog_field_writer => 'Writer';

  @override
  String get dialog_field_start_time => 'Pick a start time';

  @override
  String get dialog_field_end_time => 'Pick an end time';

  @override
  String get dialog_field_value => 'Value';

  @override
  String get dialog_field_label => 'Label';

  @override
  String get dialog_field_url => 'URL';

  @override
  String get dialog_field_first_name => 'First name';

  @override
  String get dialog_field_last_name => 'Last name';

  @override
  String get dialog_field_phone => 'Phone';

  @override
  String get dialog_field_email => 'Email';

  @override
  String get dialog_field_name => 'Name';

  @override
  String get dialog_field_position => 'Position';

  @override
  String snack_bar_add_success_item(Object item, String sex) {
    return 'The $item was added successfully.';
  }

  @override
  String snack_bar_add_fail_item(Object item, String sex) {
    return 'The $item could not be added.';
  }

  @override
  String snack_bar_import_item(Object item, String sex) {
    return 'The $item is being imported, it can take a few seconds.';
  }

  @override
  String snack_bar_delete_success_item(Object item, String sex) {
    return 'The $item was deleted successfully.';
  }

  @override
  String snack_bar_delete_fail_item(Object item, String sex) {
    return 'The $item could not be deleted.';
  }

  @override
  String snack_bar_edit_success_item(Object item, String sex) {
    return 'The $item was edited successfully.';
  }

  @override
  String snack_bar_edit_fail_item(Object item, String sex) {
    return 'The $item could not be edited.';
  }

  @override
  String get error_error => 'Error';

  @override
  String get error_login => 'Wrong username or password.';

  @override
  String get error_invalid_phone => 'Invalid phone';

  @override
  String get error_invalid_email => 'Invalid email';

  @override
  String get error_invalid_url => 'Invalid URL';

  @override
  String get error_required => 'Required';
}
