# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Fruits Hub (E-VeggieStore)** is a Flutter e-commerce mobile application for purchasing fresh vegetables and fruits, implementing Clean Architecture with Domain-Driven Design.

- **Flutter SDK**: 3.5.0+
- **Architecture**: Clean Architecture with three layers (Presentation, Domain, Data)
- **State Management**: BLoC/Cubit pattern using flutter_bloc
- **Backend**: Firebase (Auth, Firestore)
- **Primary Language**: Arabic (ar) localization
- **Platforms**: Android (minSdk 21), iOS

## Development Commands

### Building and Running
```bash
# Install dependencies
flutter pub get

# Run the app (debug mode)
flutter run

# Run on specific device
flutter run -d <device_id>

# Build APK
flutter build apk --release

# Build iOS
flutter build ios --release

# Clean build
flutter clean
flutter pub get

# Generate localization files
flutter pub run intl_utils:generate

# Generate assets (images) constants
flutter pub run flutter_gen
```

### Testing
```bash
# Run all tests
flutter test

# Run specific test
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

### Code Analysis
```bash
# Run analyzer
flutter analyze

# Format code
dart format lib/

# Check for outdated packages
flutter pub outdated
```

## High-Level Architecture

### Clean Architecture Layers

1. **Presentation Layer** (`features/*/presentation/`)
   - Views (UI screens)
   - Widgets (reusable components)
   - Manager/Cubits (state management)

2. **Domain Layer** (`features/*/domain/` + `core/`)
   - Entities (business objects)
   - Abstract Repositories (contracts)
   - Business rules

3. **Data Layer** (`features/*/data/` + `core/`)
   - Models (serializable DTOs)
   - Repository Implementations (Firebase)
   - Services (Firebase, local storage)

### State Management Pattern

The app uses **Cubit** (simplified BLoC without events):

```dart
// State flow
User Action → Cubit Method → Emit Loading → Process → Emit Success/Error → UI Rebuilds
```

Key Cubits:
- `ProductsCubit`: Product catalog management
- `CartCubit`: Shopping cart operations
- `SignInCubit/SignUpCubit`: Authentication flows

### Dependency Injection

Service Locator pattern using GetIt (`core/services/get_it_service.dart`):
- All dependencies are singletons
- Repositories and services are registered on app startup
- Access via: `getIt.get<ServiceType>()`

### Error Handling

Functional error handling with Either pattern (dartz):
```dart
Future<Either<Failure, Success>> operation() async {
  try {
    // Success path
    return Right(successData);
  } catch (e) {
    // Error path
    return Left(ServerFailure(e.toString()));
  }
}

// Usage
result.fold(
  (failure) => handleError(failure),
  (success) => handleSuccess(success)
);
```

## Key Business Features

### Shopping Cart (In-Memory)
- Cart exists only during session (not persisted)
- Auto-increments quantity if item already exists
- Provides total price and weight calculations

### Order Management
```dart
Order Status Flow:
pending → confirmed → processing → shipped → delivered
         ↓
      cancelled (only within 30 minutes)
```

### Multi-Step Checkout
1. **Delivery Address**: Full validation
2. **Shipping Method**: Cost calculation
3. **Payment Method**: Order summary
4. **Confirmation**: Create order, clear cart

## Firebase Integration

### Collections
- `products`: Product catalog with reviews
- `orders`: User orders with status tracking
- `users`: User profiles

### Service Architecture
```dart
// Abstract interface
DatabaseService → FireStoreService (concrete implementation)

// Repository pattern
AuthRepo (abstract) → AuthRepoImpl (Firebase implementation)
ProductsRepo (abstract) → ProductsRepoImpl (Firebase implementation)
OrdersRepo (abstract) → OrdersRepoImpl (Firebase implementation)
```

## Project Structure

```
lib/
├── core/                  # Shared cross-feature code
│   ├── cubits/           # Shared state management
│   ├── repos/            # Abstract repositories
│   ├── services/         # Core services (Firebase, DI)
│   ├── models/           # Shared data models
│   ├── entities/         # Domain entities
│   ├── widgets/          # Reusable UI components
│   └── utils/            # Colors, styles, constants
│
└── features/             # Feature modules
    ├── auth/             # Authentication
    ├── home/             # Products & Cart
    ├── checkout/         # Order checkout
    └── [other features]/
```

## Navigation

Named routes via `core/helper/on_generate_routes.dart`:
- `/splash` - Initial splash screen
- `/onboarding` - Onboarding flow
- `/login` - Login screen
- `/signup` - Registration
- `/main` - Home/main app
- `/checkout` - Checkout (requires CartEntity argument)
- `/best-selling` - Best sellers

## Important Patterns

### Repository Pattern
Every data source has an abstract repository (domain) and concrete implementation (data):
```dart
// Domain layer
abstract class ProductsRepo {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
}

// Data layer
class ProductsRepoImpl implements ProductsRepo {
  // Firebase implementation
}
```

### Entity vs Model
- **Entity**: Business object (domain layer)
- **Model**: Serializable DTO extending entity (data layer)

### Factory Methods for Serialization
All models have:
- `fromJson(Map<String, dynamic>)` - Deserialization
- `toJson()` - Serialization
- `fromEntity(Entity)` - Convert from entity
- `toEntity()` - Convert to entity

## Development Guidelines

### Adding New Features
1. Create feature folder under `features/`
2. Implement three-layer architecture (presentation, domain, data)
3. Create abstract repository in domain
4. Implement repository with Firebase in data
5. Create Cubit for state management
6. Register dependencies in `get_it_service.dart`

### Firebase Operations
Always handle Firestore timestamps:
```dart
// Writing to Firestore
date: Timestamp.fromDate(dateObject)

// Reading from Firestore
date: firestoreDoc.data().date.toDate()
```

### State Management
1. Create states extending base state class
2. Create Cubit extending `Cubit<StateType>`
3. Use `BlocBuilder` or `BlocConsumer` in UI
4. Always emit loading state before operations

### Error Handling
1. Wrap Firebase operations in try-catch
2. Return `Either<Failure, Success>`
3. Use `.fold()` to handle both paths
4. Show user-friendly error messages

## Key Dependencies

- **State**: flutter_bloc (^9.0.0)
- **Backend**: firebase_core, firebase_auth, cloud_firestore
- **DI**: get_it (^8.0.0)
- **Functional**: dartz (^0.10.1)
- **Auth**: google_sign_in (^6.2.1)
- **Storage**: shared_preferences (^2.5.3)
- **UI**: flutter_svg, cached_network_image, skeletonizer

## Testing Approach

- Unit tests for business logic (services, repositories)
- Widget tests for UI components
- Integration tests for critical user flows
- Mock Firebase services using abstract interfaces

## Common Issues & Solutions

### Cart Not Persisting
The cart is designed to be session-only. To persist, implement cart storage in Firestore.

### Arabic Text Rendering
App uses Cairo font family with weights 200-800. Ensure proper RTL layout when needed.

### Order Cancellation
Orders can only be cancelled within 30 minutes of creation (business rule in `CoreOrdersService`).

### Firebase Timestamp Handling
Always convert between `Date` (client) and `Timestamp` (Firestore) when reading/writing.