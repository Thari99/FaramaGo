import 'package:farmago/screens/Home/test.dart';
import 'package:farmago/screens/Home/test2.dart';
import 'package:farmago/screens/bayer/Navigation/drawer_items.dart';
import 'package:farmago/screens/bayer/Navigation/navigation_provider.dart';
import 'package:farmago/screens/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:farmago/screens/bayer/Navigation/model/drawer_iteam.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);

    final provider = Provider.of<NavigationProviderB>(context);
    final isCollapsed = provider.isCollapsed;

    return Container(
      width: isCollapsed ? MediaQuery.of(context).size.width * 0.2 : null,
      child: Drawer(
          child: Container(
        color: Color(0xff48a12f),
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(vertical: 24).add(safeArea),
              width: double.infinity,
              color: Colors.white12,
              child: buildHeader(isCollapsed),
            ),
            const SizedBox(height: 24),
            buildList(items: itemsFirst, isCollapsed: isCollapsed),
            const SizedBox(height: 24),
            Divider(color: Colors.white70),
            const SizedBox(height: 24),
            buildList(
              indexOffset: itemsFirst.length,
              items: itemsSecond,
              isCollapsed: isCollapsed,
            ),
            Spacer(),
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
      //   navigateTo();
      //   break;
      // case 1:
      //   navigateTo(HomePage());
      //   break;
      // case 2:
      //   navigateTo(());
      //   break;
      // case 3:
      //   navigateTo(());
      //   break;
      // case 4:
      //   navigateTo(());
      //   break;
      // case 5:
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
    final color = Colors.white;
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
        title: Text(text, style: TextStyle(color: color, fontSize: 16)),
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

    return Container(
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
                    Provider.of<NavigationProviderB>(context, listen: false);

                provider.toggleIsCollapsed();
              },
            )));
  }






  Widget buildHeader(bool isCollapsed) => isCollapsed
      ? FlutterLogo(size: 48)
      : Row(
          children: const [
            SizedBox(width: 28),
            FlutterLogo(size: 48),
            SizedBox(width: 16),
            Text(
              'Flutter',
              style: TextStyle(fontSize: 32, color: Colors.white),
            ),
          ],
        );
}
