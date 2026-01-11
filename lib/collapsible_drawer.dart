import 'package:collapsible_drawer/models/side_item.dart';
import 'package:flutter/material.dart';

class CollapsibleDrawer extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;
  final int selectedIndex;
  final List<SideItem> items;
  final Color? backgroundColor;
  final Color? activeItemColor;
  final Color? inactiveIconColor;
  final Color? helpButtonColor;
  final Color? profileTileColor;
  final Color? badgeColor;
  final String? title;
  final TextStyle? titleStyle;
  final Widget? logo;
  final String? profileName;
  final String? profileInitial;
  final Widget? profileAvatar;
  final bool showProfileSettings;
  final double? expandedWidth;
  final double? collapsedWidth;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final VoidCallback? onHelpTap;
  final VoidCallback? onProfileSettingsTap;
  final double? paddingTop;
  final bool? showHelpButton;

  const CollapsibleDrawer({
    super.key,
    required this.isExpanded,
    required this.onToggle,
    required this.selectedIndex,
    required this.items,
    this.backgroundColor,
    this.activeItemColor,
    this.inactiveIconColor,
    this.helpButtonColor,
    this.profileTileColor,
    this.badgeColor,
    this.title,
    this.titleStyle,
    this.logo,
    this.profileName,
    this.profileInitial,
    this.profileAvatar,
    this.showProfileSettings = true,
    this.expandedWidth,
    this.collapsedWidth,
    this.animationDuration,
    this.animationCurve,
    this.onHelpTap,
    this.onProfileSettingsTap,
    this.paddingTop,
    this.showHelpButton,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? const Color(0xFF1D1230);
    final active = activeItemColor ?? const Color(0xFF5CCB7D);
    final inactiveIcon = inactiveIconColor ?? Colors.white70;
    final helpColor = helpButtonColor ?? const Color(0xFF3A1C5A);
    final profileColor = profileTileColor ?? Colors.white.withOpacity(0.08);
    final badge = badgeColor ?? Colors.lightBlueAccent;

    final double expandedW = expandedWidth ?? 280;
    final double collapsedW = collapsedWidth ?? 60;
    final Duration animDuration =
        animationDuration ?? const Duration(milliseconds: 220);
    final Curve animCurve = animationCurve ?? Curves.easeOut;
    final double topPadding = paddingTop ?? 0;
    final bool helpButtonShowed = showHelpButton ?? true;

    return AnimatedContainer(
      duration: animDuration,
      curve: animCurve,
      width: isExpanded ? expandedW : collapsedW,
      decoration: BoxDecoration(
        color: bg,
        boxShadow: [
          BoxShadow(blurRadius: 18, color: Colors.black.withOpacity(0.25)),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: topPadding),
              color: Colors.red,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: Container()),
                  SizedBox(
                    width: collapsedW,
                    child: IconButton(
                      onPressed: onToggle,
                      icon: Icon(
                        isExpanded ? Icons.chevron_left : Icons.menu,
                        color: inactiveIcon,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: [
                  Center(child: logo ?? const FlutterLogo(size: 28)),
                  if (isExpanded && title != null) ...[
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                            titleStyle ??
                            const TextStyle(
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
                    inactiveIconColor: inactiveIcon,
                    badgeColor: badge,
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
                  if (helpButtonShowed == true)
                    _RoundIconButton(
                      icon: Icons.help_outline,
                      onTap: onHelpTap ?? () {},
                      backgroundColor: helpColor,
                      iconColor: Colors.white,
                    ),
                  const SizedBox(height: 16),
                  _ProfileTile(
                    isExpanded: isExpanded,
                    backgroundColor: profileColor,
                    profileName: profileName,
                    profileInitial: profileInitial,
                    profileAvatar: profileAvatar,
                    showSettings: showProfileSettings,
                    onSettingsTap: onProfileSettingsTap,
                  ),
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
  final Color inactiveIconColor;
  final Color badgeColor;
  final VoidCallback onTap;

  const _SideTile({
    required this.isExpanded,
    required this.icon,
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.inactiveIconColor,
    required this.badgeColor,
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
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 44,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: Icon(
                        icon,
                        color: isActive ? Colors.white : inactiveIconColor,
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
                            color: badgeColor,
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
  final Color backgroundColor;
  final Color iconColor;

  const _RoundIconButton({
    required this.icon,
    required this.onTap,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(icon, color: iconColor),
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final bool isExpanded;
  final Color backgroundColor;
  final String? profileName;
  final String? profileInitial;
  final Widget? profileAvatar;
  final bool showSettings;
  final VoidCallback? onSettingsTap;

  const _ProfileTile({
    required this.isExpanded,
    required this.backgroundColor,
    this.profileName,
    this.profileInitial,
    this.profileAvatar,
    this.showSettings = true,
    this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          profileAvatar ??
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white.withOpacity(0.15),
                child: Text(
                  profileInitial ?? "U",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          if (isExpanded) ...[
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                profileName ?? "User",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (showSettings)
              IconButton(
                onPressed: onSettingsTap ?? () {},
                icon: Icon(
                  Icons.settings,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
