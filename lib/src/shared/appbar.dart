import 'package:flutter/material.dart';

Widget appBar(BuildContext context,
    {Key key = const Key('Scaffold'),
    bool drawer = true,
    required String titulo,
    required Widget body,
    Widget? bottomNavBar,
    Widget? actionButtom,
    FloatingActionButtonLocation actionButtonLocation =
        FloatingActionButtonLocation.endTop,
    List<Widget>? barActions}) {
  return Scaffold(
    key: key,
    appBar: AppBar(
      title: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(
          titulo,
          textAlign: TextAlign.center,
        ),
      ),
      centerTitle: true,
      actions: barActions,
    ),
    body: SafeArea(child: body),
    // endDrawer: drawer ? Drawer(child: drawerItens) : null,
    bottomNavigationBar: bottomNavBar,
    floatingActionButton: actionButtom,
    floatingActionButtonLocation: actionButtonLocation,
  );
}
