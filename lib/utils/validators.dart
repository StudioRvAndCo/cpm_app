import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/extensions/validators/string_validators.dart';

String? validatePhone(String? phone) {
  if (phone == null || phone.isEmpty || phone.validPhone) {
    return null;
  }

  return localizations.error_invalid_phone;
}

String? validateEmail(String? email) {
  if (email == null || email.isEmpty || email.validEmail) {
    return null;
  }

  return localizations.error_invalid_email;
}

String? validateUrl(String? url) {
  if (url == null || url.isEmpty || Uri.tryParse(url)!.isAbsolute) {
    return null;
  }

  return localizations.error_invalid_url;
}
