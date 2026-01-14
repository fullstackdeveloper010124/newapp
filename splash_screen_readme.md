# Splash Screen Implementation

## Overview
Your Flutter app now includes a splash screen that appears when the app launches. The splash screen displays:
- App logo/icon
- App title "My Flutter App"
- Loading indicator
- Dark background (#1A1F26)
- Highlight color (#4FD1C5)

## How it Works
1. When the app launches, the `SplashScreen` widget is displayed first
2. After 3 seconds, the app automatically navigates to the main home page
3. The transition uses `Navigator.pushReplacement()` to replace the splash screen with the main page

## Customization Options
You can customize the splash screen by modifying the `SplashScreen` widget in `lib/main.dart`:

- Change the logo: Modify the `Icon` widget or replace it with an `Image.asset()`
- Adjust timing: Change the `Duration(seconds: 3)` to show the splash screen for a different duration
- Modify colors: Update the color properties in the UI elements (background: #1A1F26, highlight: #4FD1C5)
- Add animations: Integrate animation widgets for more engaging transitions

## Files Modified
- `lib/main.dart`: Added `SplashScreen` widget and updated the `MaterialApp` to use it as the initial route

## Running the App
Execute the following command from the project directory:
```
flutter run
```

Or double-click the `run_app.bat` file to run the application.