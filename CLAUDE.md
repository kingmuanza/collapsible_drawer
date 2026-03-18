# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter package called `collapsible_drawer` that provides an animated, collapsible sidebar/drawer widget for dashboard-style applications. The drawer supports expand/collapse animations, navigation items with badges, profile tiles, and customizable theming.

## Commands

```bash
# Get dependencies
flutter pub get

# Run the example app
flutter run

# Run tests
flutter test

# Run a single test file
flutter test test/collapsible_drawer_test.dart

# Analyze code
flutter analyze
```

## Architecture

The package exports a single main widget `CollapsibleDrawer` that consumers use in their layouts.

### Key Components

- **`CollapsibleDrawer`** (`lib/collapsible_drawer.dart`): The main stateless widget that renders the animated sidebar. Accepts configuration for colors, dimensions, animation timing, and content (menu items, profile, logo).

- **`SideItem`** (`lib/models/side_item.dart`): Data model for navigation items containing icon, label, optional badge count, and onTap callback.

- **`DashboardShell`** (`lib/dashboard_shell.dart`): Example usage demonstrating how to integrate CollapsibleDrawer into a typical dashboard layout with a Row containing the drawer and page content.

### Widget Composition

CollapsibleDrawer internally uses three private widgets:
- `_SideTile`: Individual menu item with active state styling and optional badge
- `_RoundIconButton`: Circular icon button used for help/action buttons
- `_ProfileTile`: Bottom profile section showing avatar, name, and settings

### State Management

The drawer is stateless; parent widgets manage `isExpanded` and `selectedIndex` state and pass callbacks (`onToggle`, item `onTap`) to control navigation.

## CI/CD

A GitHub Actions workflow (`.github/workflows/version-bump.yml`) automatically increments the patch version in `pubspec.yaml` and creates a git tag on every push to main.
