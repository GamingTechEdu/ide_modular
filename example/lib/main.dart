import 'dart:ui';

import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ide_modular/export.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SideMenuIde(),
    ),
  );
}

class SideMenuIde extends StatefulWidget {
  final Widget? customChild;
  final Widget? child;
  const SideMenuIde({
    super.key,
    this.child,
    this.customChild,
  });

  @override
  State<SideMenuIde> createState() => _SideMenuIdeState();
}

class _SideMenuIdeState extends State<SideMenuIde> {
  late SideMenuController controller;
  int selectedIndex = 1;

  @override
  void initState() {
    controller = SideMenuController();
    super.initState();
    selectedIndex = 1;
    // selectedIndex = calculateSelectedIndex();
  }

  int calculateSelectedIndex() {
    final String location = Get.previousRoute;
    if (location.startsWith('/dashboard')) {
      return 0;
    }
    if (location.startsWith('/tableAr')) {
      return 1;
    }
    if (location.startsWith('/producao')) {
      return 2;
    }
    if (location.startsWith('/simcard')) {
      return 3;
    }
    return 0;
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });

    switch (index) {
      case 0:
        Get.toNamed('/dashboard');
        break;
      case 1:
        Get.toNamed('/tableAr');
        break;
      case 2:
        Get.toNamed('/producao');
        break;
      case 3:
        Get.toNamed('/simcard');
        break;
    }
  }

  bool isMenuVisible = false;

  void toggleMenu() {
    setState(() {
      isMenuVisible = !isMenuVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size.width;
    return fluent.FluentApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Row(
              children: [
                SideMenu(
                  maxWidth: 150,
                  hasResizer: false,
                  mode:
                      screen < 1200 ? SideMenuMode.compact : SideMenuMode.open,
                  hasResizerToggle: true,
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  builder: (data) {
                    return SideMenuData(
                      items: [
                        const SideMenuItemDataDivider(
                          divider: Divider(
                            indent: 10,
                            endIndent: 10,
                            height: 5,
                            color: Color.fromARGB(255, 197, 197, 197),
                          ),
                        ),
                        FluentTreeViewItemData(
                          [
                            fluent.TreeViewItem(
                              expanded: false,
                              content: const Text(
                                "Manutenção",
                                overflow: TextOverflow.ellipsis,
                              ),
                              children: [
                                fluent.TreeViewItem(
                                  content: const Text("Em Andamento",
                                      overflow: TextOverflow.ellipsis),
                                ),
                                fluent.TreeViewItem(
                                  content: const Text("Atrasados",
                                      overflow: TextOverflow.ellipsis),
                                ),
                                fluent.TreeViewItem(
                                  content: const Text("Finalizados",
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                            fluent.TreeViewItem(
                              expanded: false,
                              content: const Text("Produção",
                                  overflow: TextOverflow.ellipsis),
                              children: [
                                fluent.TreeViewItem(
                                  content: const Text("Em Andamento",
                                      overflow: TextOverflow.ellipsis),
                                ),
                                fluent.TreeViewItem(
                                  content: const Text("Atrasados",
                                      overflow: TextOverflow.ellipsis),
                                ),
                                fluent.TreeViewItem(
                                  content: const Text("Finalizados",
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                            fluent.TreeViewItem(
                              expanded: false,
                              content: const Text("Simcards",
                                  overflow: TextOverflow.ellipsis),
                              children: [
                                fluent.TreeViewItem(
                                  content: const Text("Em Andamento",
                                      overflow: TextOverflow.ellipsis),
                                ),
                                fluent.TreeViewItem(
                                  content: const Text("Atrasados",
                                      overflow: TextOverflow.ellipsis),
                                ),
                                fluent.TreeViewItem(
                                  content: const Text("Finalizados",
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                      footer: UserMenu(
                        data: [
                          MenuUserData(
                            icon: Icons.info,
                            title: "Sobre",
                            onTap: () => toggleMenu(),
                          ),
                          MenuUserData(
                            icon: Icons.info,
                            title: "Teste",
                            onTap: () => print("teste"),
                          )
                        ],
                      ),
                    );
                  },
                ),
                Expanded(
                  child: ElevatedButton(
                    child: const Text("Click"),
                    onPressed: () => controller.open(),
                  ),
                ),
                SideMenu(
                  maxWidth: 350,
                  hasResizer: true,
                  controller: controller,
                  hasResizerToggle: true,
                  position: SideMenuPosition.right,
                  mode: SideMenuMode.open,
                  builder: (data) => SideMenuData(
                    customChild: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.refresh),
                              splashRadius: 20,
                              tooltip: "Refresh",
                              // color: Colors.white,
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              splashRadius: 20,
                              tooltip: "Add New",
                              // color: Colors.white,
                              onPressed: () {},
                            ),
                            IconButton(
                              splashRadius: 20,
                              icon: const Icon(Icons.delete),
                              tooltip: "Delete",
                              // color: Colors.white,
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (isMenuVisible)
              MenuContext(
                func: () => toggleMenu(),
                label: "versão",
              )
          ],
        ),
      ),
    );
  }
}
