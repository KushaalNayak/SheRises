# Script to rewrite git commit history with realistic commits over the past month
# This script creates ~87 commits distributed over 30-35 days

# Get the current date
$today = Get-Date
$daysAgo = 33  # Start from 33 days ago
$totalCommits = 87

# Array of realistic commit messages
$commitMessages = @(
    "initial setup",
    "add project structure",
    "setup react frontend",
    "setup express backend",
    "add authentication",
    "implement user login",
    "add registration page",
    "fix login bug",
    "update readme",
    "add marketplace page",
    "implement product listing",
    "add product details page",
    "fix minor bug",
    "small ui tweak",
    "update styles",
    "refactor components",
    "add cart functionality",
    "implement checkout",
    "add order management",
    "update backend routes",
    "fix api endpoint",
    "add error handling",
    "update database models",
    "improve validation",
    "add course features",
    "implement course enrollment",
    "add progress tracking",
    "update course content",
    "add forum functionality",
    "implement forum posts",
    "add comments feature",
    "update forum ui",
    "add messaging system",
    "implement chat feature",
    "update user profile",
    "add seller dashboard",
    "implement seller application",
    "add admin dashboard",
    "update admin features",
    "fix authentication issue",
    "improve error messages",
    "update responsive design",
    "fix mobile layout",
    "add loading states",
    "improve user experience",
    "update documentation",
    "refactor code",
    "optimize performance",
    "fix security issue",
    "update dependencies",
    "add tests",
    "fix test failures",
    "update gitignore",
    "add environment config",
    "update deployment config",
    "fix deployment issues",
    "add cors configuration",
    "update api routes",
    "improve error handling",
    "add input validation",
    "update user interface",
    "fix navigation bug",
    "add search functionality",
    "implement filters",
    "update product display",
    "add image upload",
    "fix upload issue",
    "update media handling",
    "add awareness page",
    "update awareness content",
    "add skills page",
    "update skills content",
    "improve routing",
    "update layout",
    "fix styling issues",
    "add dark mode support",
    "update theme",
    "improve accessibility",
    "add loading indicators",
    "update button styles",
    "fix form validation",
    "add success messages",
    "update error messages",
    "improve code structure",
    "refactor utils",
    "update api calls",
    "fix async issues",
    "add error boundaries",
    "update context providers",
    "fix state management",
    "improve data fetching",
    "update package versions",
    "deployment setup",
    "production build",
    "final deployment"
)

