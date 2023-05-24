import 'package:flutter/material.dart';
import 'package:my_dividends/domain/dtos/redirect_add_negociation_page_dto.dart';
import 'package:my_dividends/domain/dtos/redirect_home_page_dto.dart';
import 'package:my_dividends/domain/dtos/redirect_stock_details_page_dto.dart';
import 'package:my_dividends/presentation/add_negotiation/page/add_negotiation_page.dart';
import 'package:my_dividends/presentation/home/page/home_page.dart';
import 'package:my_dividends/presentation/scheduled_dividends/page/scheduled_dividends_page.dart';
import 'package:my_dividends/presentation/stock_details/page/stock_details_page.dart';

class RedirectPage {
  static void redirectToStockDetailsPage(
    RedirectStockDetailsPageDTO redirectStockDetailsPageDTO,
  ) {
    _redirect(
      redirectStockDetailsPageDTO.context,
      page: StockDetailsPage(
        stock: redirectStockDetailsPageDTO.stock,
      ),
      replace: redirectStockDetailsPageDTO.replace,
      removeUntil: redirectStockDetailsPageDTO.removeUntil,
    );
  }

  static void redirectToAddNegotiationPage(
    RedirectAddNegociationPageDTO redirectAddNegociationDTO,
  ) {
    _redirect(
      redirectAddNegociationDTO.context,
      page: const AddNegotiationPage(),
      replace: redirectAddNegociationDTO.replace,
      removeUntil: redirectAddNegociationDTO.removeUntil,
    );
  }

  static void redirectToHomePage(RedirectHomePageDTO redirectHomePageDTO) {
    _redirect(
      redirectHomePageDTO.context,
      page: const HomePage(),
      replace: redirectHomePageDTO.replace,
      removeUntil: true,
    );
  }

  static void redirectToScheduledDividendsPage(
    RedirectHomePageDTO redirectHomePageDTO,
  ) {
    _redirect(
      redirectHomePageDTO.context,
      page: const ScheduledDividendsPage(),
      replace: redirectHomePageDTO.replace,
      removeUntil: redirectHomePageDTO.removeUntil,
    );
  }

  static void _redirect(
    BuildContext context, {
    required Widget page,
    bool replace = false,
    bool removeUntil = false,
  }) {
    if (replace) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    } else if (removeUntil) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => page),
        (route) => false,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => page,
        ),
      );
    }
  }
}
