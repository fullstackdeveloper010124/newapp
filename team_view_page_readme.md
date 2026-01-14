# Team View Page Implementation

## Overview
Your Flutter app now includes a comprehensive team view page with the following features:
- Dropdown to select team members
- Display of key metrics for the selected team member (Total Tasks, Closed, In Progress, % Complete)
- List of tasks assigned to the selected team member with details (Item, Priority, Status, Due Date)

## Features
- Interactive dropdown to select team members
- Visual display of team member statistics
- Task list specific to the selected team member
- Color-coded priority and status indicators
- Responsive design that works on different screen sizes
- Consistent color scheme with the rest of the app

## Components

### Team Member Selection
- Dropdown menu with list of team members
- Easy selection of different team members to view their stats and tasks

### Team Member Statistics
- Total Tasks: Shows the total number of tasks assigned to the member
- Closed: Shows the number of completed tasks
- In Progress: Shows the number of active tasks
- % Complete: Shows the percentage of completed tasks

### Task List
- Displays all tasks assigned to the selected team member
- Each task shows: Item, Priority, Status, and Due Date
- Color-coded priority badges (Red for High, Orange for Medium, Green for Low)
- Color-coded status indicators (Green for Closed, Orange for In Progress, Grey for Pending)

## Color Scheme
- Background: #1A1F26 (dark background)
- Highlight/Accent: #4FD1C5 (teal color)
- Priority colors: Red for High, Orange for Medium, Green for Low
- Status colors: Green for Closed, Orange for In Progress, Grey for Pending
- Text: White for main content, grey for secondary text
- Card background: #2D3748 (slightly lighter dark shade)

## Files Created/Modified
- `lib/team_view_page.dart`: New file containing the complete team view page implementation
- `lib/main.dart`: Modified to import the team view page
- `lib/dashboard_page.dart`: Modified to navigate to team view page

## Navigation Flow
- From dashboard page: Tap the people icon in the app bar to navigate to team view page
- From team view page: Users can select different team members and view their stats and tasks

## Sample Data
The team view page currently uses sample data for demonstration purposes. In a real application, this would be replaced with actual data from your backend or database.

## Customization Options
You can customize the team view page by modifying the `TeamViewPage` widget in `lib/team_view_page.dart`:

- Update sample data with real data from your backend
- Modify the team member list to match your actual team
- Add additional team member metrics
- Change the priority or status options
- Modify the task display format
- Add filtering or sorting options for tasks

## Running the App
Execute the following command from the project directory:
```
flutter run
```

The app will start with the splash screen, then navigate to the login page after 3 seconds, or you can click the "Go to Login" button from the home page. After successful login or signup, you'll be taken to the dashboard page. From the dashboard page, tap the people icon in the app bar to navigate to the team view page.