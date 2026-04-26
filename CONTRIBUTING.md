# Contributing to Trae Forum

Thank you for your interest in contributing to Trae Forum! This document provides guidelines and instructions for contributing to this project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Workflow](#development-workflow)
- [Coding Standards](#coding-standards)
- [Commit Message Guidelines](#commit-message-guidelines)
- [Pull Request Process](#pull-request-process)
- [Reporting Issues](#reporting-issues)

## Code of Conduct

This project and everyone participating in it is governed by our commitment to:

- Be respectful and inclusive in all interactions
- Welcome newcomers and help them get started
- Focus on constructive feedback and collaboration
- Respect different viewpoints and experiences

## Getting Started

### Prerequisites

- Flutter SDK >= 3.10.0
- Dart SDK >= 3.0.0
- Android Studio / VS Code with Flutter extensions
- Git

### Setup

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/trae-forum-app.git
   cd trae-forum-app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Generate code:
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```
5. Run the app:
   ```bash
   flutter run
   ```

## Development Workflow

1. **Create a branch** from `main`:
   ```bash
   git checkout -b feature/your-feature-name
   ```
   Branch naming conventions:
   - `feature/` - New features
   - `fix/` - Bug fixes
   - `docs/` - Documentation updates
   - `refactor/` - Code refactoring
   - `test/` - Test additions or updates

2. **Make your changes** following our coding standards

3. **Test your changes**:
   ```bash
   flutter test
   flutter analyze
   ```

4. **Commit** with a descriptive message (see [Commit Message Guidelines](#commit-message-guidelines))

5. **Push** to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Create a Pull Request** on GitHub

## Coding Standards

### Dart/Flutter Style Guide

- Follow the [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use `dart format` to format your code
- Run `flutter analyze` to check for issues

### Code Organization

```
lib/
├── config/          # Configuration files
├── core/            # Core utilities and services
├── data/            # Data layer (models, repositories)
├── presentation/    # UI layer (pages, widgets, providers)
```

### Documentation Requirements

All public functions, classes, and methods must include documentation comments:

```dart
/// Fetches user information from the API.
///
/// [userId] The unique identifier of the user.
/// [includeDetails] Whether to include detailed information.
/// Returns a [User] object containing user information.
/// Throws [NetworkException] if the request fails.
Future<User> fetchUserInfo(String userId, {bool includeDetails = false}) async {
  // Implementation
}
```

### Widget Guidelines

- Use `const` constructors where possible
- Keep widgets small and focused
- Use meaningful names
- Support both light and dark themes

```dart
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.avatarUrl,
    this.size = 48,
    this.onTap,
  });

  final String avatarUrl;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: avatarUrl,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
```

## Commit Message Guidelines

We follow the [Conventional Commits](https://www.conventionalcommits.org/) specification:

### Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types

- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation changes
- **style**: Code style changes (formatting, semicolons, etc.)
- **refactor**: Code refactoring
- **test**: Test additions or updates
- **chore**: Build process or auxiliary tool changes

### Examples

```
feat(auth): add WebView login support

Implement SSO login using WebView to integrate with Trae main site.
Includes cookie synchronization and session management.

fix(feed): resolve image loading issue in feed cards

CachedNetworkImage was not properly handling error states.
Added error widget and retry logic.

docs(readme): update build instructions

Added detailed steps for iOS code signing and Android keystore setup.
```

## Pull Request Process

1. **Update documentation** if needed
2. **Add tests** for new functionality
3. **Ensure all tests pass**:
   ```bash
   flutter test
   ```
4. **Ensure code analysis passes**:
   ```bash
   flutter analyze
   ```
5. **Update CHANGELOG.md** with your changes
6. **Fill out the PR template** completely
7. **Link related issues** using keywords (Fixes #123, Closes #456)
8. **Request review** from maintainers

### PR Review Checklist

- [ ] Code follows style guidelines
- [ ] All tests pass
- [ ] Documentation is updated
- [ ] CHANGELOG.md is updated
- [ ] No sensitive information is exposed
- [ ] Commits are properly formatted

## Reporting Issues

### Bug Reports

When reporting bugs, please include:

- **Description**: Clear description of the bug
- **Steps to Reproduce**: Detailed steps to reproduce the issue
- **Expected Behavior**: What you expected to happen
- **Actual Behavior**: What actually happened
- **Screenshots**: If applicable
- **Environment**:
  - Flutter version: `flutter --version`
  - Device/OS: e.g., iPhone 14 Pro / iOS 17.0
  - App version: e.g., 1.0.0+1

### Feature Requests

When requesting features, please include:

- **Description**: Clear description of the feature
- **Use Case**: Why this feature would be useful
- **Proposed Solution**: Your ideas on how to implement it
- **Alternatives**: Any alternative solutions you've considered

## Questions?

Feel free to:
- Open an issue for questions
- Join discussions in existing issues
- Contact maintainers

Thank you for contributing to Trae Forum!
