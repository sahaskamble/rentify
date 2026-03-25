## Phase 3 Plan: App Shell Implementation (ShellScreen)

This plan focuses on implementing the actual App Shell skeleton in Flutter for Phase 3, leveraging the prior Phase 2 routing groundwork. The goal is to deliver a functional ShellScreen with a persistent BottomNavigationBar and a placeholder host area for per-tab content.

### TODOs (Granular atomic tasks)
- [ ] Create lib/features/shell/shell_screen.dart with a StatefulWidget named ShellScreen returning a Scaffold.
- [ ] Implement a BottomNavigationBar with five items: Home, Discover, My Rentals, Chat, Profile.
- [ ] Wire local state to switch content without routing; render a placeholder widget for each tab (e.g., Center(child: Text('Home Placeholder')).
- [ ] Style the BottomNavigationBar using AppColors and AppTextStyles.
- [ ] Ensure the ShellScreen is responsive and fits Material 3 theming.
- [ ] Add minimal tests or verification stubs for tab switching and rendering.

### Acceptance Criteria
- App Shell renders a bottom navigation bar with the five tabs.
- Tapping tabs updates the placeholder content in the body.
- No changes to existing routing logic or auth guards.
- The new file compiles and the app builds with the ShellScreen integrated.

### Verification Notes
- Run flutter analyze; ensure no warnings in the new shell file.
- Run the app and verify the Shell appears with a BottomNavigationBar on the screen.
