import 'package:my_dividends/domain/dtos/redirect_base_dto.dart';

class RedirectAnnouncedDividendsPageDTO extends RedirectBaseDTO {
  RedirectAnnouncedDividendsPageDTO({
    required context,
    replace = false,
    removeUntil = false,
  }) : super(
          context: context,
          replace: replace,
          removeUntil: removeUntil,
        );
}
