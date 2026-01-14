# Timeline Page Implementation

## Overview
Your Flutter app now includes a comprehensive timeline page with the following features:
- Timeline & Schedule view with month/year calendar selector
- Calendar view showing scheduled events
- "This Week" section displaying tasks for the current week
- "Upcoming" section showing future tasks
- "Overdue" section highlighting overdue tasks
- "Upcoming Deadlines" section showing approaching deadlines
- Task Timeline (Gantt) chart visualizing project schedules

## Features
- Interactive calendar view using TableCalendar widget
- Month/year navigation controls
- Color-coded status indicators for tasks
- Gantt chart visualization for task timelines
- Filtering of tasks by time period (This Week, Upcoming, Overdue, etc.)
- Responsive design that works on different screen sizes
- Consistent color scheme with the rest of the app

## Components

### Calendar View
- Month/Year selector with calendar view
- Visual indication of current day
- Ability to select dates
- Customizable calendar styling

### This Week Section
- Lists all tasks scheduled for the current week
- Shows task title, date range, and assignee
- Color-coded status indicators

### Upcoming Section
- Displays tasks scheduled for future dates
- Sorted chronologically
- Includes task details and status

### Overdue Section
- Highlights tasks that have passed their due date
- Shows urgency with color coding
- Includes overdue tasks that are not completed

### Upcoming Deadlines Section
- Shows tasks with deadlines approaching within a week
- Helps prioritize urgent tasks
- Clear visual indicators

### Task Timeline (Gantt) Chart
- Visual representation of task durations
- Progress indicators for ongoing tasks
- Color coding by priority and status
- Date ranges clearly shown

## Color Scheme
- Background: #1A1F26 (dark background)
- Highlight/Accent: #4FD1C5 (teal color)
- Status colors: Green for completed, Orange for in-progress, Red for overdue, Blue for scheduled
- Text: White for main content, grey for secondary text
- Card background: #2D3748 (slightly lighter dark shade)

## Dependencies
- `table_calendar`: Used for creating the interactive calendar view

## Files Created/Modified
- `lib/timeline_page.dart`: New file containing the complete timeline page implementation
- `pubspec.yaml`: Added table_calendar dependency
- `lib/main.dart`: Modified to import the timeline page
- `lib/dashboard_page.dart`: Modified to navigate to timeline page

## Navigation Flow
- From dashboard page: Tap the timeline icon in the app bar to navigate to timeline page
- From timeline page: Users can view schedules and task timelines

## Sample Data
The timeline page currently uses sample data for demonstration purposes. In a real application, this would be replaced with actual data from your backend or database.

## Customization Options
You can customize the timeline page by modifying the `TimelinePage` widget in `lib/timeline_page.dart`:

- Update sample data with real data from your backend
- Modify calendar styling by adjusting the TableCalendar properties
- Change the Gantt chart visualization to suit your needs
- Add additional filtering options
- Modify the date calculation logic for different time periods
- Enhance the Gantt chart with drag-and-drop functionality

## Running the App
Execute the following command from the project directory:
```
flutter run
```

The app will start with the splash screen, then navigate to the login page after 3 seconds, or you can click the "Go to Login" button from the home page. After successful login or signup, you'll be taken to the dashboard page. From the dashboard page, tap the timeline icon in the app bar to navigate to the timeline page.