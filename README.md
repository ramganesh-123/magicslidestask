# MagicSlides - Presentation Generator App

## Overview
MagicSlides is a mobile application that generates professional presentations using AI. Users can create presentations by simply entering a topic and customizing various options like template style, language, and slide count.

## Setup Instructions

### Requirements
- Flutter SDK 3.0 or higher
- Android Studio or VS Code
- Android device/emulator or iOS device/simulator

### Installation Steps

1. Clone the repository or extract the project files

2. Open terminal in project directory and run:
   ```
   flutter pub get
   ```

3. Configure API credentials in `lib/app/core/config/app_config.dart`:
   - Add Supabase URL
   - Add Supabase Anon Key
   - Add MagicSlides Access ID

4. Run the application:
   ```
   flutter run
   ```

5. To build APK for Android:
   ```
   flutter build apk --release
   ```

## Database Information

The application uses **Supabase** as the backend database solution. Supabase provides:
- User authentication and authorization
- PostgreSQL database for storing user information
- Real-time data synchronization
- Secure session management

Additionally, **SharedPreferences** is used for local data persistence including:
- Authentication tokens
- User preferences
- Theme settings

## Application Architecture

The project follows **MVC (Model-View-Controller)** architecture pattern with **GetX** state management.

### Project Structure
```
lib/
├── app/
│   ├── controllers/          # GetX controllers for business logic
│   ├── screens/              # UI screens and views
│   ├── data/
│   │   ├── models/           # Data models
│   │   ├── services/         # Service classes
│   │   └── repositories/     # Repository pattern implementation
│   ├── core/
│   │   ├── config/           # Configuration files
│   │   └── theme/            # Theme configuration
│   └── routes/               # Navigation routes
└── main.dart                 # Application entry point
```

### Architecture Components

**Models**: Define data structures for User, Presentation, and API responses

**Views**: Flutter widgets that display UI to users (Login, Home, Result screens)

**Controllers**: Manage state and business logic using GetX
- AuthController - Handles authentication
- HomeController - Manages presentation generation
- PdfPreviewController - Controls PDF viewing

**Services**: Handle external communications
- AuthService - Supabase authentication
- MagicSlidesService - API integration
- StorageService - Local data management

**Repositories**: Abstract data layer for services

## Known Issues

### 1. Controller Lifecycle Management
Initially faced issues with TextEditingController disposal after logout. This was resolved by implementing proper controller initialization with the permanent flag in GetX dependency injection.

### 2. API Response Handling
The MagicSlides API sometimes returns success status with error messages in nested data. Implemented additional validation to properly handle these cases.

### 3. Session Persistence
Added delay mechanism in splash screen to ensure Supabase session is fully restored before navigation decisions are made.

### 4. File Permissions
Android requires runtime permissions for file downloads. Implemented permission_handler package to manage storage access properly.

### 5. PDF Viewing
Using Syncfusion PDF viewer which requires the full file to be downloaded before preview. Works well but may take time on slower connections.

## Application Features

- User registration and login with email/password
- Persistent authentication sessions
- Presentation generation from topic input
- Template selection (Default/Editable)
- Customizable options:
  - Slide count
  - Language selection
  - Model selection
  - AI image generation
  - Watermark configuration
- PDF preview of generated presentations
- Download presentations to device
- Dark and light theme support
- Logout functionality

## Dependencies

Main packages used in the project:
- get (State management)
- supabase_flutter (Backend and authentication)
- dio (HTTP client for API calls)
- shared_preferences (Local storage)
- syncfusion_flutter_pdfviewer (PDF viewing)
- permission_handler (File permissions)
- path_provider (File system access)

## Notes

The application requires active internet connection to:
- Authenticate users
- Generate presentations via API
- Download and preview PDFs

Local storage is used to maintain login sessions so users don't need to login every time they open the app.

---

**Development Environment**: Flutter, Android Studio
**State Management**: GetX
**Backend**: Supabase
**API Integration**: MagicSlides API