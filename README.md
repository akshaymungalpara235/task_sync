# TaskSync

A modern task management application built with Flutter that helps you organize and track your tasks efficiently.

## Features

- 📝 Create, update, and delete tasks
- ✅ Mark tasks as complete/incomplete
- 📅 Set due dates for tasks
- 🔍 Filter tasks by status (All/Pending/Completed)
- 📊 Sort tasks by:
  - Due date (ascending/descending)
  - Creation date (ascending/descending)
- 💾 Local storage for offline access
- 🎨 Clean and intuitive user interface
- 📱 Responsive design for all screen sizes

## Timeline Estimation

### Phase 1: Core Features (9-10 Hours)
- [x] Project setup and architecture implementation
- [x] Basic task CRUD operations
- [x] Local storage implementation
- [x] Task status management
- [x] Basic UI implementation

### Phase 2: Enhanced Features (7-8 Hours)
- [x] Task filtering by status
- [x] Task sorting functionality
- [x] Due date management
- [x] UI/UX improvements
- [x] Error handling and validation

### Phase 3: Testing & Optimization (8-10 Hours)
- [x] Unit tests implementation
- [x] Widget tests
- [x] Integration tests
- [x] Performance optimization
- [x] Code documentation

## Getting Started

### Prerequisites

- Flutter SDK (3.29.2 or higher)
- Dart SDK (3.7.2 or higher)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
```bash
git clone https://github.com/akshaymungalpara235/task_sync.git
```

2. Navigate to the project directory:
```bash
cd task_sync
```

3. Install dependencies:
```bash
flutter pub get
```

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── core/
│   ├── api/
│   └── error/
├── data/
│   ├── api/
│   ├── datasources/
│   ├── mappers/
│   └── repositories/
├── domain/
│   ├── entities/
│   ├── mappers/
│   └── use_cases/
└── presentation/
    ├── task/
    │   ├── bloc/
    │   ├── screen/
    │   └── widgets/
    └── widgets/
```

## Architecture

TaskSync follows Clean Architecture principles with the following layers:

- **Presentation Layer**: Contains UI components, screens, and BLoC for state management
- **Domain Layer**: Contains business logic, entities, and use cases
- **Data Layer**: Handles data operations, repositories, and data sources

## Dependencies

- `flutter_bloc`: For state management
- `equatable`: For value equality
- `sqflite`: For local database storage
- `path`: For file path operations
- `intl`: For date formatting

## 🔌 Unit/Widget Tests

- Unit/Widget tests are located in the test/ folder.

  Command to run the test cases:
```bash
flutter test
```

## 🔌 Integration Tests

- Integration tests are located in the integration_test/ folder.

  Command to run the Integration tests:
```bash
flutter test integration_test
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
