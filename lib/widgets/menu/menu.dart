import 'package:flutter/material.dart';
import 'package:my_dividends/domain/dtos/redirect_add_negociation_page_dto.dart';
import 'package:my_dividends/domain/dtos/redirect_home_page_dto.dart';
import 'package:my_dividends/infra/redirect/redirect_page.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 30,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Mateus',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Início'),
            onTap: () => RedirectPage.redirectToHomePage(
              RedirectHomePageDTO(context: context),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.change_circle_outlined),
            title: const Text('Adicionar Negociação'),
            onTap: () => RedirectPage.redirectToAddNegotiationPage(
              RedirectAddNegociationPageDTO(context: context),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month),
            title: const Text('Dividendos Anunciados'),
            onTap: () => RedirectPage.redirectToAnnouncedDividendsPage(
              RedirectHomePageDTO(context: context),
            ),
          ),
        ],
      ),
    );
  }
}
