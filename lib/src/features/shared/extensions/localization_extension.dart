import 'package:aku_task/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations? get l10n => AppLocalizations.of(this);
}
