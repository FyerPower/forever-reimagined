#!/usr/bin/env zsh

# Release script for FyerPower's Community Vanilla+ modpack
# This script helps create properly tagged releases

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Functions
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "pack/pack.toml" ]; then
    print_error "pack/pack.toml not found. Please run this script from the root of the modpack project."
    exit 1
fi

# Check if git is initialized and clean
if ! git status &>/dev/null; then
    print_error "This is not a git repository or git is not available."
    exit 1
fi

if [ -n "$(git status --porcelain)" ]; then
    print_warning "You have uncommitted changes. Please commit or stash them before creating a release."
    git status --short
    echo
    read -q "REPLY?Continue anyway? [y/N] "
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Release cancelled."
        exit 0
    fi
fi

# Get current version from pack.toml
current_version=$(grep '^version = ' pack/pack.toml | sed 's/version = "\(.*\)"/\1/')
if [ -z "$current_version" ]; then
    print_error "Could not read version from pack/pack.toml"
    exit 1
fi

print_info "Current version in pack.toml: $current_version"

# Ask for new version
echo
read "new_version?Enter the new version (e.g., 1.0.1): "

if [ -z "$new_version" ]; then
    print_error "Version cannot be empty."
    exit 1
fi

# Validate version format (basic semver check)
if [[ ! $new_version =~ ^[0-9]+\.[0-9]+\.[0-9]+(-.*)?$ ]]; then
    print_warning "Version '$new_version' doesn't follow semantic versioning (x.y.z)."
    read -q "REPLY?Continue anyway? [y/N] "
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_info "Release cancelled."
        exit 0
    fi
fi

# Check if tag already exists
if git rev-parse "v$new_version" >/dev/null 2>&1; then
    print_error "Tag 'v$new_version' already exists."
    exit 1
fi

# Update version in pack.toml
print_info "Updating version in pack/pack.toml..."
sed -i "s/^version = \".*\"/version = \"$new_version\"/" pack/pack.toml

# Verify the change
updated_version=$(grep '^version = ' pack/pack.toml | sed 's/version = "\(.*\)"/\1/')
if [ "$updated_version" != "$new_version" ]; then
    print_error "Failed to update version in pack.toml"
    exit 1
fi

print_success "Updated version from $current_version to $new_version"

# Ask for release notes
echo
print_info "Enter release notes (press Ctrl+D when finished, or just press Enter for auto-generated notes):"
echo "---"
release_notes=""
while IFS= read -r line; do
    release_notes="$release_notes$line\n"
done

# If no custom release notes provided, generate basic ones
if [ -z "$release_notes" ]; then
    release_notes="Release version $new_version\n\nSee the changelog for details about what's new in this version."
fi

echo
print_info "Committing version change..."
git add pack/pack.toml
git commit -m "Bump version to $new_version"

print_info "Creating and pushing tag 'v$new_version'..."
git tag -a "v$new_version" -m "Release $new_version

$release_notes"

# Push the commit and tag
git push origin $(git branch --show-current)
git push origin "v$new_version"

print_success "Tag 'v$new_version' created and pushed!"
print_info "GitHub Actions will now automatically create a release with packwiz exports."
print_info "You can monitor the progress at: https://github.com/$(git remote get-url origin | sed 's/.*github.com[:/]\([^/]*\/[^.]*\).*/\1/')/actions"