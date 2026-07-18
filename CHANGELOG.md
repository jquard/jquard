# Changelog

All notable changes to this project will be documented in this file.

## [0.2.0] - 2026-07-18

### Added
- Authentication: `config.authenticate_with` hook, with Devise as the documented integration
- Filament-styled Devise views (sign in, password reset, registration) delivered from the engine
- User menu in the topbar with sign out
- Breadcrumbs on resource pages

### Changed
- **Breaking:** the panel now refuses to serve unless authentication is configured.
  Existing installs must add `config.authenticate_with { … }` to
  `config/initializers/jquard.rb`, or opt into a public panel with an empty
  block: `config.authenticate_with { }`. See the README.
- The brand name renders in black instead of the primary color

## [0.1.0] - 2026-07-17

### Added
- Mountable engine with self-registering resources and dynamic routing
- Tables: searchable/sortable columns, pagination, badges, boolean icons
- Forms: create/edit with section layouts, validation, and toasts
- Row actions: edit, and delete with a confirmation modal
- `jquard:install` and `jquard:resource` generators
- Theming via brand name and primary color

## [0.0.1] - 2026-07-11

### Added

- Initial placeholder release to reserve the gem name. No functionality yet.
