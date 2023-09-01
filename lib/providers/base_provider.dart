import 'package:cpm/services/select/select_sequence_location_service.dart';
import 'package:cpm/services/upsert_service.dart';

import '../services/authentication_service.dart';
import '../services/delete_service.dart';
import '../services/insert_service.dart';
import '../services/select/select_episode_service.dart';
import '../services/select/select_link_service.dart';
import '../services/select/select_location_service.dart';
import '../services/select/select_member_service.dart';
import '../services/select/select_project_service.dart';
import '../services/select/select_sequence_service.dart';
import '../services/select/select_shot_service.dart';
import '../services/update_service.dart';

mixin BaseProvider {
  final AuthenticationService authenticationService = AuthenticationService();

  final SelectProjectService selectProjectService = SelectProjectService();
  final SelectLinkService selectLinkService = SelectLinkService();
  final SelectEpisodeService selectEpisodeService = SelectEpisodeService();
  final SelectSequenceService selectSequenceService = SelectSequenceService();
  final SelectShotService selectShotService = SelectShotService();
  final SelectMemberService selectMemberService = SelectMemberService();
  final SelectLocationService selectLocationService = SelectLocationService();
  final SelectSequenceLocationService selectSequenceLocationService = SelectSequenceLocationService();

  final InsertService insertService = InsertService();

  final UpsertService upsertService = UpsertService();

  final UpdateService updateService = UpdateService();

  final DeleteService deleteService = DeleteService();
}
