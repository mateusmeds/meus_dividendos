import 'package:my_dividends/domain/dtos/redirect_base_dto.dart';

class RedirectScheduledDividendsPageDTO extends RedirectBaseDTO {
  RedirectScheduledDividendsPageDTO({
    required context,
    replace = false,
    removeUntil = false,
  }) : super(
          context: context,
          replace: replace,
          removeUntil: removeUntil,
        );
}
