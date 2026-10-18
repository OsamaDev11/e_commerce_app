import 'package:e_commerce_app/core/localization/app_localizations.dart';
import 'package:e_commerce_app/core/networking/app_failure.dart';

extension AppFailureMessage on AppFailure {
  String userMessage(AppLocalizations l10n) {
    final serverMessage = this.serverMessage;

    return switch (type) {
      AppFailureType.noInternet => l10n.errorNoInternet,
      AppFailureType.timeout => l10n.errorTimeout,
      AppFailureType.server => l10n.errorServer,
      AppFailureType.badRequest => serverMessage ?? l10n.errorBadRequest,
      AppFailureType.unauthorized => serverMessage ?? l10n.errorUnauthorized,
      AppFailureType.forbidden => serverMessage ?? l10n.errorForbidden,
      AppFailureType.notFound => serverMessage ?? l10n.errorNotFound,
      AppFailureType.cancelled ||
      AppFailureType.parsing ||
      AppFailureType.unknown =>
        l10n.somethingWentWrong,
    };
  }
}