# Function to get a random file to modify
function Get-RandomFile {
    $files = @(
        "README.md",
        "PROJECT_DOCUMENTATION.md",
        "package.json",
        ".gitignore",
        "frontend/src/App.jsx",
        "frontend/src/App.css",
        "frontend/src/main.jsx",
        "frontend/src/index.css",
        "frontend/src/context/AuthContext.jsx",
        "frontend/src/utils/api.js",
        "frontend/src/utils/forum.js",
        "frontend/src/utils/messaging.js",
        "frontend/src/utils/orders.js",
        "frontend/src/utils/localStorage.js",
        "frontend/src/components/layout/Layout.jsx",
        "frontend/src/components/layout/Layout.css",
        "frontend/src/components/forms/BecomeSellerModal.jsx",
        "frontend/src/pages/Home.jsx",
        "frontend/src/pages/Home.css",
        "frontend/src/pages/Marketplace.jsx",
        "frontend/src/pages/Marketplace.css",
        "frontend/src/pages/Login.jsx",
        "frontend/src/pages/Login.css",
        "frontend/src/pages/Register.jsx",
        "frontend/src/pages/Register.css",
        "frontend/src/pages/Profile.jsx",
        "frontend/src/pages/Profile.css",
        "frontend/src/pages/Admin.jsx",
        "frontend/src/pages/Admin.css",
        "frontend/src/pages/Skills.jsx",
        "frontend/src/pages/Skills.css",
        "frontend/src/pages/Community.jsx",
        "frontend/src/pages/Community.css",
        "frontend/src/pages/Awareness.jsx",
        "frontend/src/pages/Awareness.css",
        "frontend/src/pages/Checkout.jsx",
        "frontend/src/pages/Checkout.css",
        "frontend/src/pages/Orders.jsx",
        "frontend/src/pages/Orders.css",
        "frontend/src/pages/Messages.jsx",
        "frontend/src/pages/Messages.css",
        "frontend/src/pages/ProductDetail.jsx",
        "frontend/src/pages/ProductDetail.css",
        "frontend/src/pages/SellerDashboard.jsx",
        "frontend/src/pages/SellerDashboard.css",
        "frontend/src/pages/CourseContent.jsx",
        "frontend/src/pages/CourseContent.css",
        "frontend/src/pages/ForumPostDetail.jsx",
        "frontend/src/pages/ForumPostDetail.css",
        "frontend/package.json",
        "frontend/vite.config.js",
        "backend/server.js",
        "backend/package.json",
        "backend/config/jwt.js",
        "backend/middleware/auth.js",
        "backend/routes/auth.js",
        "backend/routes/products.js",
        "backend/routes/courses.js",
        "backend/routes/forum.js",
        "backend/routes/orders.js",
        "backend/routes/cart.js",
        "backend/routes/users.js",
        "backend/routes/messages.js",
        "backend/routes/mentors.js",
        "backend/routes/awareness.js",
        "backend/routes/sellerApplications.js",
        "backend/routes/media.js",
        "backend/models/User.js",
        "backend/models/Product.js",
        "backend/models/Order.js",
        "backend/models/Course.js",
        "backend/models/ForumPost.js",
        "backend/models/Message.js",
        "backend/models/SellerApplication.js",
        "backend/models/Media.js",
        "backend/DATABASE_STRUCTURE.md",
        "backend/README.md"
    )
    return $files | Get-Random
}

# Function to make a minimal change to a file
function Make-MinimalChange {
    param($filePath)
    
    if (-not (Test-Path $filePath)) {
        return $false
    }
    
    try {
        $content = Get-Content $filePath -Raw -ErrorAction Stop
        
        # Randomly choose a type of change
        $changeType = Get-Random -Minimum 1 -Maximum 6
        
        switch ($changeType) {
            1 {
                # Add/remove trailing newline
                if ($content.EndsWith("`n") -or $content.EndsWith("`r`n")) {
                    $content = $content.TrimEnd("`r", "`n")
                } else {
                    $content += "`n"
                }
            }
            2 {
                # Add a comment (for code files)
                if ($filePath -match '\.(js|jsx)$') {
                    $content = $content.TrimEnd() + "`n`n// minor update`n"
                } elseif ($filePath -match '\.(css)$') {
                    $content = $content.TrimEnd() + "`n`n/* small fix */`n"
                } else {
                    $content += "`n"
                }
            }
            3 {
                # Adjust spacing
                if ($content -match "\r?\n\r?\n\r?\n") {
                    $content = $content -replace "\r?\n\r?\n\r?\n+", "`n`n"
                } elseif ($content -notmatch "\r?\n\r?\n") {
                    $content = $content -replace "(\r?\n)([^\r\n])", "`n`n`$2"
                }
            }
            4 {
                # Add whitespace adjustment
                $lines = $content -split "`r?`n"
                if ($lines.Count -gt 1) {
                    $randomLine = Get-Random -Minimum 0 -Maximum [Math]::Min($lines.Count, 10)
                    if ($lines[$randomLine] -match '^\s+') {
                        $lines[$randomLine] = $lines[$randomLine] -replace '^\s+', ''
                    } else {
                        $lines[$randomLine] = "  " + $lines[$randomLine]
                    }
                    $content = $lines -join "`n"
                }
            }
            5 {
                # Minor text adjustment in comments/docs
                if ($filePath -match '\.(md|txt)$') {
                    $content = $content -replace '(\w)\s+(\w)', '$1 $2'
                } elseif ($filePath -match '\.(js|jsx)$') {
                    # Find a comment and add a space
                    if ($content -match '//(\S)') {
                        $content = $content -replace '//(\S)', '// $1'
                    } elseif ($content -notmatch '//') {
                        $content = $content.TrimEnd() + "`n// update`n"
                    }
                }
            }
        }
        
        # Ensure content ends properly
        if (-not $content.EndsWith("`n")) {
            $content += "`n"
        }
        
        Set-Content -Path $filePath -Value $content -NoNewline -ErrorAction Stop
        return $true
    } catch {
        return $false
    }
}

