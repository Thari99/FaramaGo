
import 'package:farmago/screens/farmer/Home/Post_upload-screen/upload-screen.dart';
import 'package:farmago/screens/farmer/Navigation/drawer_items.dart';
import 'package:farmago/screens/farmer/Navigation/navigation_provider.dart';
import 'package:farmago/screens/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:farmago/screens/farmer/Navigation/model/drawer_iteam.dart';

class NavigationDrawerWidgetF extends StatelessWidget {
  const NavigationDrawerWidgetF({Key? key}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);

    final provider = Provider.of<NavigationProviderF>(context);
    final isCollapsed = provider.isCollapsed;

    return Container(
      width: isCollapsed ? MediaQuery.of(context).size.width * 0.2 : null,
      child: Drawer(
          child: Container(
        color: Color.fromRGBO(0, 139, 139, 1),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24).add(safeArea),
              width: double.infinity,
              color: Color.fromRGBO(0, 85, 85, 1.0),
              child: buildHeader(isCollapsed),
            ),
            const SizedBox(height: 24),
            buildList(items: itemsFirst, isCollapsed: isCollapsed),
            const SizedBox(height: 24),
            const Divider(color: Colors.white70),
            const SizedBox(height: 24),
            buildList(
              indexOffset: itemsFirst.length,
              items: itemsSecond,
              isCollapsed: isCollapsed,
            ),
            const Spacer(),
            buildCollapseIcon(context, isCollapsed),
            const SizedBox(height: 12),
          ],
        ),
      )),
    );
  }

  Widget buildList({
    required bool isCollapsed,
    required List<DrawerItem> items,
    int indexOffset = 0,
  }) =>
      ListView.separated(
        padding: isCollapsed ? EdgeInsets.zero : padding,
        shrinkWrap: true,
        primary: false,
        itemCount: items.length,
        separatorBuilder: (context, index) => SizedBox(height: 16),
        itemBuilder: (context, index) {
          final item = items[index];

          return buildMenuItem(
            isCollapsed: isCollapsed,
            text: item.title,
            icon: item.icon,
            onClicked: () => selectItem(context, indexOffset + index),
          );
        },
      );

  void selectItem(BuildContext context, int index) {
    final navigateTo = (page) => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => page,
        ));

    Navigator.of(context).pop();

    switch (index) {
      // case 0:
      //   navigateTo(MainPage());
      //   break;
      case 1:
        navigateTo(UploadProductForm());
        break;
      // case 2:
      //   navigateTo((UploadProductForm));
      //   break;
      // case 3:
      //   navigateTo((UploadProductForm));
      //   break;
      // case 4:
      //   navigateTo((UploadProductForm));
      //   break;
      case 5:
        navigateTo((const Welcomepage()));
        break;
      // case 6:
      //   navigateTo(());
      //   break;
    }
  }

  Widget buildMenuItem({
    required bool isCollapsed,
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.black54;
    final leading = Icon(icon, color: color);

    return Material(
      color: Colors.transparent,
      child: isCollapsed
          ? ListTile(
              title: leading,
              onTap: onClicked,
            )
          : ListTile(
              leading: leading,
              title: Text(text, style: TextStyle(color: Colors.black54, fontSize: 16)),
              onTap: onClicked,
            ),
    );
  }

  Widget buildCollapseIcon(BuildContext context, bool isCollapsed) {
    final double size = 78;
    final icon = isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
    final alignment = isCollapsed ? Alignment.center : Alignment.centerRight;
    final margin = isCollapsed ? null : EdgeInsets.only(right: 16);
    final width = isCollapsed ? double.infinity : size;

    return Column(
      children: [
        Container(
            alignment: alignment,
            margin: margin,
            child: Material(
                color: Colors.transparent,
                child: InkWell(
                  child: Container(
                    width: size,
                    height: size,
                    child: Icon(icon, color: Colors.white),
                  ),
                  onTap: () {
                    final provider =
                        Provider.of<NavigationProviderF>(context, listen: false);

                    provider.toggleIsCollapsed();
                  },
                ))),
      ],
    );

  }

  Widget buildHeader(bool isCollapsed) => isCollapsed
      ? Image.asset('assets/logo.png')
      : Row(
    children: [
      SizedBox(width: 20),
      CircleAvatar(
        backgroundImage: AssetImage('assets/logo.png'),
        backgroundColor: Color.fromRGBO(2, 61, 15, 1.0),
        radius: 30,
      ),
      SizedBox(width: 16),
      Text(
        'FaramaGo',
        style: TextStyle(fontSize: 32, color: Colors.white),
      ),
    ],
  );
}