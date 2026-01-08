import 'package:collapsible_drawer/models/side_item.dart';
import 'package:flutter/material.dart';

class CollapsibleDrawer extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;
  final int selectedIndex;
  final List<SideItem> items;

  const CollapsibleDrawer({
    super.key,
    required this.isExpanded,
    required this.onToggle,
    required this.selectedIndex,
    required this.items,
  });

  static const double expandedWidth = 280;
  static const double collapsedWidth = 60;

  @override
  Widget build(BuildContext context) {
    final bg = const Color(0xFF1D1230); // violet sombre
    final active = const Color(0xFF5CCB7D); // vert sélectionné (exemple)

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      width: isExpanded ? expandedWidth : collapsedWidth,
      decoration: BoxDecoration(
        color: bg,
        boxShadow: [
          BoxShadow(blurRadius: 18, color: Colors.black.withOpacity(0.25)),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            // HEADER
            Row(
              children: [
                Expanded(child: Container()),
                SizedBox(
                  width: collapsedWidth,
                  child: IconButton(
                    onPressed: onToggle,
                    icon: Icon(
                      isExpanded ? Icons.chevron_left : Icons.menu,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: [
                  Center(child: const FlutterLogo(size: 28)),
                  if (isExpanded) ...[
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        "SIAPARTY",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 60),

            // LISTE MENU
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, i) {
                  final item = items[i];
                  final isActive = i == selectedIndex;

                  return _SideTile(
                    isExpanded: isExpanded,
                    icon: item.icon,
                    label: item.label,
                    badge: item.badge,
                    isActive: isActive,
                    activeColor: active,
                    onTap: item.onTap,
                  );
                },
              ),
            ),

            // FOOTER (aide / profil)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 24),
              child: Column(
                children: [
                  _RoundIconButton(icon: Icons.help_outline, onTap: () {}),
                  const SizedBox(height: 100),
                  _ProfileTile(isExpanded: isExpanded),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SideTile extends StatelessWidget {
  final bool isExpanded;
  final IconData icon;
  final String label;
  final int? badge;
  final bool isActive;
  final Color activeColor;
  final VoidCallback onTap;

  const _SideTile({
    required this.isExpanded,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    final baseText = TextStyle(
      color: Colors.white.withOpacity(0.9),
      fontSize: 15,
      fontWeight: FontWeight.w600,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          height: 48,
          width: isExpanded ? 200 : 48,
          // padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: isActive ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 44,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: Icon(
                        icon,
                        color: isActive ? Colors.white : Colors.white70,
                        size: 28,
                      ),
                    ),
                    if (badge != null && badge! > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            "$badge",
                            style: const TextStyle(
                              fontSize: 8,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (isExpanded) ...[
                const SizedBox(width: 12),
                Expanded(child: Text(label, style: baseText)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF3A1C5A),
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: const SizedBox(
          width: 40,
          height: 40,
          child: Icon(Icons.help_outline, color: Colors.white),
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final bool isExpanded;
  const _ProfileTile({required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white.withOpacity(0.15),
            child: const Text("K", style: TextStyle(color: Colors.white)),
          ),
          if (isExpanded) ...[
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                "kangudie muanza",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings, color: Colors.white70),
            ),
          ],
        ],
      ),
    );
  }
}