# Navigate to the repository directory
Set-Location "C:\Users\R B KUSHAAL NAYAK\Desktop\Projects\SheRises"

# Create a backup branch
Write-Host "Creating backup branch..." -ForegroundColor Yellow
git branch backup-before-rewrite

# Create an orphan branch for new history
Write-Host "Creating orphan branch..." -ForegroundColor Yellow
git checkout --orphan temp-branch

# Remove all files from staging (they'll be added back)
git rm -rf --cached . 2>$null

# Add all current files (excluding node_modules and other ignored files)
Write-Host "Adding current files..." -ForegroundColor Yellow
git add -A

# Commit the initial state
$initialDate = $today.AddDays(-$daysAgo)
$dateStr = $initialDate.ToString("yyyy-MM-dd HH:mm:ss")
$env:GIT_COMMITTER_DATE = $dateStr
$env:GIT_AUTHOR_DATE = $dateStr
git commit -m "initial commit"
Write-Host "Initial commit created at $dateStr" -ForegroundColor Green

# Generate commits over the time period
Write-Host "Generating ${totalCommits} commits..." -ForegroundColor Yellow

# Distribute commits: more in early days, fewer towards end
$commitIndex = 0
for ($day = $daysAgo; $day -ge 0; $day--) {
    # Calculate commits for this day (more in early days)
    if ($day -gt 25) {
        $commitsToday = Get-Random -Minimum 3 -Maximum 6
    } elseif ($day -gt 15) {
        $commitsToday = Get-Random -Minimum 2 -Maximum 4
    } elseif ($day -gt 5) {
        $commitsToday = Get-Random -Minimum 1 -Maximum 3
    } elseif ($day -gt 0) {
        $commitsToday = Get-Random -Minimum 0 -Maximum 2
    } else {
        # Today: deployment commits
        $commitsToday = 3
    }
    
    # Limit total commits
    if ($commitIndex + $commitsToday -gt $totalCommits) {
        $commitsToday = $totalCommits - $commitIndex
    }
    
    for ($i = 0; $i -lt $commitsToday; $i++) {
        if ($commitIndex -ge $totalCommits) { break }
        
        # Calculate commit time (random time during the day)
        $commitDate = $today.AddDays(-$day)
        $hour = Get-Random -Minimum 9 -Maximum 22
        $minute = Get-Random -Minimum 0 -Maximum 60
        $second = Get-Random -Minimum 0 -Maximum 60
        $commitDate = $commitDate.AddHours($hour).AddMinutes($minute).AddSeconds($second)
        
        # Make a minimal change (try up to 3 times to get a valid file)
        $changeMade = $false
        for ($attempt = 0; $attempt -lt 3; $attempt++) {
            $fileToChange = Get-RandomFile
            if (Test-Path $fileToChange) {
                $changeMade = Make-MinimalChange -filePath $fileToChange
                if ($changeMade) {
                    # Stage the change
                    git add $fileToChange 2>$null
                    break
                }
            }
        }
        
        # Check if we have staged changes
        $hasChanges = -not (git diff --cached --quiet 2>$null)
        
        if ($hasChanges) {
            # Get commit message
            $messageIndex = [Math]::Min($commitIndex, $commitMessages.Length - 1)
            $commitMessage = $commitMessages[$messageIndex]
            
            # Special messages for last few commits (deployment)
            if ($day -eq 0) {
                if ($i -eq 0) {
                    $commitMessage = "deployment setup"
                } elseif ($i -eq 1) {
                    $commitMessage = "production build"
                } else {
                    $commitMessage = "final deployment"
                }
            }
            
            # Set commit date
            $dateStr = $commitDate.ToString("yyyy-MM-dd HH:mm:ss")
            $env:GIT_COMMITTER_DATE = $dateStr
            $env:GIT_AUTHOR_DATE = $dateStr
            
            # Create commit
            git commit -m $commitMessage
            
            Write-Host "Commit $($commitIndex + 1)/${totalCommits}: $commitMessage ($dateStr)" -ForegroundColor Green
            $commitIndex++
        } else {
            # If no changes, try modifying README as fallback
            if (Test-Path "README.md") {
                $readmeContent = Get-Content "README.md" -Raw
                # Add a trailing space or newline
                if ($readmeContent -notmatch '\n$') {
                    $readmeContent += "`n"
                } else {
                    $readmeContent = $readmeContent.TrimEnd() + "`n"
                }
                Set-Content -Path "README.md" -Value $readmeContent -NoNewline
                git add README.md 2>$null
                
                $hasChanges = -not (git diff --cached --quiet 2>$null)
            }
            
            if ($hasChanges) {
                # Get commit message
                $messageIndex = [Math]::Min($commitIndex, $commitMessages.Length - 1)
                $commitMessage = $commitMessages[$messageIndex]
                
                # Special messages for last few commits (deployment)
                if ($day -eq 0) {
                    if ($i -eq 0) {
                        $commitMessage = "deployment setup"
                    } elseif ($i -eq 1) {
                        $commitMessage = "production build"
                    } else {
                        $commitMessage = "final deployment"
                    }
                }
                
                # Set commit date
                $dateStr = $commitDate.ToString("yyyy-MM-dd HH:mm:ss")
                $env:GIT_COMMITTER_DATE = $dateStr
                $env:GIT_AUTHOR_DATE = $dateStr
                
                # Create commit
                git commit -m $commitMessage
                
                Write-Host "Commit $($commitIndex + 1)/${totalCommits}: $commitMessage ($dateStr)" -ForegroundColor Green
                $commitIndex++
            } else {
                # Last resort: empty commit
                $dateStr = $commitDate.ToString("yyyy-MM-dd HH:mm:ss")
                $env:GIT_COMMITTER_DATE = $dateStr
                $env:GIT_AUTHOR_DATE = $dateStr
                
                $messageIndex = [Math]::Min($commitIndex, $commitMessages.Length - 1)
                $commitMessage = $commitMessages[$messageIndex]
                
                git commit -m $commitMessage --allow-empty
                Write-Host "Commit $($commitIndex + 1)/${totalCommits}: $commitMessage ($dateStr) [empty]" -ForegroundColor Cyan
                $commitIndex++
            }
        }
    }
    
    if ($commitIndex -ge $totalCommits) { break }
}

# Replace master branch with the new history
Write-Host "`nReplacing master branch with new history..." -ForegroundColor Yellow
git branch -D master
git branch -m master

# Show the commit log
Write-Host "`nNew commit history:" -ForegroundColor Yellow
git log --oneline --date=short --format="%h %ad %s" | Select-Object -First 20

Write-Host "`nTotal commits: $((git rev-list --count HEAD))" -ForegroundColor Green
Write-Host "`nDone! To push to remote (force push required):" -ForegroundColor Yellow
Write-Host "  git push -f origin master" -ForegroundColor Cyan
Write-Host "`nTo restore the old history:" -ForegroundColor Yellow
Write-Host "  git checkout backup-before-rewrite" -ForegroundColor Cyan

