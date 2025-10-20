# Unit Tests for Pets App

This directory contains comprehensive unit tests for the Pets App project, covering models, repositories, and cubits (BLoC state management).

## Test Structure

```
test/
├── data/
│   └── local/
│       ├── models/
│       │   ├── pet_model_test.dart
│       │   └── event_model_test.dart
│       └── repositories/
│           ├── pet_repository_impl_test.dart
│           └── event_repository_impl_test.dart
└── presentation/
    └── blocs/
        ├── add_pet/
        │   └── add_pet_cubit_test.dart
        ├── home/
        │   └── home_cubit_test.dart
        └── pet_details/
            └── pet_details_cubit_test.dart
```

## Test Coverage

### Models

#### `pet_model_test.dart`
Tests for the `PetModel` class covering:
- **fromJson()**: Verifies JSON deserialization
- **toJson()**: Verifies JSON serialization
- **fromEntity()**: Verifies conversion from Pet entity
- **Equality**: Tests that models with same data are equal
- **Roundtrip conversion**: Tests that toJson() → fromJson() produces identical model

**Total: 6 tests**

#### `event_model_test.dart`
Tests for the `EventModel` class covering:
- **fromJson()**: Verifies JSON deserialization with DateTime parsing
- **toJson()**: Verifies JSON serialization with DateTime ISO8601 format
- **fromEntity()**: Verifies conversion from Event entity
- **Equality**: Tests that models with same data are equal
- **DateTime handling**: Ensures correct DateTime parsing from ISO8601 strings
- **Roundtrip conversion**: Tests that toJson() → fromJson() produces identical model

**Total: 6 tests**

### Repositories

#### `pet_repository_impl_test.dart`
Tests for `PetRepositoryImpl` with mocked `PetLocalDataSource`:

**getPets():**
- Returns list of pets successfully
- Returns empty list when no pets exist
- Throws exception on data source failure

**addPet():**
- Returns true on successful addition
- Returns false on addition failure
- Converts Pet entity to PetModel before saving
- Throws exception on data source failure

**deletePet():**
- Returns true on successful deletion
- Returns false on deletion failure
- Throws exception on data source failure

**updatePet():**
- Returns true on successful update
- Returns false on update failure
- Converts Pet entity to PetModel before updating
- Throws exception on data source failure

**Total: 16 tests**

#### `event_repository_impl_test.dart`
Tests for `EventRepositoryImpl` with mocked `EventLocalDataSource`:

**getEventsByPetId():**
- Returns list of events successfully
- Returns empty list when no events exist
- Throws exception on data source failure

**addEvent():**
- Adds event successfully
- Converts Event entity to EventModel before adding
- Throws exception on data source failure

**deleteEvent():**
- Deletes event successfully
- Throws exception on data source failure

**updateEvent():**
- Updates event successfully
- Converts Event entity to EventModel before updating
- Throws exception on data source failure

**Total: 12 tests**

### Cubits (BLoC)

#### `add_pet_cubit_test.dart`
Tests for `AddPetCubit` state management:
- **addPet()**: Emits [loading, success] on successful pet addition
- **addPet()**: Emits [loading, error] when addition fails
- **addPet()**: Handles exceptions gracefully
- **Initial state**: Verifies correct initialization

**Total: 4 tests**

#### `home_cubit_test.dart`
Tests for `HomeCubit` state management:
- **getPets()**: Emits [loading, success] when pets fetched successfully
- **getPets()**: Handles empty pet list
- **getPets()**: Handles exceptions gracefully
- **Initial state**: Verifies correct initialization with empty pets list

**Total: 4 tests**

#### `pet_details_cubit_test.dart`
Tests for `PetDetailsCubit` state management:

**editPet():**
- Emits [loading, success, reset] on successful edit

**deletePet():**
- Emits [loading, success] on successful deletion

**getPetEvents():**
- Emits [loading, success] when events fetched
- Handles empty event list

**addEvent():**
- Emits [loading, success, reset] on successful addition

**updateEvent():**
- Emits [loading, success, reset] on successful update

**deleteEvent():**
- Emits [loading, success, reset] on successful deletion

**Total: 8 tests**

## Running Tests

### Run All Tests
```bash
flutter test
```

### Run Tests with Coverage
```bash
flutter test --coverage
```

### Run Specific Test File
```bash
flutter test test/data/local/models/pet_model_test.dart
```

### Run Tests Matching Pattern
```bash
flutter test --name "PetModel"
```

### Run with Verbose Output
```bash
flutter test -v
```

## Testing Tools & Dependencies

- **flutter_test**: Core Flutter testing framework
- **bloc_test**: BLoC testing utilities for state management tests
- **mocktail**: Mocking library for creating mock objects

## Test Patterns Used

### 1. Unit Testing Models
- Constructor and factory method testing
- JSON serialization/deserialization verification
- Equality and roundtrip conversion tests

### 2. Unit Testing Repositories
- Mocking data sources with `mocktail`
- Verifying repository delegation to data sources
- Error handling and exception testing
- Model conversion verification

### 3. Unit Testing Cubits/BLoCs
- Using `bloc_test` for state emission verification
- Testing state transitions with `blocTest`
- Mocking repositories with `mocktail`
- Verifying repository method calls
- Initial state validation

## Best Practices Followed

1. ✅ **Isolation**: Each test is independent and doesn't depend on others
2. ✅ **Clarity**: Test names clearly describe what is being tested
3. ✅ **Mocking**: External dependencies (repositories, data sources) are mocked
4. ✅ **Arrangement**: Tests follow the AAA pattern (Arrange, Act, Assert)
5. ✅ **Coverage**: Tests cover happy paths, edge cases, and error scenarios
6. ✅ **Clean Teardown**: Resources are properly cleaned up after tests

## Total Test Count

| Category | Count |
|----------|-------|
| Model Tests | 12 |
| Repository Tests | 28 |
| Cubit Tests | 16 |
| **Total** | **56** |

## Future Enhancements

- Add integration tests for data persistence
- Add widget tests for UI components
- Increase coverage thresholds as more functionality is added
- Add end-to-end tests for critical user flows
