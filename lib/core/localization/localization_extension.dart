import 'package:flutter/material.dart';

import 'package:e_commerce_app/core/localization/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}