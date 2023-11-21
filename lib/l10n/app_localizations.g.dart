import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.g.dart';
import 'app_localizations_fr.g.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.g.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('fr')];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'CPM'**
  String get app_name;

  /// No description provided for @app_name_full.
  ///
  /// In en, this message translates to:
  /// **'Cinema Project Manager'**
  String get app_name_full;

  /// No description provided for @navigation_projects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get navigation_projects;

  /// No description provided for @navigation_members.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get navigation_members;

  /// No description provided for @navigation_locations.
  ///
  /// In en, this message translates to:
  /// **'Locations'**
  String get navigation_locations;

  /// No description provided for @navigation_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navigation_settings;

  /// No description provided for @login_username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get login_username;

  /// No description provided for @login_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get login_password;

  /// No description provided for @login_log_in.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login_log_in;

  /// No description provided for @login_log_out.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get login_log_out;

  /// No description provided for @projects_project.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, zero{No projects} one{Project} other{Projects}}'**
  String projects_project(num count);

  /// No description provided for @projects_movie.
  ///
  /// In en, this message translates to:
  /// **'Movie'**
  String get projects_movie;

  /// No description provided for @projects_series.
  ///
  /// In en, this message translates to:
  /// **'Series'**
  String get projects_series;

  /// No description provided for @projects_episode.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, zero{No episodes} one{Episode} other{Episodes}}'**
  String projects_episode(num count);

  /// No description provided for @projects_sequence.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, zero{No sequences} one{Sequence} other{Sequences}}'**
  String projects_sequence(num count);

  /// No description provided for @projects_shot.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, zero{No shots} one{Shot} other{Shots}}'**
  String projects_shot(num count);

  /// No description provided for @projects_shots_value.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, zero{No shot value} one{Value} other{Values}}'**
  String projects_shots_value(num count);

  /// No description provided for @projects_shots_value_full.
  ///
  /// In en, this message translates to:
  /// **'Full'**
  String get projects_shots_value_full;

  /// No description provided for @projects_shots_value_medium_full.
  ///
  /// In en, this message translates to:
  /// **'Medium full'**
  String get projects_shots_value_medium_full;

  /// No description provided for @projects_shots_value_cowboy.
  ///
  /// In en, this message translates to:
  /// **'Cowboy'**
  String get projects_shots_value_cowboy;

  /// No description provided for @projects_shots_value_medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get projects_shots_value_medium;

  /// No description provided for @projects_shots_value_medium_closeup.
  ///
  /// In en, this message translates to:
  /// **'Medium closeup'**
  String get projects_shots_value_medium_closeup;

  /// No description provided for @projects_shots_value_closeup.
  ///
  /// In en, this message translates to:
  /// **'Closeup'**
  String get projects_shots_value_closeup;

  /// No description provided for @projects_shots_value_extreme_closeup.
  ///
  /// In en, this message translates to:
  /// **'Extreme closeup'**
  String get projects_shots_value_extreme_closeup;

  /// No description provided for @projects_shots_value_insert.
  ///
  /// In en, this message translates to:
  /// **'Insert'**
  String get projects_shots_value_insert;

  /// No description provided for @projects_shots_value_sequence.
  ///
  /// In en, this message translates to:
  /// **'Sequence'**
  String get projects_shots_value_sequence;

  /// No description provided for @projects_shots_value_landscape.
  ///
  /// In en, this message translates to:
  /// **'Landscape'**
  String get projects_shots_value_landscape;

  /// No description provided for @projects_shots_value_drone.
  ///
  /// In en, this message translates to:
  /// **'Drone'**
  String get projects_shots_value_drone;

  /// No description provided for @projects_shots_value_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get projects_shots_value_other;

  /// No description provided for @projects_links.
  ///
  /// In en, this message translates to:
  /// **'Links'**
  String get projects_links;

  /// No description provided for @projects_details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get projects_details;

  /// No description provided for @projects_no_title.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get projects_no_title;

  /// No description provided for @projects_no_description.
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get projects_no_description;

  /// No description provided for @projects_no_dates.
  ///
  /// In en, this message translates to:
  /// **'No dates'**
  String get projects_no_dates;

  /// No description provided for @projects_no_director.
  ///
  /// In en, this message translates to:
  /// **'No director'**
  String get projects_no_director;

  /// No description provided for @projects_no_writer.
  ///
  /// In en, this message translates to:
  /// **'No writer'**
  String get projects_no_writer;

  /// No description provided for @projects_no_links.
  ///
  /// In en, this message translates to:
  /// **'No links'**
  String get projects_no_links;

  /// No description provided for @projects_no_location.
  ///
  /// In en, this message translates to:
  /// **'No location'**
  String get projects_no_location;

  /// No description provided for @projects_no_name.
  ///
  /// In en, this message translates to:
  /// **'Unnamed'**
  String get projects_no_name;

  /// No description provided for @projects_no_value.
  ///
  /// In en, this message translates to:
  /// **'No value'**
  String get projects_no_value;

  /// No description provided for @schedule_schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule_schedule;

  /// No description provided for @members_members.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, zero{No members} one{Member} other{Members}}'**
  String members_members(num count);

  /// No description provided for @locations_location.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, zero{No locations} one{Location} other{Locations}}'**
  String locations_location(num count);

  /// No description provided for @settings_account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settings_account;

  /// No description provided for @settings_user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get settings_user;

  /// No description provided for @settings_log_out.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get settings_log_out;

  /// No description provided for @settings_log_out_description.
  ///
  /// In en, this message translates to:
  /// **'Log out of {appName}'**
  String settings_log_out_description(Object appName);

  /// No description provided for @settings_appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settings_appearance;

  /// No description provided for @settings_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settings_theme;

  /// No description provided for @settings_theme_system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settings_theme_system;

  /// No description provided for @settings_theme_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settings_theme_light;

  /// No description provided for @settings_theme_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settings_theme_dark;

  /// No description provided for @settings_dynamic_theming.
  ///
  /// In en, this message translates to:
  /// **'Dynamic theming'**
  String get settings_dynamic_theming;

  /// No description provided for @settings_dynamic_theming_description.
  ///
  /// In en, this message translates to:
  /// **'Generate colors from your background'**
  String get settings_dynamic_theming_description;

  /// No description provided for @settings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// No description provided for @settings_language_restart.
  ///
  /// In en, this message translates to:
  /// **'Please restart the app for the changes to take effect.'**
  String get settings_language_restart;

  /// No description provided for @settings_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settings_about;

  /// No description provided for @settings_studiorvandco.
  ///
  /// In en, this message translates to:
  /// **'Studio Rv & Co'**
  String get settings_studiorvandco;

  /// No description provided for @settings_studiorvandco_description.
  ///
  /// In en, this message translates to:
  /// **'Visit our website'**
  String get settings_studiorvandco_description;

  /// No description provided for @settings_github.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get settings_github;

  /// No description provided for @settings_github_description.
  ///
  /// In en, this message translates to:
  /// **'Take a look at the source code'**
  String get settings_github_description;

  /// No description provided for @settings_licence.
  ///
  /// In en, this message translates to:
  /// **'License'**
  String get settings_licence;

  /// No description provided for @settings_licence_description.
  ///
  /// In en, this message translates to:
  /// **'AGPL-3.0'**
  String get settings_licence_description;

  /// No description provided for @button_add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get button_add;

  /// No description provided for @button_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get button_edit;

  /// No description provided for @button_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get button_delete;

  /// No description provided for @button_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get button_cancel;

  /// No description provided for @menu_add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get menu_add;

  /// No description provided for @menu_open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get menu_open;

  /// No description provided for @menu_move_up.
  ///
  /// In en, this message translates to:
  /// **'Move up'**
  String get menu_move_up;

  /// No description provided for @menu_move_down.
  ///
  /// In en, this message translates to:
  /// **'Move down'**
  String get menu_move_down;

  /// No description provided for @menu_call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get menu_call;

  /// No description provided for @menu_message.
  ///
  /// In en, this message translates to:
  /// **'Send a message'**
  String get menu_message;

  /// No description provided for @menu_email.
  ///
  /// In en, this message translates to:
  /// **'Send an email'**
  String get menu_email;

  /// No description provided for @menu_map.
  ///
  /// In en, this message translates to:
  /// **'See on map'**
  String get menu_map;

  /// No description provided for @menu_edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get menu_edit;

  /// No description provided for @menu_delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get menu_delete;

  /// No description provided for @item_project.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, zero{projects} one{project} other{projects}}'**
  String item_project(num count);

  /// No description provided for @item_episode.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, zero{episodes} one{episode} other{episodes}}'**
  String item_episode(num count);

  /// No description provided for @item_sequence.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, zero{sequences} one{sequence} other{sequences}}'**
  String item_sequence(num count);

  /// No description provided for @item_shot.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, zero{shots} one{shot} other{shots}}'**
  String item_shot(num count);

  /// No description provided for @item_member.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, zero{members} one{member} other{members}}'**
  String item_member(num count);

  /// No description provided for @item_location.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, zero{locations} one{location} other{locations}}'**
  String item_location(num count);

  /// No description provided for @placeholder_empty.
  ///
  /// In en, this message translates to:
  /// **'There are no {item}'**
  String placeholder_empty(Object item, String sex);

  /// No description provided for @dialog_log_out.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to log out?'**
  String get dialog_log_out;

  /// No description provided for @dialog_add_item.
  ///
  /// In en, this message translates to:
  /// **'New {item}'**
  String dialog_add_item(Object item, String sex);

  /// No description provided for @dialog_edit_item.
  ///
  /// In en, this message translates to:
  /// **'Edit {item}'**
  String dialog_edit_item(Object item);

  /// No description provided for @dialog_delete_item_confirmation.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete this {item}?'**
  String dialog_delete_item_confirmation(Object item, String sex);

  /// No description provided for @dialog_delete_cannot_be_undone.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get dialog_delete_cannot_be_undone;

  /// No description provided for @dialog_field_title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get dialog_field_title;

  /// No description provided for @dialog_field_description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get dialog_field_description;

  /// No description provided for @dialog_field_director.
  ///
  /// In en, this message translates to:
  /// **'Director'**
  String get dialog_field_director;

  /// No description provided for @dialog_field_writer.
  ///
  /// In en, this message translates to:
  /// **'Writer'**
  String get dialog_field_writer;

  /// No description provided for @dialog_field_start_time.
  ///
  /// In en, this message translates to:
  /// **'Pick a start time'**
  String get dialog_field_start_time;

  /// No description provided for @dialog_field_end_time.
  ///
  /// In en, this message translates to:
  /// **'Pick an end time'**
  String get dialog_field_end_time;

  /// No description provided for @dialog_field_value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get dialog_field_value;

  /// No description provided for @dialog_field_label.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get dialog_field_label;

  /// No description provided for @dialog_field_url.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get dialog_field_url;

  /// No description provided for @dialog_field_first_name.
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get dialog_field_first_name;

  /// No description provided for @dialog_field_last_name.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get dialog_field_last_name;

  /// No description provided for @dialog_field_phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get dialog_field_phone;

  /// No description provided for @dialog_field_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get dialog_field_email;

  /// No description provided for @dialog_field_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get dialog_field_name;

  /// No description provided for @dialog_field_position.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get dialog_field_position;

  /// No description provided for @snack_bar_add_success_item.
  ///
  /// In en, this message translates to:
  /// **'The {item} was added successfully.'**
  String snack_bar_add_success_item(Object item, String sex);

  /// No description provided for @snack_bar_add_fail_item.
  ///
  /// In en, this message translates to:
  /// **'The {item} could not be added.'**
  String snack_bar_add_fail_item(Object item, String sex);

  /// No description provided for @snack_bar_delete_success_item.
  ///
  /// In en, this message translates to:
  /// **'The {item} was deleted successfully.'**
  String snack_bar_delete_success_item(Object item, String sex);

  /// No description provided for @snack_bar_delete_fail_item.
  ///
  /// In en, this message translates to:
  /// **'The {item} could not be deleted.'**
  String snack_bar_delete_fail_item(Object item, String sex);

  /// No description provided for @snack_bar_edit_success_item.
  ///
  /// In en, this message translates to:
  /// **'The {item} was edited successfully.'**
  String snack_bar_edit_success_item(Object item, String sex);

  /// No description provided for @snack_bar_edit_fail_item.
  ///
  /// In en, this message translates to:
  /// **'The {item} could not be edited.'**
  String snack_bar_edit_fail_item(Object item, String sex);

  /// No description provided for @error_error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error_error;

  /// No description provided for @error_login.
  ///
  /// In en, this message translates to:
  /// **'Wrong username or password.'**
  String get error_login;

  /// No description provided for @error_invalid_phone.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone'**
  String get error_invalid_phone;

  /// No description provided for @error_invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get error_invalid_email;

  /// No description provided for @error_invalid_url.
  ///
  /// In en, this message translates to:
  /// **'Invalid URL'**
  String get error_invalid_url;

  /// No description provided for @error_required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get error_required;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError('AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
