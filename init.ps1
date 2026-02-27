#!/bin/pwsh
$Work = Get-Location

# Check and install Git if not present
Write-Host "Checking Git installation..." -ForegroundColor Cyan
$gitInstalled = Get-Command git -ErrorAction SilentlyContinue
if (-not $gitInstalled) {
    Write-Host "Git is not installed. Installing via Winget..." -ForegroundColor Yellow
    winget install --id Git.Git -e --source winget --accept-package-agreements --accept-source-agreements
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Git installed successfully." -ForegroundColor Green
        # Refresh environment variables
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    } else {
        Write-Host "Failed to install Git. Please install manually." -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "Git is already installed." -ForegroundColor Green
}

# Check and install Docker if not present
Write-Host "Checking Docker installation..." -ForegroundColor Cyan
$dockerInstalled = Get-Command docker -ErrorAction SilentlyContinue
if (-not $dockerInstalled) {
    Write-Host "Docker is not installed. Installing via Winget..." -ForegroundColor Yellow
    winget install --id Docker.DockerDesktop -e --source winget --accept-package-agreements --accept-source-agreements
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Docker Desktop installed successfully." -ForegroundColor Green
        Write-Host "Please start Docker Desktop and run this script again." -ForegroundColor Yellow
        exit 0
    } else {
        Write-Host "Failed to install Docker. Please install manually." -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "Docker is already installed." -ForegroundColor Green
}

Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"

# Wait for Docker daemon to be ready
Write-Host "Waiting for Docker daemon to start..." -ForegroundColor Cyan
$maxRetries = 30
$retryCount = 0
while ($retryCount -lt $maxRetries) {
    $dockerInfo = docker info 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Docker daemon is ready." -ForegroundColor Green
        break
    }
    $retryCount++
    Write-Host "Waiting... ($retryCount/$maxRetries)" -ForegroundColor Yellow
    Start-Sleep -Seconds 2
}

if ($retryCount -eq $maxRetries) {
    Write-Host "Docker daemon failed to start within the expected time." -ForegroundColor Red
    Write-Host "Please start Docker Desktop manually and run this script again." -ForegroundColor Yellow
    exit 1
}

# Load .env file if exists, otherwise copy from sample
if(!(Test-Path .env)) {
    Copy-Item .env.sample .env
}

# Read branch settings from .env
$envContent = Get-Content .env
$TheFoolBranch = "release"
$TheMagicianBranch = "main"
foreach ($line in $envContent) {
    if ($line -match "^THE_FOOL_BRANCH=(.+)$") {
        $TheFoolBranch = $Matches[1]
    }
    if ($line -match "^THE_MAGICIAN_BRANCH=(.+)$") {
        $TheMagicianBranch = $Matches[1]
    }
}
Write-Host "Using branches: the-fool=$TheFoolBranch, the-magician=$TheMagicianBranch" -ForegroundColor Cyan

# the-fool
if (!(test-path repo/the-fool)) {
  git clone https://github.com/sweshelo/the-fool repo/the-fool
}

Set-Location "$Work/repo/the-fool";
git fetch
git switch $TheFoolBranch
git pull origin $TheFoolBranch
Set-Location $Work

# the-magician
if (!(test-path repo/the-magician)) {
  git clone https://github.com/sweshelo/the-magician repo/the-magician
}

Set-Location "$Work/repo/the-magician";
git fetch
git switch $TheMagicianBranch
git pull origin $TheMagicianBranch
Set-Location $Work

if(!(test-path .env)) {
  Copy-Item .env.sample .env
}

Write-Host "Building Docker images..." -ForegroundColor Cyan
docker compose build
if ($LASTEXITCODE -ne 0) {
    Write-Host "Docker compose build failed." -ForegroundColor Red
    Write-Host "Please check if Docker daemon is running and try again." -ForegroundColor Yellow
    exit 1
}
Write-Host "Build completed successfully." -ForegroundColor Green

Write-Host "Starting services..." -ForegroundColor Cyan
docker compose up -d
if ($LASTEXITCODE -ne 0) {
    Write-Host "Docker compose up failed." -ForegroundColor Red
    Write-Host "Please check the error messages above and Docker daemon status." -ForegroundColor Yellow
    exit 1
}

Write-Host ""
Write-Host "サービスの起動に成功しました" -ForegroundColor Green
Write-Host "ログを確認するには     : docker compose logs -f" -ForegroundColor Cyan
Write-Host "サービスを停止するには : docker compose down" -ForegroundColor Cyan
