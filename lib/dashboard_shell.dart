import 'package:collapsible_drawer/models/side_item.dart';
import 'package:flutter/material.dart';
import 'package:collapsible_drawer/collapsible_drawer.dart';

class DashboardShell extends StatefulWidget {
  const DashboardShell({super.key});

  @override
  State<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends State<DashboardShell> {
  bool isExpanded = true;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const Center(child: Text("Campaigns")),
      const Center(child: Text("Reports")),
      const Center(child: Text("Audiences")),
      const Center(child: Text("Inbox")),
    ];

    final items = <SideItem>[
      SideItem(
        icon: Icons.send,
        label: "Campaigns",
        onTap: () => setState(() => selectedIndex = 0),
      ),
      SideItem(
        icon: Icons.bar_chart,
        label: "Reports",
        onTap: () => setState(() => selectedIndex = 1),
      ),
      SideItem(
        icon: Icons.people_alt,
        label: "Audiences",
        onTap: () => setState(() => selectedIndex = 2),
      ),
      SideItem(
        icon: Icons.inbox,
        label: "Inbox",
        badge: 46,
        onTap: () => setState(() => selectedIndex = 3),
      ),
    ];

    return Scaffold(
      body: Row(
        children: [
          CollapsibleDrawer(
            isExpanded: isExpanded,
            onToggle: () => setState(() => isExpanded = !isExpanded),
            selectedIndex: selectedIndex,
            items: items,
            title: "MySiaParty",
            paddingTop: 50,
          ),
          Expanded(child: pages[selectedIndex]),
        ],
      ),
    );
  }
}
