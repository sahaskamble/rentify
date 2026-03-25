# Phase 2 Notepad: App Shell, Discover & Listings

## Findings & Decisions
- **Auth State**: Phase 1 models exist, but the `authProvider` and screens are missing. Phase 2 will include basic placeholders and the `authProvider` to support routing guards.
- **Routing**: `go_router` will be used with `ShellRoute` to manage the persistent bottom navigation bar.
- **Home UI**: Will follow a modular approach with horizontal lists for categories and featured items, and a grid for nearby items.
- **PocketBase**: `PocketbaseService` needs to be updated to handle `localhost` vs `10.0.2.2` (Android emulator) dynamically.
- **Assets**: New directories `assets/images`, `assets/icons`, and `assets/animations` are required.

## Implementation Notes
- Use `NavigationBar` (Material 3) for the app shell.
- `ListingCard` should be flexible enough to be used in both horizontal lists and vertical grids.
- `listingsProvider` should support basic filtering (e.g., by category or "featured" flag).
