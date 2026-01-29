#!/bin/bash

# Publish Template Script
# Syncs framework code to template repository
# Usage: ./scripts/publish-template.sh <version>

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
TEMPLATE_REPO="git@github.com:gal099/playwright-ai-testing-template.git"
TEMP_DIR=$(mktemp -d)

# Function to print colored output
print_step() {
    echo -e "${BLUE}==>${NC} $1"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Function to cleanup on exit
cleanup() {
    if [ -d "$TEMP_DIR" ]; then
        rm -rf "$TEMP_DIR"
        print_step "Cleaned up temporary directory"
    fi
}
trap cleanup EXIT

# Check if version is provided
VERSION=$1
if [ -z "$VERSION" ]; then
    print_error "Usage: ./scripts/publish-template.sh <version>"
    echo "Example: ./scripts/publish-template.sh 1.9.0"
    exit 1
fi

# Validate version format (x.y.z)
if ! [[ "$VERSION" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    print_error "Invalid version format. Use semantic versioning: x.y.z"
    exit 1
fi

echo ""
print_step "Publishing template version v$VERSION..."
echo ""

# Step 1: Check if we're in the correct directory
if [ ! -f "CLAUDE-DEV.md" ]; then
    print_error "Must run from framework repository root (CLAUDE-DEV.md not found)"
    exit 1
fi

print_success "In framework repository"

# Step 2: Check if working directory is clean
if ! git diff-index --quiet HEAD --; then
    print_warning "Working directory has uncommitted changes"
    read -p "Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Step 3: Run tests
print_step "Running tests..."
if npm test; then
    print_success "All tests passed"
else
    print_error "Tests failed. Fix tests before publishing."
    exit 1
fi

# Step 4: Run create-template
print_step "Running create-template script..."
if npm run create-template; then
    print_success "Template created successfully"
else
    print_error "create-template failed"
    exit 1
fi

# Step 5: Clone template repository
print_step "Cloning template repository..."
if git clone "$TEMPLATE_REPO" "$TEMP_DIR"; then
    print_success "Template repository cloned"
else
    print_error "Failed to clone template repository"
    print_warning "Make sure the repository exists: $TEMPLATE_REPO"
    exit 1
fi

# Step 6: Sync changes (exclude dev-only files)
print_step "Syncing changes to template..."

# Files/directories to exclude from template
EXCLUDE_PATTERNS=(
    ".git"
    "CLAUDE-DEV.md"
    "TODO_framework.md"
    "new_ideas"
    "scripts/publish-template.sh"
    ".claude/commands/improve-framework.md"
    ".claude/commands/fix-framework.md"
    ".claude/commands/start-dev.md"
    ".claude/commands/context-dev.md"
    ".claude/commands-user"
    "node_modules"
    "test-results"
    "playwright-report"
    ".env"
)

# Build rsync exclude options
RSYNC_EXCLUDES=""
for pattern in "${EXCLUDE_PATTERNS[@]}"; do
    RSYNC_EXCLUDES="$RSYNC_EXCLUDES --exclude=$pattern"
done

# Sync with rsync
if rsync -av $RSYNC_EXCLUDES ./ "$TEMP_DIR/"; then
    print_success "Files synced to template"
else
    print_error "Failed to sync files"
    exit 1
fi

# Step 7: Rename context-user.md to context.md in template
print_step "Configuring template commands..."
if [ -f "$TEMP_DIR/.claude/commands/context-user.md" ]; then
    mv "$TEMP_DIR/.claude/commands/context-user.md" "$TEMP_DIR/.claude/commands/context.md"
    print_success "Renamed context-user.md to context.md"
fi

# Step 8: Update package.json in template
print_step "Updating template package.json..."
cd "$TEMP_DIR"

# Update package name to template
if command -v jq > /dev/null; then
    # Use jq if available (cleaner)
    jq '.name = "playwright-ai-testing-template"' package.json > package.json.tmp
    mv package.json.tmp package.json
    print_success "Updated package name to playwright-ai-testing-template"
else
    # Fallback to sed
    sed -i.bak 's/"playwright-ai-testing-framework"/"playwright-ai-testing-template"/' package.json
    rm package.json.bak
    print_success "Updated package name (using sed)"
fi

# Step 9: Commit changes
print_step "Committing changes to template repository..."

git add .

if git diff --cached --quiet; then
    print_warning "No changes to commit (template already up-to-date)"
    exit 0
fi

git commit -m "Release v$VERSION

Synced from playwright-ai-testing-framework v$VERSION

Changes:
- Updated framework code to v$VERSION
- See framework CHANGELOG for detailed changes
- Based on commit: $(cd - > /dev/null && git rev-parse --short HEAD)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

print_success "Changes committed"

# Step 10: Create git tag
print_step "Creating git tag v$VERSION..."
if git tag -a "v$VERSION" -m "Release v$VERSION"; then
    print_success "Tag created"
else
    print_warning "Tag may already exist"
fi

# Step 11: Push to remote
print_step "Pushing to template repository..."
if git push origin main && git push origin "v$VERSION"; then
    print_success "Pushed to remote"
else
    print_error "Failed to push. You may need to push manually."
    echo "  cd $TEMP_DIR"
    echo "  git push origin main"
    echo "  git push origin v$VERSION"
    exit 1
fi

# Step 12: Print summary
cd - > /dev/null

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
print_success "Template published successfully!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  📦 Version: v$VERSION"
echo "  🔗 Template repo: https://github.com/gal099/playwright-ai-testing-template"
echo "  🏷️  Tag: v$VERSION"
echo ""
echo "Next steps:"
echo "  1. Verify template: git clone $TEMPLATE_REPO"
echo "  2. Test template: cd playwright-ai-testing-template && npm install && npm test"
echo "  3. Create GitHub release (optional):"
echo "     gh release create v$VERSION --repo gal099/playwright-ai-testing-template"
echo ""
