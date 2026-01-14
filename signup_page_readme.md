# Sign Up Page Implementation

## Overview
Your Flutter app now includes a comprehensive sign up page with the following fields:
- Logo at the top
- Full Name field
- Email Address field
- Password field
- Confirm Password field
- Role selection dropdown

The sign up page uses the same color scheme as requested: background color #1A1F26 and highlight color #4FD1C5.

## Features
- Form validation for all fields
- Password confirmation matching
- Email format validation
- Role selection dropdown with predefined options
- Responsive design that works on different screen sizes
- Error messaging for invalid inputs
- Navigation to login page if user already has an account

## Validation
The form includes validation for:
- Full Name: Cannot be empty
- Email: Must be a valid email format
- Password: Must be at least 6 characters
- Confirm Password: Must match the password field
- Role: Must be selected from the dropdown

## Color Scheme
- Background: #1A1F26 (dark background)
- Highlight/Accent: #4FD1C5 (teal color)
- Text: White for input fields, teal for labels
- Input field background: #2D3748 (slightly lighter dark shade)

## Files Created/Modified
- `lib/signup_page.dart`: New file containing the complete sign up page implementation
- `lib/main.dart`: Modified to import the signup page and navigate to it from both the splash screen and home page

## Navigation
- From splash screen: Automatically navigates to signup page after 3 seconds
- From home page: Button to navigate to signup page
- From signup page: Link to navigate back to login (currently goes back to home page)

## Customization Options
You can customize the sign up page by modifying the `SignupPage` widget in `lib/signup_page.dart`:

- Add more roles to the dropdown by modifying the list in the DropdownButtonFormField
- Change validation rules in the validator functions
- Modify styling by adjusting the color values and padding/margin settings
- Add additional fields by inserting new TextFormField widgets
- Change the logo icon by modifying the Icon widget in the logo container

## Running the App
Execute the following command from the project directory:
```
flutter run
```

The app will start with the splash screen, then navigate to the signup page after 3 seconds, or you can click the "Go to Sign Up" button from the home page.