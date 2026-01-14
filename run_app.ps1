# PowerShell script to run the Flutter app
Write-Host "Starting Flutter app..." -ForegroundColor Green

# Get the current directory
$currentDir = Get-Location

Write-Host "Current directory: $currentDir" -ForegroundColor Yellow

# Run flutter pub get to ensure dependencies are up to date
Write-Host "Getting dependencies..." -ForegroundColor Cyan
flutter pub get

if ($LASTEXITCODE -ne 0) {
    Write-Host "Error getting dependencies!" -ForegroundColor Red
    exit 1
}

Write-Host "Dependencies updated successfully!" -ForegroundColor Green

# Run the app
Write-Host "Launching the app..." -ForegroundColor Cyan
flutter run