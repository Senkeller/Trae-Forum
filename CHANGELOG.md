# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial open source release
- Complete Flutter client for Trae Forum
- SSO WebView login integration
- Topic browsing with rich text rendering
- Search functionality with advanced filters
- User profiles and activity history
- Notification system
- Local storage for browsing history and favorites

## [1.0.0] - 2026-04-26

### Added
- **Authentication**
  - WebView-based SSO login
  - Cookie synchronization between domains
  - Session persistence
  - Login state management

- **Feed System**
  - Latest topics feed
  - Hot topics feed
  - Categorized topic lists
  - Pull-to-refresh and infinite scroll

- **Topic Details**
  - Rich text rendering with HTML support
  - Image gallery with zoom and preview
  - Table of contents navigation
  - Like and bookmark functionality

- **Search**
  - Full-text search
  - Category filtering
  - Sort by latest, likes, views, posts
  - Search history

- **User System**
  - User profiles
  - Activity history
  - Following/followers lists
  - Local favorites and browsing history

- **Notifications**
  - Notification list with categories
  - Mark as read functionality
  - Unread count badges

- **UI Components**
  - Loading widgets and skeleton screens
  - Cached image components
  - Rich text viewer
  - Link preview cards
  - Customizable feed cards

- **Performance**
  - Image caching and optimization
  - List virtualization
  - Memory management
  - Performance monitoring tools

### Technical
- Flutter 3.10+ support
- Riverpod state management
- Dio network layer with interceptors
- Hive CE for local storage
- Freezed for data modeling
- Comprehensive test coverage

[Unreleased]: https://github.com/trae-community/trae-forum-app/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/trae-community/trae-forum-app/releases/tag/v1.0.0
