# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **SwiftUI iOS application** for Flovatar, a Flow blockchain-based NFT gaming platform. The app integrates with the Flow blockchain to authenticate users via their Flow wallets and allows them to browse Flovatar NFTs and play mini-games.

## Build & Run

Since this is an Xcode project without command-line build configuration exposed:

1. Open `Flovatar.xcodeproj` in Xcode
2. Select a simulator or device target
3. Build and run using Xcode's standard build system (Cmd+R)

**Note**: Xcode command-line tools may not be fully configured for this project. Prefer using Xcode GUI for building.

## Project Structure

### Core Architecture

The app follows an **MVVM (Model-View-ViewModel)** pattern with SwiftUI views:

- **Views**: SwiftUI view files (`*View.swift`) define UI components
- **ViewModels**: Observable objects (`*ViewModel.swift`) manage state and business logic
- **Models**: Data structures in `Flovatar/Model/`
  - `Flovatar.swift` - Main NFT model (large auto-generated file with comprehensive Flovatar data)
  - `ScoreModel.swift` - Game score tracking
  - `MiniGames.swift` - Game type enumeration

### Navigation Flow

The app uses a multi-step navigation pattern:

1. **HomeStep1** - Main entry point (defined in `FCLDemoApp.swift:29`)
2. **HomeStep2** - Secondary home view
3. **ChooseYourPlayer** - Flovatar selection
4. **BrowseFlovatars** - NFT browsing
5. **MiniGamesView** - Game selection hub

Navigation is managed via `NavigationUtil` (injected as environment object).

### Flow Blockchain Integration

**FCLAuthSwift** is a custom fork of the Flow Client Library embedded in this repository at `FCLAuthSwift/`:

- **Package**: Swift Package Manager package (`Package.swift`)
- **Auth Provider**: Blocto wallet (configured in `AuthHelper.swift:37`)
- **URL Scheme**: `flovatar://` (defined in `Info.plist:30`)
- **Authentication**: Handled by singleton `AuthHelper.shared` using FCL delegate pattern
- **User State**: Stored in UserDefaults (`loggedAddress`, `isLoggedIn`)

### API Communication

**Backend API** (`flovatar.com`):

- `LinkBuilder` - Fluent URL builder for API endpoints
- `NFTAPIClient` - Handles HTTP requests for:
  - Fetching Flovatars by address: `/collection/api/{address}?page={n}`
  - Leaderboard scores: `/api/leaderboard/address/{address}` and `/api/leaderboard/game/{gameId}`
  - Posting scores: `POST /api/leaderboard`

### Mini-Games

Two mini-games are implemented in `Flovatar/MiniGames/`:

1. **WhackAFlovatar** - Whack-a-mole style game
2. **WhereIsWaldo** - Find the specific Flovatar game

Each game follows the same structure:
- `*View.swift` - Game UI
- `*ViewModel.swift` - Game logic and state
- `*Levels.swift` - Level configuration
- `*Model.swift` - Game-specific data models

### Reusable Components

`Flovatar/Subviews/` contains shared UI components:

- **Button Styles**: `CapsuleButtonStyle`, `Rectangle3DButtonStyle`, `FilledButtonStyle`
- **Game UI**: `ReadyGameView`, `PausedGameView`, `SummaryView`, `ScoreView`
- **Loaders**: `CircleLoadingView`, `LoadingView`, `LottieView`
- **Media**: `SVGImage`, `SVGUrlImage`, `WebView`
- **Layout**: `BackgroundGradientView`, `BounceView`, `ProgressCircleView`

### Utilities

- **AuthHelper** - Singleton for FCL authentication management
- **ScoreCalculator** - Game scoring logic
- **NavigationUtil** - App-wide navigation coordinator (ObservableObject)
- **ScreenAdaptor** - Screen size adaptation utilities
- **LinkBuilder** - API URL construction

### Extensions

`Flovatar/Extensions/` provides SwiftUI and Foundation extensions:
- `Extension+Font.swift` - Custom font definitions (uses Staatliches, RobotoCondensed)
- `Extension+Color.swift` - App color palette
- `Extension+View.swift` - View modifiers
- `Extension+Array.swift` - Array utilities

## Key Technical Details

### Custom Fonts
Three custom fonts are embedded (see `Info.plist:38-43`):
- Staatliches-Regular.ttf
- RobotoCondensed-Bold.ttf
- RobotoCondensed-Regular.ttf

### App Configuration
- **Bundle ID Pattern**: `com.flow.flovatar`
- **Orientation**: Portrait only (iPhone), all orientations (iPad)
- **UI Style**: Light mode only (`Info.plist:76`)
- **Status Bar**: Hidden

### Authentication Flow
1. User taps to authenticate
2. `AuthHelper.auth()` calls `fcl.authenticate(provider: .blocto)`
3. FCL opens ASWebAuthenticationSession for Blocto wallet
4. On success, wallet address stored in UserDefaults
5. Address used for API calls to fetch user's Flovatars and scores

### Data Flow Example
Fetching user data (see `HomeStep1ViewModel.swift:78-134`):
1. Build API URL with `LinkBuilder`
2. Create `NFTAPIClient` with URL
3. Use DispatchGroup to coordinate parallel API calls:
   - Fetch user's Flovatars
   - Fetch user's leaderboard scores
4. Update UI on main thread when both complete

## Development Patterns

### ViewModel Pattern
ViewModels are ObservableObjects with @Published properties:
```swift
final class SomeViewModel: ObservableObject {
    @Published var someState: String = ""
    // Business logic methods
}
```

### API Client Usage
```swift
let url = LinkBuilder()
    .getFlovatars(forAddress: address, page: 1)
    .build()
let client = NFTAPIClient(url: url)
client.listNFTsForAddress(address: address) { result in
    // Handle result
}
```

### Navigation
NavigationUtil is injected as environment object and used to coordinate navigation state across the app.

## Important Notes

- **Flovatar.swift is auto-generated**: The model file is extremely large (85k+ tokens) and appears to be generated from backend schema
- **No test files present**: The repository doesn't include unit or UI tests
- **API is live**: All API calls point to production `flovatar.com`
- **FCLAuthSwift is forked**: This is a modified version specifically for Flovatar (see `FCLAuthSwift/README.md`)
